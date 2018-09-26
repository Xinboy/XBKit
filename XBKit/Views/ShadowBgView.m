//
//  ShadowBgView.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/7/13.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "ShadowBgView.h"

@interface ShadowBgView ()

@end


@implementation ShadowBgView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 9.0;
        self.layer.cornerRadius = 9.0;
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    self.layer.shadowColor = self.shadowColor.CGColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    self.layer.shadowColor = self.shadowColor.CGColor;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    _shadowOpacity = shadowOpacity;
    self.layer.shadowOpacity = self.shadowOpacity;
}
- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    self.layer.shadowRadius = self.shadowRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = self.cornerRadius;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
