//
//  PlaceholderView.m
//  XJPH
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "PlaceholderView.h"

@implementation PlaceholderView


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0f];
        [self addSubview:self.iconImageView];
        [self addSubview:self.infoLabel];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self setupMasonry];
    [self layoutIfNeeded];
}

- (void)setupMasonry {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-40);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(114);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(18);
    }];

}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.image = [UIImage imageNamed:@"placeholder_icon_norecord"];
    }
    return _iconImageView;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.font = [UIFont fontWithName:kMediumPingFang() autoSize:18];
        self.infoLabel.textColor = [UIColor colorWithHexInt:0xCCCCCC];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.text = @"暂时没有记录哦";
    }
    return _infoLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
