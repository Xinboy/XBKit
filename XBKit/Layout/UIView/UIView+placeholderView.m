//
//  UIView+placeholderView2.m
//  PlaceholderView
//
//  Created by Xinbo Hong on 2017/10/8.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "UIView+placeholderView.h"
#import <objc/runtime.h>
#import "PlaceholderView.h"
@interface UIView ()

@property (nonatomic, copy) reloadButtonAction reloadButtonAction;

//自定义的蒙版图
@property (nonatomic, strong) PlaceholderView *placeholderView;

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign, getter=isOriginalScrollEnabled) BOOL originalScrollEnabled;


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
- (void)showPlaceholderView {
    [self showPlaceholerViewWithType:PlaceholderViewTypeOther reloadBlock:nil];
}

- (void)showPlaceholerViewWithType:(PlaceholderViewType)type reloadBlock:(reloadButtonAction)reloadBlock {
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
    }
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
        scrollView.scrollEnabled = NO;
    }
    
    /** 占位图*/
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    self.placeholderView = [[PlaceholderView alloc] init];
    self.placeholderView.backgroundColor = self.backgroundColor;
    
    [self addSubview:self.placeholderView];
    
    /*使用 frame 或 masonry 根据实际项目进行选择*/
    self.placeholderView.frame = self.bounds;
//    [self.placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.size.equalTo(self);
//    }];
    
    if (reloadBlock) {
        self.reloadButtonAction = reloadBlock;
    }
    
    /*可以在这里根据不同的情况对placeholderView的样式进行更改*/
    //...
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





