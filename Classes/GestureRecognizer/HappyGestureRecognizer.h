//
//  HappyGestureRecognizer.h
//  GestureRecognizer
//
//  Created by rongfzh on 13-2-27.
//  Copyright (c) 2013年 rongfzh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    DirectionUnknown = 0,
    DirectionLeft,
    DirectionRight
} Direction;

@interface HappyGestureRecognizer : UIGestureRecognizer
@property (assign) int tickleCount;
@property (assign) CGPoint curTickleStart;
@property (assign) Direction lastDirection;

@end
