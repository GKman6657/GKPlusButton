//
//  QQPopViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/12.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "QQPopViewController.h"
#import "PopoverView.h"
#import "UITextView+Placeholder.h"   //runtime
@interface QQPopViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noticeLab;
@property (retain, nonatomic) IBOutlet UITextView *mTextView;
@property (weak, nonatomic) IBOutlet UITextView *kTextView2;
@property (nonatomic,assign)CGFloat originalHeight;
@end

@implementation QQPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configUI];
    [self customTextView];
    
     [self setupTextView];
}

- (void)setupTextView {
    
    self.kTextView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.kTextView2.placeholder = @"Are you sure you don\'t want to reconsider? Could you tell us why you wish to leave StyleShare? Your opinion helps us improve StyleShare into a better place for fashionistas from all around the world. We are always listening to our users. Help us improve!";
    self.kTextView2.placeholderColor = [UIColor greenColor];
    self.kTextView2.backgroundColor = [UIColor redColor];
    
    
    NSDictionary *attrs = @ {
    NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
    };
    self.kTextView2.attributedText = [[NSAttributedString alloc] initWithString:@"Hi,it's my showtime" attributes:attrs];
    self.kTextView2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.kTextView2];
}

- (void)configUI {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_menu"] style:UIBarButtonItemStyleDone target:self action:@selector(myclickleftButton)]; //创建一个边按钮
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"消失" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)]; //创建一个边按钮
    self.navigationItem.rightBarButtonItem = rightButton;
    
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)customTextView{
//    self.mTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 200, 300, 50)];
    self.mTextView.text = @"想说的话";  //placeholder 功能
    self.mTextView.textColor = [UIColor magentaColor];//设置textview里面的字体颜色
    self.mTextView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.mTextView];
    
    self.mTextView.font = [UIFont systemFontOfSize:17];
    self.mTextView.delegate = self;
    // 加圆角,圆角过大,就要修改inset
    self.mTextView.layer.cornerRadius = 20;
    
    
    // self.textView.textContainerInset默认{8, 0, 8 , 0}
    // 左右边要20
    self.mTextView.textContainerInset = UIEdgeInsetsMake(8, 20, 8, 20);
    // 标记原始高度
    self.originalHeight = self.mTextView.frame.size.height;
    

}
#pragma mark --UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView; {
    
    // 设置最大高度,高度超过,就能滚动.
    static CGFloat maxHeight = 70;
    
    CGFloat height;
    
    // sizeThatFit会自动autoLayout
    CGSize newSize =[textView sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)];

    // 原始高度,height = originalHeight
    if (newSize.height < self.originalHeight) {
        height = self.originalHeight;
        self.mTextView.scrollEnabled = NO;
    } else {
        // 自适应高度
        height = newSize.height;
        
        if (newSize.height < maxHeight) {
            self.mTextView.scrollEnabled = NO;
        } else {
            // 最大高度
            self.mTextView.scrollEnabled = YES;
            height = maxHeight;
        }
    }
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height);
    
    ////* -- - -- - -  - - - - - 下面这种方式也可以实现高度自适应 - - - - -- -  - - - - - - --  - - - -*//
    
//    ///> 计算文字高度
//    CGFloat height = ceilf([textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height);
//    if (height >= 100) {
//        textView.scrollEnabled = YES;   ///> 当textView高度大于等于最大高度的时候让其可以滚动
//        height = 150;                   ///> 设置最大高度
//    }
//    ///> 重新设置frame, textView往上增长高度
//    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height);
//    //                            0, CGRectGetMaxY(textView.frame) - height, self.view.bounds.size.width, height
//    [textView layoutIfNeeded];


}

//为了实现placeholder 在开始编辑的代理方法中进行如下操作
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"想说的话"]) {
        textView.text = @"";
    }
}
//在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"想说的话";
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mTextView resignFirstResponder];
}




- (NSArray<PopoverAction *> *)QQActions {
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        _noticeLab.text = action.title;
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}


- (IBAction)topClick:(id)sender {
    
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"加好友" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"发起聊天" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"发起群聊" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action5 = [PopoverAction actionWithTitle:@"查找群聊" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action6 = [PopoverAction actionWithTitle:@"我的群聊" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action1, action2, action3, action4, action5, action6]];
}

- (void)myclickleftButton {
    
    PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_newmessage"] title:@"发起群聊" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_friend"] title:@"添加朋友" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_scan"] title:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_money"] title:@"收付款" handler:^(PopoverAction *action) {
        _noticeLab.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    // 在没有系统控件的情况下调用可以使用显示在指定的点坐标的方法弹出菜单控件.
    [popoverView showToPoint:CGPointMake(20, 64) withActions:@[action1, action2, action3, action4]];
}
- (IBAction)leftBottomClick:(id)sender {
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = NO; // 显示阴影背景
    popoverView.style = PopoverViewStyleDark;// 黑色风格
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:[self QQActions]];

}
- (IBAction)rightBottomClick:(id)sender {
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:sender withActions:[self QQActions]];
}
#pragma mark --实现监听方法
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification {
    
}
- (void)handleKeyboardDidHidden {
    
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
