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
    UIImage* image = [UIImage DQImageNamed:@"background"];
    UIImageView* imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MMScreenWidth, MMScreenHeight)];
    imageview.image = image;
    [self.view addSubview:imageview];
    [self.view sendSubviewToBack:imageview];
}

- (void) dealloc
{
    LogD(@"%@ dealloc", NSStringFromClass(self.class));
}
@end
