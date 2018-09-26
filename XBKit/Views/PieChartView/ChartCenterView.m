//
//  ChartCenterView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/24.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "ChartCenterView.h"


@interface ChartCenterView ()

@property (nonatomic, strong) UIView *centerBgView;

@end

@implementation ChartCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        self.layer.masksToBounds = true;
        
        [self.centerBgView addSubview:self.centerLabel];
        [self addSubview:self.centerBgView];
        
    }
    return self;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        self.centerLabel = [[UILabel alloc] init];
        self.centerLabel.frame = self.bounds;
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        self.centerLabel.font = [UIFont systemFontOfSize:18];
        self.centerLabel.textColor = [UIColor blackColor];
        self.centerLabel.backgroundColor = [UIColor clearColor];
    }
    return _centerLabel;
}

- (UIView *)centerBgView {
    if (!_centerBgView) {
        self.centerBgView = [[UIView alloc] init];
        self.centerBgView.frame = CGRectMake(6, 6, self.bounds.size.width - 6 * 2, self.bounds.size.height - 6 * 2);
        self.centerBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        self.centerBgView.layer.masksToBounds = true;
        self.centerBgView.layer.cornerRadius = self.centerBgView.frame.size.height * 0.5;
    }
    return _centerBgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
