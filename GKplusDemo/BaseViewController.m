//
//  BaseViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/13.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseViewController

-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(void)registerCellWithNib:(NSString *)nibName tableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

-(void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tableView{
    [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark
#pragma mark TableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}



-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
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
