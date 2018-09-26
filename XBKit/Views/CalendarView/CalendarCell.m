//
//  CalendarCollectionViewCell.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "CalendarCell.h"

@interface CalendarCell ()

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *bgColor;

@end


@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        [self addSubview:self.monthLabel];
        [self addSubview:self.dayLabel];
    }
    return self;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        self.monthLabel = [[UILabel alloc] init];
        self.monthLabel.frame = CGRectMake(0, 0, 20, 20);
        self.monthLabel.textAlignment = NSTextAlignmentCenter;
        self.monthLabel.backgroundColor = self.bgColor;
        self.monthLabel.textColor = self.textColor;
        self.monthLabel.hidden = true;
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        CGFloat space = 20;
        CGFloat side = CGRectGetWidth(self.frame) - space * 2;
        self.dayLabel = [[UILabel alloc] init];
        self.dayLabel.frame = CGRectMake(0, 0, side, side);
        self.dayLabel.center = self.center;
        self.dayLabel.layer.masksToBounds = true;
        self.dayLabel.layer.cornerRadius = CGRectGetHeight(self.dayLabel.frame) * 0.5;
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.backgroundColor = self.bgColor;
        self.dayLabel.textColor = self.textColor;
    }
    return _dayLabel;
}

- (void)changeDayLabelIsSelected {
    if (self.isSelected) {
        self.dayLabel.backgroundColor = self.textColor;
        self.dayLabel.textColor = self.bgColor;
    } else {
        self.dayLabel.backgroundColor = self.bgColor;
        self.dayLabel.textColor = self.textColor;
    }
}

@end
