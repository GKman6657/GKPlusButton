//
//  DetailViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+CYLTabBarControllerExtention.h"
#import "GKMineViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击屏幕可跳转到“我的”，执行testPush";
    label.frame = CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 2 * 20, 20);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cyl_popSelectTabBarChildViewControllerAtIndex:3 completion:^(__kindof UIViewController *selectedTabBarChildViewController) {
        GKMineViewController *mineViewController = selectedTabBarChildViewController;
        [mineViewController testPush];
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
