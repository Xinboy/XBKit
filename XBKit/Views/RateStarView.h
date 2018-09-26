//
//  RateStarView.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/5/17.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RateStarStyle) {
    RateStarStyleWhole = 0,
    RateStarStyleHalf,
    RateStarStyleIncomplete,
};

typedef void(^CompleteBlock)(CGFloat currentScore);

@interface RateStarView : UIView

@property (nonatomic, assign, getter = isAnimation) BOOL animation;

@property (nonatomic, assign) RateStarStyle rateStyle;

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(RateStarStyle)rateStyle
                  isAnination:(BOOL)isAnimation
                       finish:(CompleteBlock)finishBlock;

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars;
@end

