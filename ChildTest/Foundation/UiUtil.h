//
//  UiUtil.h
//  QDaily
//
//  Created by song on 14-10-16.
//  Copyright (c) 2014年 droison. All rights reserved.
//
#import "DeviceInfo.h"

#define ONE_PX 1/[UIScreen mainScreen].scale

#define MMScreenHeight          [UiUtil screenHeightCurOri]       //竖屏时的高度

#define MMScreenHeightOri(ori)  [UiUtil screenHeight:ori]

#define MMScreenWidth           [UiUtil screenWidthCurOri]        //横屏时的宽度
#define MMScreenWidthOri(ori)   [UiUtil screenWidth:ori]

#define QDFontSize(i) [UiUtil dynamicFontSize:i]

@interface UiUtil : NSObject

// 界面高宽
+(CGFloat) statusBarHeight;
+(CGFloat) statusBarHeight:(UIInterfaceOrientation)orientation;
+(CGFloat) screenHeight;
+(CGFloat) screenHeightCurOri;
+(CGFloat) screenHeight:(UIInterfaceOrientation)orientation;
+(CGFloat) screenWidth;
+(CGFloat) screenWidthCurOri;
+(CGFloat) screenWidth:(UIInterfaceOrientation)orientation;

+(CGFloat) dynamicFontSize:(CGFloat)size;

// statusbar
+ (void)setStatusBarFontWhite;
+ (void)setStatusBarFontBlack;
+ (void)setStatusBarStyle : (UIStatusBarStyle)style;

@end

//@interface TestTaskBarWindow : UIWindow<IUiUtilExt>
//
//@property (nonatomic) BOOL available;
//
////+(void) hideWXTalkBar;
////+(void) showWXTalkBar;
//
//@end
