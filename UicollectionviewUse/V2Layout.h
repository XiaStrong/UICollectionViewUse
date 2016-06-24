//
//  V2Layout.h
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/23.
//  Copyright © 2016年 X. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol V2LayoutDelegate <NSObject>

@end

@interface V2Layout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<V2LayoutDelegate> delegate;

@end
