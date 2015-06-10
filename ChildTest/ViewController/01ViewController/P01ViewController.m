//
//  P01ViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/5.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "P01ViewController.h"
#import "DQMainService.h"
#import "Option5ProblemViewController.h"


@implementation P01ViewController

- (void) viewDidLoad
{
    singleSelect = YES;
    problemId = 1;
    optionCount = 2;
    [super viewDidLoad];
    
    UIImage* titleImg = [UIImage DQImageNamed:@"p01_title"];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 230/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    UIButton* btn1 = [self genOptionBtn:0];
    btn1.origin = CGPointMake((MMScreenWidth - btn1.width*2 - 20)/2, 250);
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [self genOptionBtn:1];
    btn2.origin = CGPointMake(btn1.right + 20, 250);
    [self.view addSubview:btn2];
}

- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        [MainService addProblemAnswer:problemId Answer:answerArray];
        UIViewController* vc = [MainService getViewControllerByProblemId:2];
        
        UIWindow* mainWindow = [MainService mainWindow];
        mainWindow.rootViewController = vc;
    }
}
@end
