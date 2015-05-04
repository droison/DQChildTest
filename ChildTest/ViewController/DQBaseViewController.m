//
//  DQBaseViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DQBaseViewController.h"

@implementation DQBaseViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    UIImage* image = [UIImage imageNamed:@"background"];
    UIImageView* imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.image = image;
    [self.view addSubview:imageview];
    [self.view sendSubviewToBack:imageview];
}

@end
