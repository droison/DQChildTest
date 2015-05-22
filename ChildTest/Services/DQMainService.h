//
//  DQMainService.h
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Option5ProblemViewController;

#define MainService [DQMainService shareInstance]

typedef enum : int
{
    DQCurAgeType01 = 0,
    DQCurAgeType12,
    DQCurAgeType23,
    DQCurAgeType3plus,
} DQCurAgeType;

@interface DQMainService : NSObject

@property (assign, nonatomic) BOOL isReset;  //用于做完题初始化
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* phone;
@property (assign, nonatomic) DQCurAgeType curAgeType;

+ (DQMainService*) shareInstance;
- (UIWindow*) mainWindow;
- (UIViewController*) startProblemView;
- (UIViewController*) getNextProblemViewController:(int) curProblemId;

- (void) addProblemAnswer:(int) problemId Answer:(NSArray*) array;

- (Option5ProblemViewController*) getOption5ProblemViewController;

- (UIViewController*) getViewControllerByProblemId:(int) problemId;

- (void) sendImage:(UIImage*)image;

- (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
