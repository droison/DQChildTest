//
//  OptionInnerProblemViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/9.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "OptionInnerProblemViewController.h"

@implementation OptionInnerProblemViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage DQImageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    int y = titleImageView.top + _optionMarginTop - _optionVInnerMargin;
    int x = 0;
    for (int i = 0; i < optionCount; i++)
    {
        UIButton* btn = [self genOptionBtn:i];
        if (x == 0)
        {
            x = (MMScreenWidth - btn.width)/2;
        }
        btn.origin = CGPointMake(x, y);
        [self.view addSubview:btn];
        y = btn.bottom;
    }
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        int nextId = 27;
        
        [MainService addProblemAnswer:problemId Answer:answerArray];
        [MainService.mainWindow setRootViewController:[MainService getViewControllerByProblemId:nextId]];
    }
}
@end
