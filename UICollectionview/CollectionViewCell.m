//
//  CollectionViewCell.m
//  UICollectionview
//
//  Created by Xia_Q on 15/11/12.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor purpleColor];
        self.myImageView=[[UIImageView alloc]init];
        self.myImageView.frame=CGRectMake(0, 0, fDeviceWidth/3.0, fDeviceWidth/3.0);
        [self.contentView addSubview:self.myImageView];
       
        _btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame=CGRectMake(0, 0, 20, 20);
        [_btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _btn.hidden=YES;
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        
        //长按手势
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
        [self addGestureRecognizer:lpgr];
        
        
//        self.myImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [singletap setNumberOfTapsRequired:1];
        [self.myImageView addGestureRecognizer:singletap];

    }
    return self;
}

//单击手势
- (void) handleSingleTap:(UITapGestureRecognizer *) gestureRecognizer
{
    [self.delegate hideAllDeleteBtn];
}


//长按手势
- (void)longClick:(UILongPressGestureRecognizer *)lpgr
{
//    _btn.hidden=NO;
    [self.delegate showAllDeleteBtn];
    
}


-(void)btnClick
{
    NSLog(@"%@",_path);
    [self.delegate deleteCellAtIndexpath:_path];
}

-(void)updateWithStr:(NSString *)str
{
    self.myImageView.image=[UIImage imageNamed:str];
}

- (void)awakeFromNib {
}

@end
