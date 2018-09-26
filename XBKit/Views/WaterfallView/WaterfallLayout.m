//
//  WaterfallLayout.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/12.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "WaterfallLayout.h"

@implementation WaterfallLayout

- (void)prepareLayout {
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat colletionViewWidth = self.collectionView.frame.size.width;
    CGFloat itemWidth = (colletionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 0;
    if (self.itemHeightBlock) {
        itemHeight = self.itemHeightBlock(itemWidth, indexPath);
    } else {
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)]) {
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
        }
    }
    
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[minIndex] floatValue] > [obj floatValue]) {
            minIndex = key;
        }
    }];
    
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) *  minIndex.integerValue;
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}


#pragma mark - **************** 构造方法
- (instancetype)init {
    self = [super init];
    if (self) {
        self.columnCount = 3;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount {
    self = [super init];
    if (self) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount {
    return [[self alloc] initWithColumnCount:columnCount];
}

- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset {
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}
#pragma mark - **************** Lazy Load
- (NSMutableDictionary *)maxYDic {
    if (!_maxYDic) {
        self.maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        self.attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}
@end
