//
//  ViewController2.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/23.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController2.h"
#import "V2Layout.h"
#import "V2View.h"

#define xWidth  [UIScreen mainScreen].bounds.size.width * 0.6
#define xHeight [UIScreen mainScreen].bounds.size.height * 0.2
@interface ViewController2 ()<UICollectionViewDataSource,UICollectionViewDelegate,V2LayoutDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    V2Layout *layout =[[V2Layout alloc]init];
    layout.delegate = self;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 80.0f, xHeight, 80.0f);
    layout.minimumLineSpacing = 50.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _col.delegate=self;
    _col.dataSource=self;
    _col.allowsMultipleSelection = NO;
    _col.allowsSelection = NO;
    _col.collectionViewLayout =layout;
    _col.backgroundColor=[UIColor blackColor];

    [_col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view from its nib.
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =[self.col dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, xWidth, xWidth*1.2)];
    imageView.image=[UIImage imageNamed:@"22"];
    V2View *v=[[V2View alloc]initWithFrame:CGRectMake(0, 0, xWidth, xWidth*1.2)];
    [v addSubview:imageView];
    [v setInvertedImage];
    [cell.contentView addSubview:v];

    
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(xWidth, xWidth*1.2);
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
