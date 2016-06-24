//
//  CollectionViewCell.h
//  UICollectionview
//
//  Created by Xia_Q on 15/11/12.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)

@protocol CollectionViewCellDelegate <NSObject>

-(void)deleteCellAtIndexpath:(NSIndexPath *)path;
-(void)showAllDeleteBtn;
-(void)hideAllDeleteBtn;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id<CollectionViewCellDelegate>delegate;

@property(nonatomic,strong)UIImageView *myImageView;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)NSIndexPath *path;

-(void)updateWithStr:(NSString *)str;

@end
