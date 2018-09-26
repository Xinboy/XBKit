//
//  PopMenuView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/9.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "PopMenuView.h"

//NS_INLINE CGFloat kScreenHeiht() {
//    return [UIScreen mainScreen].bounds.size.height;
//}
//
//NS_INLINE CGFloat kScreenWidth() {
//    return [UIScreen mainScreen].bounds.size.width;
//}

static const CGFloat kRowHeight = 44;

static const CGFloat kTableViewHeight = 320;

static NSString *const kShowCellIdentifer = @"ShowCell";
static NSString *const kLeftCellIdentifer = @"LeftCell";

@interface PopMenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UITableView *showTableView;
//地区时需要二级联动??
@property (nonatomic, strong) UITableView *areaTabelView;

@end

@implementation PopMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self initMenuButton];
        [self addSubview:self.areaTabelView];
        [self addSubview:self.showTableView];
    }
    return self;
}



#pragma mark - 私有方法

- (void)initMenuButton {
    CGFloat itemWidth = kScreenWidth() / self.menuCount;
    for (int i = 0; i < self.menuCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemWidth * i, 0, itemWidth, 40);
        [button setImage:[UIImage imageNamed:@"arrow_icon_down"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"arrow_icon_up"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitle:self.itemsArray[i] forState:UIControlStateNormal];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.image.size.width, 0, button.imageView.image.size.width)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
        [self addSubview:button];
    }
}

- (UITableView *)showTableView {
    if (!_showTableView) {
        self.showTableView = [[UITableView alloc] init];
        self.showTableView.frame = CGRectMake(0, 0, kScreenWidth(), 0);
        self.showTableView.delegate = self;
        self.showTableView.dataSource = self;
        [self.showTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kShowCellIdentifer];
        self.showTableView.rowHeight = kRowHeight;
    }
    return _showTableView;
}

- (UITableView *)areaTabelView {
    if (!_areaTabelView) {
        self.areaTabelView = [[UITableView alloc] init];
        self.areaTabelView.frame = CGRectMake(0, 0, kScreenWidth() / 3, 0);
        self.areaTabelView.delegate = self;
        self.areaTabelView.dataSource = self;
        [self.areaTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLeftCellIdentifer];
        self.areaTabelView.rowHeight = kRowHeight * 1.5;
    }
    return _areaTabelView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
