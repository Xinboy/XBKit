//
//  CircleRectCell.m
//  XJPH
//
//  Created by Xinbo Hong on 2018/6/17.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "CircleRectBaseCell.h"

#define kContentViewWidth self.contentView.frame.size.width
#define kContentViewHeight self.contentView.frame.size.height

static NSString *const kBaseCellIdentifier = @"BaseCell";

@implementation CircleRectBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CircleRectBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseCellIdentifier];
    if (!cell) {
        cell = [[CircleRectBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBaseCellIdentifier];
    }
    //一定要这里设置style，而不能在上面的判断里面，因为cell重用的时候，只要有不同的地方都应该重新设置，否则拿到cell的style就是上一个的样式而自己却没有进行修改
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.borderStyle = CellBorderStyleAllRound;
    } else if (indexPath.row == 0) {
        cell.borderStyle = CellBorderStyleTopRound;
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.borderStyle = CellBorderStyleBottomRound;
    } else {
        cell.borderStyle = CellBorderStyleNoRound;
    }
    return cell;
}

- (void)setBorderStyleWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        self.borderStyle = CellBorderStyleAllRound;
    } else if (indexPath.row == 0) {
        self.borderStyle = CellBorderStyleTopRound;
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        self.borderStyle = CellBorderStyleBottomRound;
    } else {
        self.borderStyle = CellBorderStyleNoRound;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //在这里设置才能获取到真正显示时候的宽度，而不是原始的
    [self setupBorder];
}

- (void)setupBorder {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = self.contentBorderWidth;
    layer.strokeColor = self.contentBorderColor.CGColor;
    layer.fillColor =  self.contentBackgroundColor.CGColor;
    
    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [view.layer insertSublayer:layer atIndex:0];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(12, kContentViewHeight - 0.5, kContentViewWidth, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithWhite:234 / 255.0 alpha:1.0f];
    if (self.borderStyle != CellBorderStyleBottomRound) {
        [view addSubview:bottomLine];
    }
    //用自定义的view代替cell的backgroundView
    self.backgroundView = view;
    
    CGRect rect = CGRectMake(self.contentMargin, 0, kContentViewWidth - 2 * self.contentMargin, kContentViewHeight);
    switch (self.borderStyle) {
        case CellBorderStyleNoRound: {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
            layer.path = path.CGPath;
        }
            break;
        case CellBorderStyleTopRound: {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        case CellBorderStyleBottomRound: {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        case CellBorderStyleAllRound: {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
