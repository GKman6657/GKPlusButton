//
//  ForkViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/12.
//  Copyright © 2017年 jf. All rights reserved.
////  代码下载地址https://github.com/leejayID/Linkage

#import "ForkViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
#import "FriendCircleViewController.h"
@interface ForkViewController ()
@property (nonatomic, copy) NSArray *datas;
@end

@implementation ForkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datas = @[@"UITableView",@"UICollectionView",@"微信朋友圈"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        TableViewController *table = [[TableViewController alloc] init];
        table.title = self.datas[indexPath.row];
        [self.navigationController pushViewController:table animated:YES];
    }
    else if (indexPath.row == 1)
    {
        CollectionViewController *collection = [[CollectionViewController alloc] init];
        collection.title = self.datas[indexPath.row];
        [self.navigationController pushViewController:collection animated:YES];
    }else{
        FriendCircleViewController * wechat = [[FriendCircleViewController alloc]init];
        wechat.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:wechat animated:YES];
    }
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
