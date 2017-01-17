//
//  GKplusBtnSubclass.m
//  GKplusDemo
//
//  Created by jf on 17/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "GKplusBtnSubclass.h"
#import "CYLTabBarController.h"
#import "BeautyViewController.h"
#import "QQPopViewController.h"
@interface GKplusBtnSubclass ()<UIActionSheetDelegate> {
    CGFloat _buttonImageHeight;
}


@end

@implementation GKplusBtnSubclass
#pragma mark -
+ (void)load {
    //请在 `-application:didFinishLaunchingWithOptions:` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods 必须实现代理方法

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    GKplusBtnSubclass *button = [[GKplusBtnSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:@"选中" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit];// or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
//        button.frame = CGRectMake(0.0, 0.0, 250, 100);
//        button.backgroundColor = [UIColor redColor];
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    GKplusBtnSubclass* button = [GKplusBtnSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"动起来", @"从相册选取", @"美颜一下", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
     UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    if (buttonIndex == 2) {
        BeautyViewController * beautyVC = [[BeautyViewController alloc]init];
        beautyVC.view.backgroundColor = [UIColor whiteColor];
        beautyVC.navigationItem.title = @"美颜萌萌哒";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:beautyVC];
        [tabBarController.selectedViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }else if (buttonIndex == 0){
        
        
    }else{
        QQPopViewController * qq = [[QQPopViewController alloc]init];
        qq.view.backgroundColor = [UIColor whiteColor];
        qq.navigationItem.title = @"收钱了";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:qq];
        [tabBarController.selectedViewController presentViewController:nav animated:YES completion:^{
            
        }];

    }
}


#pragma mark - CYLPlusButtonSubclassing 可选实现代理方法

/*********************************************************************************
 可以让➕放在任何你想放的位置   
 1. 添加了 PlusButton 且 TabBarItem 的个数是奇数。
 2. 实现了 `+plusChildViewController`。       必须实现该方法
 3. 如果要把加号按钮做成跟其他按钮的点击效果一样的 需要同时实现这两个方法
 */

//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 4;
//}
//
//+ (UIViewController *)plusChildViewController {
//    UIViewController *plusChildViewController = [[UIViewController alloc] init];
//    plusChildViewController.view.backgroundColor = [UIColor cyanColor];
//    plusChildViewController.navigationItem.title = @"PlusChildViewController";
//    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
//                                                   initWithRootViewController:plusChildViewController];
//    return plusChildNavigationController;
//}
////
//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    
//    if (isSelected) {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;  //小于0.5表示 PlusButton 偏上，大于0.5则表示偏下
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10; //大于0会向下偏移，小于0会向上偏移
}

@end
