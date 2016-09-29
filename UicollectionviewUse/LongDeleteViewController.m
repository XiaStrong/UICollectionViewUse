//
//  LongDeleteViewController.h
//  UICollectionview
//
//  Created by Xia_Q on 15/11/12.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "LongDeleteViewController.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)


@interface LongDeleteViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CollectionViewCellDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *_photosArray;
    BOOL x;
    UIImageView *image;
    CGRect rect;
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
 
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    rect = [collectionView convertRect:cell.frame toView:collectionView];
    
    float y = collectionView.contentOffset.y;

    
    UIImage *img= cell.myImageView.image;
    [image removeFromSuperview];
    image=nil;
    image =[[UIImageView alloc]init ];
    image.frame=CGRectMake(rect.origin.x, rect.origin.y-y, rect.size.width, rect.size.height);
    image.image=img;
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tgrTouch:)];
    tgr.numberOfTapsRequired=1;
    [image addGestureRecognizer:tgr];
    [self.view addSubview:image];

    
    [UIView animateWithDuration:0.4 animations:^{
        collectionView.userInteractionEnabled= NO;
        image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    
    NSLog(@"%f,%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height,y);
    NSLog(@"选择%ld",indexPath.row);
}


-(void)tgrTouch:(UITapGestureRecognizer *)tgr{
    
    [UIView animateWithDuration:0.4 animations:^{
        [image removeFromSuperview];
        image= nil;
        self.collectionView.userInteractionEnabled= YES;
    }];
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
