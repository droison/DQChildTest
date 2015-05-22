//
//  EndViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/15.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "EndViewController.h"
#import "StartViewController.h"

@implementation EndViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIImage* logoImage = [UIImage imageNamed:@"draw_logo"];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (MMScreenHeight - logoImage.size.height - 110/2), logoImage.size.width, logoImage.size.height)];
    logoImageView.image = logoImage;
    [self.view addSubview:logoImageView];
    
    UIImage* contentImage = [UIImage imageNamed:@"end_content"];
    UIImageView *contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - contentImage.size.width)/2, 180, contentImage.size.width, contentImage.size.height)];
    contentImageView.image = contentImage;
    [self.view addSubview:contentImageView];
    
    UIImage* returnHome = [UIImage imageNamed:@"return_home"];
    UIButton* returnHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake((MMScreenWidth - returnHome.size.width)/2, contentImageView.bottom - returnHome.size.height/2, returnHome.size.width, returnHome.size.height)];
    [returnHomeBtn setImage:returnHome forState:UIControlStateNormal];
    [returnHomeBtn addTarget:self action:@selector(onClickBackHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnHomeBtn];
}

- (void) onClickBackHome
{
    [MainService setIsReset:YES];
    [MainService.mainWindow setRootViewController:[[StartViewController alloc]init]];
}

@end
