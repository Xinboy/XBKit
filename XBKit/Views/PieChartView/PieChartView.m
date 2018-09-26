//
//  PieChartView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/24.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "PieChartView.h"
#import "ChartCenterView.h"
#import "ChartModel.h"

static const CGFloat kChartMagrin  = 60;
@interface PieChartView ()

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *colorArray;

@property (nonatomic, strong) NSArray *showColorArray;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) ChartCenterView *chartCenterView;
@end

@implementation PieChartView

- (void)drawRect:(CGRect)rect {
    CGFloat minSide = self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height : self.bounds.size.width;
    CGPoint center = self.center;
    CGFloat radius = minSide * 0.5 - kChartMagrin;
    CGFloat start = 0;
    CGFloat end = 0;
    
    if (self.dataArray.count == 0) {
        end = start + M_PI * 2;
        
        UIColor *color = self.showColorArray.firstObject;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
        [color set];
        
        [path addLineToPoint:center];
        [path fill];
    } else {
        NSMutableArray *pointArray = [NSMutableArray array];
        NSMutableArray *centerArray = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            ChartModel *model = self.dataArray[i];
            CGFloat rate = model.rate;
            UIColor *color = self.showColorArray[i];
            
            start = end;
            CGFloat angel = rate * M_PI * 2;
            end = start + angel;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
            [color set];
            [path addLineToPoint:center];
            [path fill];
            
            CGFloat arcCenter = (start + end) * 0.5;
            CGPoint lineStartPoint = CGPointMake(self.frame.size.width * 0.5 + radius * cos(arcCenter), self.frame.size.height * 0.5 + radius * sin(arcCenter));
            
            [pointArray addObject:[NSValue valueWithCGPoint:lineStartPoint]];
            [centerArray addObject:[NSNumber numberWithFloat:arcCenter]];
            [self.modelArray addObject:model];
            [self.colorArray addObject:color];
            
        }
    }
    
    
}


#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame Title:nil DataArray:nil];
}

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title {
    return [self initWithFrame:frame Title:title DataArray:nil];
}

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title DataArray:(NSMutableArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.centerView];
        if (title.length > 0) {
            self.chartCenterView.centerLabel.text = title;
        }
        
        if (dataArray.count > 0) {
            self.dataArray = dataArray;
        }
        
    }
    return self;
}

- (void)initProperty {
    self.showColorArray = @[[UIColor colorWithRed:251/255.0 green:166.9/255.0 blue:96.5/255.0 alpha:1],
                            [UIColor colorWithRed:151.9/255.0 green:188/255.0 blue:95.8/255.0 alpha:1],
                            [UIColor colorWithRed:245/255.0 green:94/255.0 blue:102/255.0 alpha:1],
                            [UIColor colorWithRed:29/255.0 green:140/255.0 blue:140/255.0 alpha:1],
                            [UIColor colorWithRed:121/255.0 green:113/255.0 blue:199/255.0 alpha:1],
                            [UIColor colorWithRed:16/255.0 green:149/255.0 blue:224/255.0 alpha:1]];
    
}

#pragma mark - lazy
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        self.colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        self.modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
