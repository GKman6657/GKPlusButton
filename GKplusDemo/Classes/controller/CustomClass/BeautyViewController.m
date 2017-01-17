//
//  BeautyViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/12.
//  Copyright © 2017年 jf. All rights reserved.
//
#define FULL_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define FULL_SCREEN_W [UIScreen mainScreen].bounds.size.width
#import "BeautyViewController.h"
#import "YBPasterImageVC.h"
@interface BeautyViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, FULL_SCREEN_H-200, 100, 44);
    [button addTarget:self action:@selector(doBeaty:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"美颜一下" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gao4"]];
    imageView.frame = CGRectMake(10, 10, FULL_SCREEN_W - 20, FULL_SCREEN_H - 260);
    _imageView = imageView;
    [self.view addSubview:imageView];
    
}
- (void)doBeaty:(UIButton *)button {
    
    
    YBPasterImageVC *pasterVC = [[YBPasterImageVC alloc]init];
    pasterVC.originalImage = [UIImage imageNamed:@"gao4"];
    
    pasterVC.block = ^(UIImage *editedImage){
        _imageView.image = editedImage;
    };
    
    [self.navigationController pushViewController:pasterVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
