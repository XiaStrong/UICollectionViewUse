//
//  WaterFallLayout.h
//  WaterFall
//
//  Created by Xia_Q on 17/2/23.
//  Copyright © 2017年 Xia_Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallLayout;

@protocol WaterFallDelegate <NSObject>

@required
//返回高度
-(CGFloat)waterFallLayout:(WaterFallLayout *)layout heightForItemIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
-(NSInteger)waterFallLayoutColumnCount:(WaterFallLayout *)layout;
-(CGFloat)waterFallLayoutColumnSpacing:(WaterFallLayout *)layout;
-(CGFloat)waterFallLayoutRowSpacing:(WaterFallLayout *)layout;
-(UIEdgeInsets)waterFallLayoutUIEdgeInsets:(WaterFallLayout *)layout;

@end

@interface WaterFallLayout : UICollectionViewLayout

@property(nonatomic,weak)id<WaterFallDelegate>delegagte;

@end
