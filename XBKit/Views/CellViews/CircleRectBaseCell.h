//
//  CircleRectCell.h
//  XJPH
//
//  Created by Xinbo Hong on 2018/6/17.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

//圆角Cell子类，需继承他

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CellBorderStyle) {
    CellBorderStyleNoRound = 0,
    CellBorderStyleTopRound,
    CellBorderStyleBottomRound,
    CellBorderStyleAllRound,
};

@interface CircleRectBaseCell : UITableViewCell

/** 边框类型*/
@property (nonatomic, assign) CellBorderStyle borderStyle;
/** 边框颜色*/
@property (nonatomic, strong) UIColor *contentBorderColor;
/** 边框内部内容颜色*/
@property (nonatomic, strong) UIColor *contentBackgroundColor;
/** 边框的宽度，这个宽度的一半会延伸到外部*/
@property (nonatomic, assign) CGFloat contentBorderWidth;
/** 左右距离父视图的边距*/
@property (nonatomic, assign) CGFloat contentMargin;
/** 边框的圆角*/
@property (nonatomic, assign) CGSize contentCornerRadius;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
//设置borderStyle
- (void)setBorderStyleWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
