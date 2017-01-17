//
//  FriendCircleViewController.m
//  GKplusDemo
//
//  Created by jf on 17/1/13.
//  Copyright © 2017年 jf. All rights reserved.
//

#define kLines 20
#import "FriendCircleViewController.h"
//键盘
#import "ChatKeyBoard.h"
#import "MessageCell.h"
#import "MessageModel.h"
@interface FriendCircleViewController ()<ChatKeyBoardDelegate, ChatKeyBoardDataSource,UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, weak) UITableView *messageTableView;
@end

@implementation FriendCircleViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        //注册键盘出现NSNotification
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillShow:)
//                                                     name:UIKeyboardWillShowNotification object:nil];
//        
//        
//        //注册键盘隐藏NSNotification
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillHide:)
//                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    self.title = @"朋友圈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    
    
    UITableView *messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    messageTableView.delegate = self;
    messageTableView.dataSource = self;
    [self.view addSubview:messageTableView];
    self.messageTableView = messageTableView;
    
    self.chatKeyBoard =[ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];//只是一个带导航栏的页面，导航栏不透明
    
    [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    [self.view addSubview:self.chatKeyBoard];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (kLines > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kLines-1 inSection:0];
            [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
    });
    
    
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
        ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
        ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
        ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
        return @[item1, item2, item3, item4];
}

//可以扩展这个  ➕ 事件
#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
//支持emoji表情
- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        themeM.themeStyle = FaceThemeStyleCustomEmoji;
        themeM.themeDecribe = [NSString stringWithFormat:@"f%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}
#pragma mark 处理测试数据
-(void)dealData{
    self.dataSource = [[NSMutableArray alloc]init];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *eachDic in JSONDic[@"data"][@"rows"]) {
        MessageModel *messageModel = [[MessageModel alloc] initWithDic:eachDic];
        [self.dataSource addObject:messageModel];
    }
}

//-(ChatKeyBoard *)chatKeyBoard{
//    if (_chatKeyBoard==nil) {
////        如果只是一个带导航栏的页面，且导航栏透明。 或者根本就没有导航栏
//        _chatKeyBoard =[ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
//        _chatKeyBoard.delegate = self;
//        _chatKeyBoard.dataSource = self;
//        _chatKeyBoard.keyBoardStyle = KeyBoardStyleChat;
//        _chatKeyBoard.allowVoice = YES;
//        _chatKeyBoard.allowMore = YES;
//        _chatKeyBoard.allowSwitchBar = YES;
//        _chatKeyBoard.placeHolder = @"发送信息";
//        [self.view addSubview:_chatKeyBoard];
//        [self.view bringSubviewToFront:_chatKeyBoard];
//    }
//    return _chatKeyBoard;
//}


//键盘消失
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDown];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kLines;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"demo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" %zd", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceStyle:(NSInteger)faceStyle faceName:(NSString *)faceName delete:(BOOL)isDeleteKey{
    NSLog(@"%@",faceName);
}
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
    
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
