//
//  CalendarCollectionViewCell.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *dayLabel;

- (void)changeDayLabelIsSelected;
@end
