//
//  LongDeleteViewController.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/24.
//  Copyright © 2016年 X. All rights reserved.
//
#import "LongDeleteViewController.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)


@interface LongDeleteViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CollectionViewCellDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *_photosArray;
    BOOL x;
}

@end

@implementation LongDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _photosArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 20; i++) {
        NSString *photoName = [NSString stringWithFormat:@"%ld.jpg",i];
        [_photosArray addObject:photoName];
    }
    
    x=1;
    
    [self creatUI];

    // Do any additional setup after loading the view.
}

-(void)creatUI
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing=0;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.headerReferenceSize=CGSizeMake(fDeviceWidth, 60);//头部
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//滚动方向
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
    
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
    
}

-(void)hideAllDeleteBtn
{
    if (!x) {
        x=1;
        [self.collectionView reloadData];
        
    }
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photosArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSString *str=[NSString stringWithFormat:@"%@",_photosArray[indexPath.row]];
    cell.path=indexPath;
    cell.btn.hidden=x?YES:NO;
    cell.myImageView.userInteractionEnabled=x?NO:YES;
    cell.delegate=self;
    [cell updateWithStr:str];
    cell.userInteractionEnabled =YES;
    
    
    return cell;
}


-(void)showAllDeleteBtn
{
    x=0;
    [self.collectionView reloadData];
    
    //    for (CollectionViewCell *cell in  self.collectionView.subviews) {
    //        CollectionViewCell *myCell=cell;
    //        myCell.btn.hidden=NO;
    //    }
}


-(void)deleteCellAtIndexpath:(NSIndexPath *)path
{
    
    
    if (_photosArray.count == 1) {
        return;
    }
    [self.collectionView performBatchUpdates:^{
        [_photosArray removeObjectAtIndex:path.item];
        [self.collectionView deleteItemsAtIndexPaths:@[path]];
    } completion:^(BOOL finished) {
        
        [self.collectionView reloadData];
    }];
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f,%f",self.collectionView.contentOffset.x,self.collectionView.contentOffset.y);
    
}

//cell是否可以删除
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(fDeviceWidth/3.0, fDeviceWidth/3.0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"选择%ld",indexPath.row);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
