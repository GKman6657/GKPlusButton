//
//  BaseViewController.h
//  GKplusDemo
//
//  Created by jf on 17/1/13.
//  Copyright © 2017年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

-(void)registerCellWithNib:(NSString *)nibName tableView:(UITableView *)tableView;

-(void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tableView;

-(int)getRandomNumber:(int)from to:(int)to;

@end
