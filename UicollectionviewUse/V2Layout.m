//
//  V2Layout.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/23.
//  Copyright © 2016年 X. All rights reserved.
//

#import "V2Layout.h"
@implementation V2Layout
{
    CGSize boundsSize;
    CGFloat midX;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    boundsSize = self.collectionView.bounds.size;

    midX = boundsSize.width / 2.0f;
    
}

// 控制指定CGRect区域内各单元格的大小、位置等布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes* attributes in array)
    {
        
        
        CGPoint contentOffset = self.collectionView.contentOffset; //collectionView的偏移值
        
        /*
         attributes.center.x : 当前单元格在collectionview上的中心坐标 205 = 80 + 单元格宽度250/2;
         contentOffset.x : collectionView的x轴偏移量
         */
        CGFloat centerX =attributes.center.x -contentOffset.x;//当前item中心值减去collectionView.x 的偏移值
        
        CGFloat space = midX - centerX; //单元格与中心的距离

        CGFloat distance  = ABS(space); //得到space的绝对值

        CGFloat normalized = distance / midX; //当当前单元格在正中间时，为0，
        NSLog(@"当前item中心%f----偏移值%f-----距离%f-----比例%f",attributes.center.x,contentOffset.x,distance,normalized);
        
        CGFloat zoom = 1 + 0.2 *(1-ABS(normalized));//放大的倍数

        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
    }
    
    return array;
}


@end
