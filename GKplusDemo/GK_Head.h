//
//  GK_Head.h
//  GKplusDemo
//
//  Created by jf on 17/1/12.
//  Copyright © 2017年 jf. All rights reserved.
//

#ifndef GK_Head_h
#define GK_Head_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#import "NSObject+Property.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "UIImageView+WebCache.h"
#import "YYText.h"
#import "YYTextView.h"
#import "YYLabel.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "UIControl+YYAdd.h"
#import "YYFPSLabel.h"
#import "ChatKeyBoardMacroDefine.h"

#define kGAP 10
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define kAvatar_Size 40

#define kTabBarHeight       49
#define kNavbarHeight       64

#define kAlmostZero         0.0000001

#endif /* GK_Head_h */
