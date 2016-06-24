//
//  ViewController.m
//  UicollectionviewUse
//
//  Created by Xia_Q on 16/6/23.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "LongDeleteViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"uicollectionview使用";
    self.automaticallyAdjustsScrollViewInsets=NO;
    dataArr=@[@"基础",@"带镜面的",@"长按删除Cell"];

    _myTab.delegate=self;
    _myTab.dataSource=self;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ViewController1 *v1=[[ViewController1 alloc]init];
        [self.navigationController pushViewController:v1 animated:YES];
    }
    if (indexPath.row == 1) {
        ViewController2 *v2 =[[ViewController2 alloc]init];
        [self.navigationController pushViewController:v2 animated:YES];
    }
    
    if (indexPath.row == 2) {
        LongDeleteViewController *lvc=[[LongDeleteViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell ==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = dataArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
