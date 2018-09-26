//
//  PieChartView.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/24.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    饼图
 *  控件完成情况: 未完成
 *  最后记录时间: 2018/4/24
 */


#import <UIKit/UIKit.h>

@interface PieChartView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *titleStr;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title DataArray:(NSMutableArray *)dataArray;

@end
