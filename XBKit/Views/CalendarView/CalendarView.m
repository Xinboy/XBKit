//
//  CalendarView.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarCell.h"
#import "NSDate+XBCategory.h"
static NSString *const kWeekDayArray[7] = {@"日",@"一",@"二",@"三",@"四",@"五",@"六"};

@interface CalendarView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *calendarCollectionView;

@property (nonatomic, strong) UIView *weekTitleView;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) NSInteger startIndexRow;

@end

@implementation CalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.itemWidth = CGRectGetWidth(self.frame) / 7;
        
        [self addSubview:self.weekTitleView];
        [self addSubview:self.calendarCollectionView];
    }
    return self;
}

- (UIView *)weekTitleView {
    if (!_weekTitleView) {
        self.weekTitleView = [[UIView alloc] init];
        self.weekTitleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 20);
        
        for (int i = 0; i < 7; i++) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(i * self.itemWidth, 0, self.itemWidth, self.weekTitleView.frame.size.height);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.text = kWeekDayArray[i];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.tag = 1000 + i;
            [self.weekTitleView addSubview:titleLabel];
        }
    }
    return _weekTitleView;
}

- (UICollectionView *)calendarCollectionView {
    if (!_calendarCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 10;
        
        self.calendarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.calendarCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.weekTitleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.weekTitleView.frame));
        self.calendarCollectionView.delegate = self;
        self.calendarCollectionView.dataSource = self;
        [self.calendarCollectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"Cell"];
        self.calendarCollectionView.backgroundColor = [UIColor clearColor];
        
    }
    return _calendarCollectionView;
}

#pragma mark - **************** UIColletionView delegate and dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    self.startIndexRow = [NSDate fetchWeekDay:[NSDate date]];
    
    return (self.startIndexRow - 1) + 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row < self.startIndexRow) {
        
    } else {
        NSDateComponents *current = [NSDate fetchComponent:[NSDate date]];
        
        NSDate *date = [NSDate endDayAfterNowWithIntervals:indexPath.row - self.startIndexRow];
        NSDateComponents *components = [NSDate fetchComponent:date];
        
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld",components.day];
        cell.monthLabel.text = [NSString stringWithFormat:@"%ld月",components.month];
     
        if (indexPath.row == self.startIndexRow) {
            cell.monthLabel.hidden = false;
            cell.monthLabel.textColor = [UIColor grayColor];
        }
        if (components.day == 1 && components.month != current.month) {
            cell.monthLabel.hidden = false;
            cell.monthLabel.textColor = [UIColor blueColor];
        }
    
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = (CalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changeDayLabelIsSelected];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
