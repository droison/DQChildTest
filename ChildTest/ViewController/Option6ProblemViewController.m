//
//  Option6ProblemViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/9.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "Option6ProblemViewController.h"
#import "DrawViewController.h"

@implementation Option6ProblemViewController
- (void) viewDidLoad
{
    optionCount = 3;
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage DQImageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];

    UIButton* btn1 = [self genOptionBtn:0];
    btn1.origin = CGPointMake((MMScreenWidth - btn1.width*3 - _optionHInnerMargin * 2)/2, titleImageView.bottom + _optionMarginTop);
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [self genOptionBtn:1];
    btn2.origin = CGPointMake(btn1.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn2];
    
    UIButton* btn3 = [self genOptionBtn:2];
    btn3.origin = CGPointMake(btn2.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn3];
    
    UIButton* btn4 = [self genOptionBtn:3];
    btn4.origin = CGPointMake(btn1.left, btn1.bottom + _optionVInnerMargin);
    [self.view addSubview:btn4];
    
    UIButton* btn5 = [self genOptionBtn:4];
    btn5.origin = CGPointMake(btn2.left, btn4.top);
    [self.view addSubview:btn5];
    
    UIButton* btn6 = [self genOptionBtn:5];
    btn6.origin = CGPointMake(btn3.left, btn4.top);
    [self.view addSubview:btn6];
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        [MainService addProblemAnswer:problemId Answer:answerArray];
        DrawViewController* drawViewController = [[DrawViewController alloc]init];
        UIWindow* window = [MainService mainWindow];
        window.rootViewController = drawViewController;
    }
}
@end
