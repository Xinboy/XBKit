//
//  UIView+placeholderView2.m
//  PlaceholderView
//
//  Created by Xinbo Hong on 2017/10/8.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "UIView+placeholderView2.h"
#import <objc/runtime.h>
@interface UIView ()

@property (nonatomic, copy) reloadButtonAction reloadButtonAction;

@property (nonatomic, strong) UIView *placeholderView;

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL originalScrollEnabled;


@end


@implementation UIView (placeholderView)

#pragma mark - **************** 手动 getter/setter 加载

static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;
static void *reloadButtonActionKey = &reloadButtonActionKey;

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setOriginalScrollEnabled:(BOOL)originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (reloadButtonAction)reloadButtonAction {
    return objc_getAssociatedObject(self, &reloadButtonActionKey);
}

- (void)setReloadButtonAction:(reloadButtonAction)reloadButtonAction {
    objc_setAssociatedObject(self, &reloadButtonActionKey, reloadButtonAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - **************** 外露接口
- (void)showPlaceholerViewWithType:(PlaceholderViewType)type reloadBlock:(reloadButtonAction)reloadBlock {
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
    }
    
    [self createPlaceHolderView];
    
    self.reloadButtonAction = reloadBlock;
    
    NSArray *subViewsArray = [self.placeholderView subviews];
    UIImageView *imageView = nil;
    UILabel *label = nil;
    for (id view in subViewsArray) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)view;
            continue;
        }
        if ([view isMemberOfClass:[UILabel class]]) {
            label = (UILabel *)view;
            continue;
        }
    }
    switch (type) {
        case PlaceholderViewTypeNoNetwork: {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"无商品" ofType:@"png"];
            imageView.image = [UIImage imageWithContentsOfFile:path];
            label.text = NSLocalizedString(@"一点网络都没有，这怎么玩呀", nil);
            break;
        }
        case PlaceholderViewTypeOther: {
            label.text = NSLocalizedString(@"未知错误", nil);
            break;
        }
    }
    
}

#pragma mark - **************** 外露接口，内部实现部分
- (void)placeholderViewReloadButtonAction:(UIButton *)button {
    if (self.reloadButtonAction) {
        self.reloadButtonAction();
    }
    [self removePlaceholderView];
}

- (void)createPlaceHolderView {
    self.placeholderView = [[UIView alloc] init];
    [self addSubview:self.placeholderView];
    self.placeholderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.placeholderView.superview.frame), CGRectGetHeight(self.placeholderView.superview.frame));
    self.placeholderView.center = self.placeholderView.superview.center;
    self.placeholderView.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    NSLog(@"%@",NSStringFromCGRect(self.placeholderView.superview.frame));
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.placeholderView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 70, 70);
    imageView.center = CGPointMake(imageView.superview.center.x, imageView.superview.center.y - 80);
    
    UILabel *desLabel = [[UILabel alloc] init];
    [self.placeholderView addSubview:desLabel];
    desLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20, CGRectGetWidth(desLabel.superview.frame), 20);
    desLabel.textColor = [UIColor blackColor];
    desLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *reloadButton = [[UIButton alloc] init];
    [self.placeholderView addSubview:reloadButton];
    reloadButton.frame = CGRectMake(0, 0, 120, 30);
    reloadButton.center = CGPointMake(imageView.superview.center.x, CGRectGetMaxY(desLabel.frame) + 40);
    [reloadButton setTitle:NSLocalizedString(@"重新加载", nil) forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reloadButton.layer.borderWidth = 1.0f;
    reloadButton.layer.borderColor = [UIColor blackColor].CGColor;
    [reloadButton addTarget:self action:@selector(placeholderViewReloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];   
}

- (void)removePlaceholderView {
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.originalScrollEnabled;
    }
}

@end





