//
//  PointView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/20.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "PointView.h"
#import "UIColor+XBCategory.h"

@interface PointView ()

@property (nonatomic, strong) CAShapeLayer *contentLayer;

@property (nonatomic, strong) CAShapeLayer *borderLayer;

@property (nonatomic, strong) CAShapeLayer *centerLayer;

@property (nonatomic, copy, readwrite) NSString *ID;

@end

@implementation PointView

- (instancetype)initWithFrame:(CGRect)frame WithID:(NSString *)ID {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ID = ID;
        
        [self.layer addSublayer:self.contentLayer];
        [self.layer addSublayer:self.borderLayer];
        [self.layer addSublayer:self.centerLayer];
        
        self.centerLayer.hidden = YES;
        self.selectedColor = [UIColor XBColorWithRed:30.0 green:180.0 blue:244.0 alpha:1.0];
    }
    return self;
}



#pragma mark - **************** Getter and setter
//根据情况显示三种状态
- (void)setSuccess:(BOOL)success {
    _success = success;
    if (self.isSuccess) {
        self.centerLayer.fillColor = [UIColor XBColorWithRed:43.0 green:210.0 blue:11.0 alpha:1.0].CGColor;
    } else {
        self.centerLayer.fillColor = self.selectedColor.CGColor;
    }
}

- (void)setError:(BOOL)error {
    _error = error;
    if (self.isError) {
        self.centerLayer.fillColor = [UIColor XBColorWithRed:222.0 green:64.0 blue:60.0 alpha:1.0].CGColor;
    } else {
        self.centerLayer.fillColor = self.selectedColor.CGColor;
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (self.isSelected) {
        self.centerLayer.hidden = NO;
        self.centerLayer.fillColor = self.selectedColor.CGColor;
    } else {
        self.centerLayer.hidden = YES;
        self.borderLayer.fillColor = [UIColor XBColorWithRed:105.0 green:108.0 blue:111.0  alpha:1.0].CGColor;
    }
}


- (CAShapeLayer *)contentLayer {
    if (!_contentLayer) {
        self.contentLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(2.0, 2.0, self.bounds.size.width - 4.0, self.bounds.size.height - 4.0) cornerRadius:(self.bounds.size.width - 4.0) / 2.0];
        self.contentLayer.path = path.CGPath;
        self.contentLayer.fillColor = [UIColor XBColorWithRed:46.0 green:47.0 blue:50.0 alpha:1.0].CGColor;
        self.contentLayer.strokeColor = [UIColor XBColorWithRed:26.0 green:27.0 blue:29.0 alpha:1.0].CGColor;
        self.contentLayer.strokeStart = 0;
        self.contentLayer.strokeEnd = 1;
        self.contentLayer.lineWidth = 2;
        self.contentLayer.cornerRadius = self.bounds.size.width / 2.0;
    }
    return _contentLayer;
}

- (CAShapeLayer *)borderLayer {
    if (!_borderLayer) {
        self.borderLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 startAngle:0 endAngle:2 * M_PI clockwise:NO];
        self.borderLayer.path = path.CGPath;
        self.borderLayer.strokeColor = [UIColor XBColorWithRed:105.0 green:108.0 blue:111.0 alpha:1.0].CGColor;
        self.borderLayer.strokeStart = 0;
        self.borderLayer.strokeEnd = 1;
        self.borderLayer.lineWidth = 2;
    }
    return _borderLayer;
}

- (CAShapeLayer *)centerLayer {
    if (!_centerLayer) {
        self.centerLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.bounds.size.width / 2.0 - (self.bounds.size.width - 4.0) / 4.0, self.bounds.size.height / 2.0 - (self.bounds.size.height - 4.0) / 4.0, (self.bounds.size.width - 4.0) / 2.0, (self.bounds.size.height - 4.0) / 2.0) cornerRadius:(self.bounds.size.width - 4.0) / 2.0];
        self.centerLayer.path = path.CGPath;
        self.centerLayer.lineWidth = 3;
        self.centerLayer.strokeColor = [UIColor colorWithWhite:0 alpha:0.7].CGColor;
        self.centerLayer.fillColor = [UIColor XBColorWithRed:30.0 green:180.0 blue:244.0 alpha:1.0].CGColor;
    }
    return _centerLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
