//
//  WaterFallLayout.m
//  WaterFall
//
//  Created by Xia_Q on 17/2/23.
//  Copyright © 2017年 Xia_Q. All rights reserved.
//

#import "WaterFallLayout.h"

static NSInteger const DefaultColumnCount = 2;//列数
static CGFloat const DefaultColumnSpacing = 10;//列间距
static CGFloat const DefaultRowSpacing = 10;//行间距
static UIEdgeInsets const DefaultEdgeInsets = {10,10,10,10};//距屏幕上右下左

@interface WaterFallLayout()

//存放布局属性
@property(nonatomic,strong)NSMutableArray *attrArray;
//每一列当前的长度
@property(nonatomic,strong)NSMutableArray *maxYArray;

-(NSInteger)columnCount;
-(CGFloat)columnSpacing;
-(CGFloat)rowSpacing;
-(UIEdgeInsets)edgeInsets;

@end

@implementation WaterFallLayout

-(NSInteger)columnCount{
    if ([self.delegagte respondsToSelector:@selector(waterFallLayoutColumnCount:)]) {
        return  [self.delegagte waterFallLayoutColumnCount:self];
    }
    return DefaultColumnCount;
}
-(CGFloat)columnSpacing{
    if ([self.delegagte respondsToSelector:@selector(waterFallLayoutColumnSpacing:)]) {
        return  [self.delegagte waterFallLayoutColumnSpacing:self];
    }
    return DefaultColumnSpacing;
}
-(CGFloat)rowSpacing{
    if ([self.delegagte respondsToSelector:@selector(waterFallLayoutRowSpacing:)]) {
        return  [self.delegagte waterFallLayoutRowSpacing:self];
    }
    return DefaultRowSpacing;
}
-(UIEdgeInsets)edgeInsets{
    if ([self.delegagte respondsToSelector:@selector(waterFallLayoutUIEdgeInsets:)]) {
        return  [self.delegagte waterFallLayoutUIEdgeInsets:self];
    }
    return DefaultEdgeInsets;
}

-(NSMutableArray *)attrArray{
    if(!_attrArray){
        _attrArray =[[NSMutableArray alloc]init];
    }
    return _attrArray;
}


-(NSMutableArray *)maxYArray{
    if(!_maxYArray){
        _maxYArray =[[NSMutableArray alloc]init];
    }
    return _maxYArray;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    [self.attrArray removeAllObjects];
    [self.maxYArray removeAllObjects];
    
    
    for(NSInteger i= 0;i<self.columnCount;i++){
        
        //距屏幕上边距的高度,语法糖
//        if([@123  isEqual: [NSNumber numberWithInt:123]])
        
        [self.maxYArray addObject:@(self.edgeInsets.top)];
    }
    
    
    NSInteger  itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i =0; i<itemCount; i++) {
        
        NSIndexPath *indexPath =[NSIndexPath indexPathForItem:i inSection:0];
        
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        
    }
}

//返回rect中所有item的布局属性
- (NSArray< UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArray;
}

//返回对应于indexPath的位置的cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger __block minHeightColumn = 0;//记录当前最短列号
    NSInteger __block minHeight = [self.maxYArray[minHeightColumn] floatValue];//记录最短高度
    //遍历maxYArray,得到最短咧
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
        }
    }];
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    UIEdgeInsets edgeInsets = [self edgeInsets];
    
    CGFloat width = (CGRectGetWidth(self.collectionView.frame)-edgeInsets.left-edgeInsets.right-self.columnSpacing*(self.columnCount-1))/self.columnCount;
    CGFloat height = [self.delegagte waterFallLayout:self heightForItemIndex:indexPath.item itemWidth:width];
    
    CGFloat originX = edgeInsets.left + minHeightColumn * (width + self.columnSpacing);
    CGFloat originY = minHeight;
    
    if (originY != edgeInsets.top) {
        originY +=self.rowSpacing;
    }
    
    [attributes setFrame:CGRectMake(originX, originY, width, height)];
    
    //更改每列的最低高度的当前值
    self.maxYArray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}


//滚动的偏移最大量
-(CGSize)collectionViewContentSize{
    
    NSInteger __block maxHeight = 0;
    //遍历maxYArray
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (maxHeight < columnHeight) {
            maxHeight = columnHeight;
        }
    }];
    return CGSizeMake(0, maxHeight+self.edgeInsets.bottom);
}

@end
