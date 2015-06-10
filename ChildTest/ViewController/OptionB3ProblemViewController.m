//
//  OptionB3ProblemViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/7.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "OptionB3ProblemViewController.h"

@implementation OptionB3ProblemViewController
- (void) viewDidLoad
{
    optionCount = 3;
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage DQImageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    UIButton* btn1 = [self genOptionBtn:0];
    UIButton* btn2 = [self genOptionBtn:1];
    UIButton* btn3 = [self genOptionBtn:2];
    
    btn1.origin = CGPointMake((MMScreenWidth - btn1.width - btn2.width - btn3.width - 2*_optionHInnerMargin)/2, titleImageView.bottom + _optionMarginTop);
    [self.view addSubview:btn1];
    
    
    btn2.origin = CGPointMake(btn1.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn2];
    
    btn3.origin = CGPointMake(btn2.right + _optionHInnerMargin, btn1.top);
    [self.view addSubview:btn3];
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        int nextId = 21;
        if (problemId == 21) {
            nextId = 28;
        }
        [MainService addProblemAnswer:problemId Answer:answerArray];
        [MainService.mainWindow setRootViewController:[MainService getViewControllerByProblemId:nextId]];
    }
}
@end
