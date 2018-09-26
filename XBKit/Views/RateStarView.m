//
//  RateStarView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/5/17.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "RateStarView.h"

static NSString *const kForegroundStarImageName = @"icon_star_yellow";
static NSString *const kBackgroundStarImageName = @"icon_star_gray";

@interface RateStarView ()

@property (nonatomic, strong) UIView *bgStarView;

@property (nonatomic, strong) UIView *fgStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic, assign) CGFloat currentScore;

@property (nonatomic, copy) CompleteBlock completeBlock;

@end

@implementation RateStarView

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(RateStarStyle)rateStyle
                  isAnination:(BOOL)isAnimation
                       finish:(CompleteBlock)finishBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.rateStyle = rateStyle;
        self.animation = isAnimation;
        if (finishBlock) {
            self.completeBlock = finishBlock;
        }
        [self creatStarView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRateStarActionWithTapGestureRecognizer:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars {
    return [self initWithFrame:frame numberOfStars:numberOfStars rateStyle:RateStarStyleIncomplete isAnination:true finish:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:5 rateStyle:RateStarStyleWhole isAnination:true finish:nil];
}

- (void)creatStarView {
    self.fgStarView = [self starViewWithImageName:kForegroundStarImageName];
    self.bgStarView = [self starViewWithImageName:kBackgroundStarImageName];
    
    self.fgStarView.frame = CGRectMake(0, 0, self.bounds.size.width * self.currentScore / self.numberOfStars, self.bounds.size.height);
    
    
    [self addSubview:self.bgStarView];
    [self addSubview:self.fgStarView];
}

- (UIView *)starViewWithImageName:(NSString *)imageName {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.clipsToBounds = true;
    bgView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < self.numberOfStars; i++) {
        UIImageView *starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        starImageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        starImageView.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:starImageView];
    }
    return bgView;
}

- (void)showRateStarActionWithTapGestureRecognizer:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self];
    CGFloat offset = point.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (self.rateStyle) {
        case RateStarStyleIncomplete: {
            self.currentScore = ceil(realStarScore);
            break;
        }
        case RateStarStyleWhole: {
            self.currentScore = roundf(realStarScore) > realStarScore ? ceil(realStarScore) : (ceil(realStarScore) - 0.5);
            break;
        }
        case RateStarStyleHalf: {
            self.currentScore = realStarScore;
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak RateStarView *weakSelf = self;
    CGFloat animationTimeInterval = self.animation ? 0.2 : 0.0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.fgStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore / self.numberOfStars, weakSelf.bounds.size.height);
    }];
}

- (void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if (self.completeBlock) {
        self.completeBlock(_currentScore);
    }
    
    [self setNeedsLayout];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
