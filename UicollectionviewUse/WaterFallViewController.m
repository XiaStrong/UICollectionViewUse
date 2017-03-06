//
//  WaterFallViewController.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 17/3/6.
//  Copyright © 2017年 X. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallLayout.h"

@interface WaterFallViewController ()<UICollectionViewDataSource,WaterFallDelegate>
@property(nonatomic,strong)NSMutableArray *imgArray;

@end

@implementation WaterFallViewController

static NSString *const CellIdentifier = @"Cell";

-(NSMutableArray *)imgArray{
    if(!_imgArray){
        _imgArray = [NSMutableArray array];
        for (int i = 1; i<20; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            [_imgArray addObject:image];
        }
    }
    return _imgArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    WaterFallLayout *fallLayout =[[WaterFallLayout alloc]init];
    fallLayout.delegagte = self;
    UICollectionView *collectionView =[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:fallLayout];
    collectionView.dataSource = self;
    
    //注册Cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self.view addSubview:collectionView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    NSInteger tag1 = 11;
    UIImageView *imgView = [cell.contentView viewWithTag:tag1];
    if (!imgView) {
        imgView =[[UIImageView alloc]init];
        imgView.tag = tag1;
        [cell.contentView addSubview:imgView];
    }
    imgView.image = self.imgArray[indexPath.row];
    imgView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    NSInteger tag = 10;
    UILabel *lable = [cell.contentView viewWithTag:tag];
    if (!lable) {
        lable =[[UILabel alloc]init];
        lable.tag = tag;
        [cell.contentView addSubview:lable];
    }
    [lable setText:[NSString stringWithFormat:@"第%zd个",indexPath.row]];
    lable.frame = CGRectMake(0, 0, cell.frame.size.width, 30);
    
    
    return cell;
    
}

#pragma mark- WaterFallDelegate
-(CGFloat)waterFallLayout:(WaterFallLayout *)layout heightForItemIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth{
    
    CGFloat width = (self.view.frame.size.width-5-5-5*(2-1))/2;
    UIImage *img = self.imgArray[index];
    CGFloat imgW = img.size.width;
    CGFloat imgH = img.size.height;
    
    CGFloat height = imgH/imgW*width;
    return height;
    
    //    return 100 + arc4random_uniform(150);
}

-(NSInteger)waterFallLayoutColumnCount:(WaterFallLayout *)layout{
    return 2;
}


-(CGFloat)waterFallLayoutColumnSpacing:(WaterFallLayout *)layout{
    return 5;
}

-(CGFloat)waterFallLayoutRowSpacing:(WaterFallLayout *)layout{
    return 5;
}

-(UIEdgeInsets)waterFallLayoutUIEdgeInsets:(WaterFallLayout *)layout{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
