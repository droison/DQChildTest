//
//  UIImage+DQExtend.m
//  ChildTest
//
//  Created by 淞 柴 on 15/6/10.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "UIImage+DQExtend.h"
#import <objc/runtime.h>

#define recourcesPath [[NSBundle mainBundle] resourcePath]

@implementation UIImage (DQExtend)


+ (UIImage*) DQImageNamed:(NSString *)name
{
    NSString * imageFile = [[NSString alloc] initWithFormat:@"%@/%@@2x.png",recourcesPath, name];
    
    UIImage* tempImage = [[UIImage alloc] initWithContentsOfFile:imageFile];
    
    imageFile = nil;
    
    return tempImage;
}
@end
