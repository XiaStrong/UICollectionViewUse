//
//  ViewController1.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/23.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController1.h"
#import "UIColor+RandomColor.h"

@interface ViewController1 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置layout
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(50, 50);//每个item大小
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);//cell离section的边距
//    layout.sectionInset=UIEdgeInsetsMake(10, 0, 0, 0);//在section内离上10距离;
//    layout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 0);//在section内离左10距离;
//    layout.sectionInset=UIEdgeInsetsMake(0, 0, 50, 0);//在section内离下10距离;
//    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 10);//在section内离右10距离;


    layout.scrollDirection=UICollectionViewScrollDirectionVertical;//滚动方向
    layout.minimumLineSpacing =10;//上下相邻cell的最小行距
    layout.minimumInteritemSpacing =5;//左右相邻cell 的最小行距
    
    self.myCol.collectionViewLayout=layout;
    

    [self.myCol registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];//注册cell
    
    [self.myCol registerNib:[UINib nibWithNibName:@"HeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    [self.myCol registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册头
    [self.myCol registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];//注册尾
    self.myCol.backgroundColor=[UIColor whiteColor];
    self.myCol.delegate=self;
    self.myCol.dataSource=self;
    self.myCol.allowsMultipleSelection =YES;//是否可以多选
    // Do any additional setup after loading the view from its nib.
}


//头和尾尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(60, 50);
//    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(60, 30);
}


//有多少节
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//每节有多少块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor randomColor];
    
    cell.selectedBackgroundView=[[UIView alloc]init];//选中测cell的View
    cell.selectedBackgroundView.backgroundColor=[[UIColor redColor]colorWithAlphaComponent:0.5];
    return cell;
}

//设置header,footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        
        view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor=[UIColor orangeColor];
        NSLog(@"%@",view.subviews[0].class);
//        UILabel *lable = (UILabel *)[view viewWithTag:0]; 不知道为什么出错了，所以用下面的方法取值
        UILabel *lable =(UILabel *)view.subviews[0];
        lable.text =[NSString stringWithFormat:@"第%d列" ,indexPath.section];
        return view;
        
    }else if(kind == UICollectionElementKindSectionFooter){
        
        //此种方法适用于footview一个样子的，若是在上卖弄加lable上的字会出现复用的现象，本人尚未找到解决办法
        view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor=[UIColor greenColor];
        return view;
    }
    
    return nil;
}


//取消选中哪一个
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选中%@",indexPath);

}

//选中哪一个
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中%@",indexPath);
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
