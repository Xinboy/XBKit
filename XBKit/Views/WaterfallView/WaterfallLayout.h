//
//  WaterfallLayout.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/12.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterfallLayout;

@protocol WaterfallLayoutDelegate <NSObject>

@required
//计算item高度的代理方法，将item的高度与indexPath传递给外界
- (CGFloat)waterfallLayout:(WaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterfallLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, assign) NSInteger columnSpacing;

@property (nonatomic, assign) NSInteger rowSpacing;

@property (nonatomic, assign) UIEdgeInsets sectionInset;
//保存每一列最大Y值的数组
@property (nonatomic, strong) NSMutableDictionary *maxYDic;
//保存每一个item的attributes的数组
@property (nonatomic, strong) NSMutableArray *attributesArray;

@property (nonatomic, weak) id<WaterfallLayoutDelegate> delegate;
//计算item高度的block，将item的高度与indexPath传递给外界
@property (nonatomic, strong) CGFloat(^itemHeightBlock)(CGFloat itemHeight,NSIndexPath *indexPath);


- (instancetype)initWithColumnCount:(NSInteger)columnCount;

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount;

- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset;
@end
