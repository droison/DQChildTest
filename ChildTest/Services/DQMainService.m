//
//  DQMainService.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DQMainService.h"

static DQMainService * instance;

@implementation DQMainService


+ (DQMainService*) shareInstance
{
    if (instance == nil) {
        instance = [[DQMainService alloc]init];
    }
    return instance;
}


@end
