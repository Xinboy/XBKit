//
//  GesturesView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/20.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "GesturesView.h"
#import "PointView.h"
#import "UIColor+XBCategory.h"

@interface GesturesView ()

@property (nonatomic, strong) NSMutableArray *pointViewArray;

@property (nonatomic, strong) NSMutableArray *selectedPointViewArray;

@property (nonatomic, strong) NSMutableArray *selectedViewCenterArray;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, strong) UIBezierPath *linePath;

@property (nonatomic, assign, getter=isTouchEnd) BOOL touchEnd;

@end

@implementation GesturesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.touchEnd = NO;
        self.selectedColor = [UIColor XBColorWithRed:30.0 green:180.0 blue:244.0 alpha:1.0];
        
        self.startPoint = CGPointZero;
        self.endPoint = CGPointZero;
        for (int i = 0; i < 9; i++) {
            PointView *pointView = [[PointView alloc] initWithFrame:CGRectMake((i % 3) * (self.bounds.size.width / 2.0 - 31.0) + 1, (i / 3) * (self.bounds.size.height / 2.0 - 31.0) + 1, 60, 60)
                                                             WithID:[NSString stringWithFormat:@"gestures %d",i + 1]];
            [self addSubview:pointView];
            [self.pointViewArray addObject:pointView];
        }
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isTouchEnd) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (PointView *pointView in self.pointViewArray) {
        if (CGRectContainsPoint(pointView.frame, point)){
            //如果开始按钮为zero，记录开始按钮，否则不需要记录开始按钮
            if (CGPointEqualToPoint(self.startPoint, CGPointZero)) {
                self.startPoint = pointView.center;
            }
            //判断该手势按钮的中心点是否记录，未记录则记录
            if (![self.selectedViewCenterArray containsObject:[NSValue valueWithCGPoint:pointView.center]]) {
                [self.selectedViewCenterArray addObject:[NSValue valueWithCGPoint:pointView.center]];
            }
            //判断该手势按钮是否已经选中，未选中就选中
            if (![self.selectedPointViewArray containsObject:pointView.ID]) {
                [self.selectedPointViewArray addObject:pointView.ID];
                pointView.selected = YES;
            }
        }
    }
    if (!CGPointEqualToPoint(self.startPoint, CGPointZero)) {
        self.endPoint = point;
        [self drawLine];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.endPoint = [self.selectedViewCenterArray.lastObject CGPointValue];
    
    if (CGPointEqualToPoint(self.endPoint, CGPointZero)) {
        return;
    }
    [self drawLine];
    
    self.touchEnd = YES;
    if (self.gestureBlock && self.settingBlock) {
        if (self.selectedPointViewArray.count < 4) {
            self.touchEnd = NO;
            for (PointView *view in self.pointViewArray) {
                view.selected = NO;
            }
            [self.lineLayer removeFromSuperlayer];
            [self.selectedPointViewArray removeAllObjects];
            [self.selectedViewCenterArray removeAllObjects];
            self.startPoint = CGPointZero;
            self.endPoint = CGPointZero;
            if (self.settingBlock) {
                self.settingBlock();
            }
            return;
        }
        self.gestureBlock(self.selectedPointViewArray);
        return;
    }
    
    NSArray *selectID = [[NSUserDefaults standardUserDefaults] objectForKey:@"GestureLockKey"];
    
    if ([self.selectedPointViewArray isEqualToArray:selectID]) {
        for (PointView *view in self.pointViewArray) {
            view.success = NO;
        }
        //成功颜色（绿）
        self.lineLayer.strokeColor = [UIColor XBColorWithRed:43.0 green:210.0 blue:110.0 alpha:1.0].CGColor;
        if (self.unlockBlock) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.unlockBlock(YES);
            });
        }
    } else {
        for (PointView *view in self.pointViewArray) {
            view.error = YES;
        }
        //失败颜色（红）
        self.lineLayer.strokeColor = [UIColor XBColorWithRed:222.0 green:64.0 blue:60.0 alpha:1.0].CGColor;
        if (self.unlockBlock) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.unlockBlock(NO);
            });
        }
    }
    
}

- (void)drawLine {
    if (self.isTouchEnd) {
        return;
    }
    
    [self.lineLayer removeFromSuperlayer];
    [self.linePath removeAllPoints];
    
    [self.linePath moveToPoint:self.startPoint];
    for (NSValue *pointValue in self.selectedViewCenterArray) {
        [self.linePath addLineToPoint:[pointValue CGPointValue]];
    }
    [self.linePath addLineToPoint:self.endPoint];
    self.lineLayer.path = self.linePath.CGPath;
    self.lineLayer.lineWidth = 4.0;
    self.lineLayer.strokeColor = self.selectedColor.CGColor;
    self.lineLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.lineLayer];
    self.layer.masksToBounds = YES;
    
}
#pragma mark - **************** Getter and setter

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
}

- (NSMutableArray *)pointViewArray {
    if (!_pointViewArray) {
        self.pointViewArray = [NSMutableArray arrayWithCapacity:9];
    }
    return _pointViewArray;
}

- (NSMutableArray *)selectedPointViewArray {
    if (!_selectedPointViewArray) {
        self.selectedPointViewArray = [NSMutableArray array];
    }
    return _selectedPointViewArray;
}

- (NSMutableArray *)selectedViewCenterArray {
    if (!_selectedViewCenterArray) {
        self.selectedViewCenterArray = [NSMutableArray array];
    }
    return _selectedViewCenterArray;
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        self.lineLayer = [CAShapeLayer layer];
    }
    return _lineLayer;
}

- (UIBezierPath *)linePath {
    if (!_linePath) {
        self.linePath = [UIBezierPath bezierPath];
    }
    return _linePath;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
