//
//  Option5ProblemViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/7.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "Option5ProblemViewController.h"

@implementation Option5ProblemViewController
- (void) viewDidLoad
{
    optionCount = 5;
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage imageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    UIButton* btn1 = [self genOptionBtn:0];
    btn1.origin = CGPointMake((MMScreenWidth - btn1.width*3 - _optionH1InnerMargin * 2)/2, titleImageView.bottom + _optionMarginTop);
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [self genOptionBtn:1];
    btn2.origin = CGPointMake(btn1.right + _optionH1InnerMargin, btn1.top);
    [self.view addSubview:btn2];
    
    UIButton* btn3 = [self genOptionBtn:2];
    btn3.origin = CGPointMake(btn2.right + _optionH1InnerMargin, btn1.top);
    [self.view addSubview:btn3];
    
    UIButton* btn4 = [self genOptionBtn:3];
    btn4.origin = CGPointMake((MMScreenWidth - btn4.width*2 - _optionH2InnerMargin * 2)/2, btn1.bottom + _optionVInnerMargin);
    [self.view addSubview:btn4];
    
    UIButton* btn5 = [self genOptionBtn:4];
    btn5.origin = CGPointMake(btn4.right + _optionH2InnerMargin, btn4.top);
    [self.view addSubview:btn5];
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        int nextId = 9;
        if (problemId == 12) {
            nextId = 20;
        }
        [MainService addProblemAnswer:problemId Answer:answerArray];
        UIViewController * vc = [MainService getViewControllerByProblemId:nextId];
        UIWindow* mainWindow = [MainService mainWindow];
        mainWindow.rootViewController = vc;
    }
}
@end
