//
//  GlobalTool.h
//  LeDanDan
//
//  Created by yzx on 15/12/9.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#ifndef GlobalTool_h
#define GlobalTool_h

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

#define kBGColor   [UIColor colorWithRed:0.06 green:0.73 blue:0.46 alpha:1];
#define kViewBGColor [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];


#pragma mark ---------------- 屏幕适配 ------------
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#define kUIWindow    [[[UIApplication sharedApplication] delegate] window] //获得window
#define kUnderStatusBarStartY (kIOSVersions>=7.0 ? 20 : 0)                 //7.0以上stautsbar不占位置，内容视图的起始位置要往下20

#define kIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define kIPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)

#define kIPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define kIOS7OffHeight (kIOSVersions>=7.0 ? 64 : 0)     //设置

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)

#define kStatusBarHeight         20
#define kNavigationBarHeight     44
#define kNavigationheightForIOS7 64
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kTabBarHeight            49
#define kTableRowTitleSize       14
#define maxPopLength             215

#define kButtonDefaultWidth (kIPhone4s ? 278 : 288)   //默认输入框宽
#define kSendSMSButtonWidth  90  //验证码按钮长度
#define kButtonDefaultHeight 42  //默认输入框&按钮高
#define kCellDefaultHeight = 44       //默认Cell高度

#pragma mark ---------------- 第三方函数 ------------
//比较字符串是否相等（忽略大小写），相等的话返回YES，否则返回NO。
#define kCompareStringCaseInsenstive(thing1, thing2) [thing1 compare:thing2 options:NSCaseInsensitiveSearch|NSNumericSearch] == NSOrderedSame
#define kCenterTheView(view) view.center = CGPointMake(kScreenWidth / 2.0, view.center.y)  //设置x方向屏幕居中


#pragma mark ---------------- 枚举、类型------------
/*
 接收、发送、更新数据
 */
typedef enum{
    kAPI_GET,       //get data from sever
    kAPI_POST,      //post data to sever
    kAPI_PUT,       //update the data to sever
    kAPI_DELETE     //delete
}kAPI_PROTO;


// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.


#endif /* GlobalTool_h */
