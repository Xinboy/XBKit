//
//  UIView+Animation.h
//  SearchToilet
//
//  Created by Xinbo Hong on 2017/11/3.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShakeDirection) {
    ShakeDirectionHorizontal = 0,
    ShakeDirectionVertical,
};

@interface UIView (Animation)

//震荡动画
- (void)shakeAnimationWithTranslation:(ShakeDirection)shakeDirection
                           ShakeTimes:(NSInteger)times
                        ShakeInterval:(NSTimeInterval)interval
                           Shakedelta:(CGFloat)delta
                      shakeCompletion:(void(^)(void))completionBlock;
@end
