//
//  UIView+Animation.m
//  SearchToilet
//
//  Created by Xinbo Hong on 2017/11/3.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)shakeAnimationWithTranslation:(ShakeDirection)shakeDirection
                           ShakeTimes:(NSInteger)times
                        ShakeInterval:(NSTimeInterval)interval
                           Shakedelta:(CGFloat)delta
                      shakeCompletion:(void(^)(void))completionBlock {
    [UIView animateWithDuration:interval animations:^{
        switch (shakeDirection) {
            case ShakeDirectionHorizontal:
                [self.layer setAffineTransform:CGAffineTransformMakeTranslation(delta, 0)];
                break;
            case ShakeDirectionVertical:
                [self.layer setAffineTransform:CGAffineTransformMakeTranslation(0, delta)];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (times == 0) {
            [UIView animateWithDuration:interval animations:^{
                [self.layer setAffineTransform:CGAffineTransformIdentity];
            } completion:^(BOOL finished) {
                completionBlock();
            }];
        } else {
            [self shakeAnimationWithTranslation:shakeDirection ShakeTimes:times - 1 ShakeInterval:interval Shakedelta:delta shakeCompletion:completionBlock];
        }
        
    }];
}

@end
