
//
//  OptionB4ProbleViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/7.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "OptionB4ProbleViewController.h"

@implementation OptionB4ProbleViewController
- (void) viewDidLoad
{
    optionCount = 4;
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage imageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    UIButton* btn1 = [self genOptionBtn:0];
    btn1.origin = CGPointMake((MMScreenWidth - btn1.width*4 - _optionHInnerMargin*3)/2, titleImageView.bottom + _optionMarginTop);
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [self genOptionBtn:1];
    btn2.origin = CGPointMake(btn1.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn2];
    
    UIButton* btn3 = [self genOptionBtn:2];
    btn3.origin = CGPointMake(btn2.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn3];
    
    UIButton* btn4 = [self genOptionBtn:3];
    btn4.origin = CGPointMake(btn3.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn4];
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        int nextId = 17;
        if (problemId == 11) {
            nextId = 12;
        }
        [MainService addProblemAnswer:problemId Answer:answerArray];
        UIViewController * vc = [MainService getViewControllerByProblemId:nextId];
        UIWindow* mainWindow = [MainService mainWindow];
        mainWindow.rootViewController = vc;
    }
}
@end
