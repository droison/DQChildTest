//
//  DQMainService.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DQMainService.h"
#import "P01ViewController.h"
#import "AppDelegate.h"
#import "Option5ProblemViewController.h"
#import "Option4ProblemViewController.h"
#import "OptionB4ProbleViewController.h"
#import "Option3ProbleViewController.h"
#import "OptionB3ProblemViewController.h"
#import "Option6ProblemViewController.h"
#import "DropProblemViewController.h"
#import "DrawViewController.h"
#import "UploadUtil.h"
#import "TestViewController.h"

#import "OptionInnerProblemViewController.h"

static DQMainService * instance;

@interface DQMainService ()
{
    NSMutableArray* _problemArray;
    NSMutableArray* _answerArray; //保存true OR false
    
    NSUserDefaults *_userDefaults;
    UploadUtil* _uploadUtil;
    
    int rightOption;
    int totalOption;
}

@end

@implementation DQMainService

- (instancetype) init
{
    self = [super init];
    if (self) {
        _curAgeType = DQCurAgeType01;
        _isReset = YES;
        _problemArray = [NSMutableArray array];
        _answerArray = [NSMutableArray array];
    }
    return self;
}

+ (DQMainService*) shareInstance
{
    if (instance == nil) {
        instance = [[DQMainService alloc]init];
    }
    return instance;
}

- (void) setIsReset:(BOOL)reset
{
    _isReset = reset;
    if (_isReset)
    {
        _curAgeType = DQCurAgeType01;
        [_problemArray removeAllObjects];
        [_answerArray removeAllObjects];
        rightOption = 0;
        totalOption = 0;
    }
}

- (UIViewController*) startProblemView
{
    if (_curAgeType == DQCurAgeType01) {
        return [self getViewControllerByProblemId:1];
    }
    if (_curAgeType == DQCurAgeType12) {
        return [self getViewControllerByProblemId:3];
    }
    if (_curAgeType == DQCurAgeType23) {
        return [self getViewControllerByProblemId:5];
    }
    if (_curAgeType == DQCurAgeType3plus) {
        return [self getViewControllerByProblemId:7];
    }
    return nil;
}

- (UIWindow*) mainWindow
{
    AppDelegate* appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appdelegate.window;
}

- (void) addProblemAnswer:(int) problemId Answer:(NSArray*) array
{
    if (array == nil || array.count == 0) {
        TOAST(@"出错了，此题没选");
        return;
    }
    
    [_problemArray addObject:[NSNumber numberWithInt:problemId]];
    NSArray* rightAnswer = [self getAnswer:problemId];
    if (rightAnswer == nil) {
        NSString* toastStr = [NSString stringWithFormat:@"你选择了：%@，\n此题所有选择都对", array];
        TOAST(toastStr);
        [_answerArray addObject:[NSNumber numberWithBool:YES]];
        rightOption ++;
        totalOption ++;
    }
    else
    {
        BOOL isAllRight = YES;
        if (array.count == rightAnswer.count)
        {
            for (NSNumber *answerNum in array)
            {
                BOOL isRight = NO;
                for (NSNumber * rightNum in rightAnswer) {
                    if (answerNum.intValue == rightNum.intValue) {
                        rightOption ++;
                        isRight = YES;
                        break;
                    }
                }
                if (!isRight) {
                    isAllRight = NO;
                }
            }
        }
        else
        {
            isAllRight = NO;
            for (NSNumber *answerNum in array)
            {
                for (NSNumber * rightNum in rightAnswer) {
                    if (answerNum.intValue == rightNum.intValue) {
                        rightOption ++;
                        break;
                    }
                }
            }
        }
        totalOption += rightAnswer.count;
        [_answerArray addObject:[NSNumber numberWithBool:isAllRight]];
        
//        NSString* toastStr = [NSString stringWithFormat:@"你选择了:%@\n正确答案:%@\n此题%@\n得分%d/%d", array, rightAnswer, isAllRight?@"答对":@"答错", rightOption, totalOption];
//        TOAST(toastStr);
    }
    
    UIViewController * nextView = [MainService getNextProblemViewController:problemId];
    [MainService.mainWindow performSelector:@selector(setRootViewController:) withObject:nextView];
}



- (UIViewController*) getNextProblemViewController:(int) curProblemId
{
    NSArray * arr;
    if (_curAgeType == DQCurAgeType01) {
        arr = @[@"1", @"2", @"9", @"10", @"17", @"18", @"26", @"27"];
    }
    if (_curAgeType == DQCurAgeType12) {
        arr = @[@"3", @"4", @"11", @"12", @"20", @"21", @"28", @"29"];
    }
    if (_curAgeType == DQCurAgeType23) {
        arr = @[@"5", @"6", @"13", @"14", @"22", @"23", @"30", @"31"];
    }
    if (_curAgeType == DQCurAgeType3plus) {
        arr = @[@"7", @"8", @"15", @"16", @"24", @"25", @"32", @"33"];
    }
    
    if (arr != nil) {
        if (_problemArray.count >= arr.count)
        {
            return [[DrawViewController alloc]init];
        }
        else
        {
            return [self getViewControllerByProblemId:[arr[_problemArray.count] intValue]];
        }
    }
    return nil;
}

- (Option5ProblemViewController*) getOption5ProblemViewController
{
    Option5ProblemViewController* viewController = [[Option5ProblemViewController alloc]init];
    return viewController;
}

- (UIViewController*) getViewControllerByProblemId:(int) problemId
{
    ProblemBaseViewController* viewController = nil;
    switch (problemId) {
        case 1:
        {
            //start
            Option5ProblemViewController * vc = [MainService getOption5ProblemViewController];
            vc.mProblemId = 1;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 31;
            vc.optionH1InnerMargin = 12;
            vc.optionVInnerMargin = 20;
            vc.optionH2InnerMargin = 10;
            viewController = vc;
        }
            break;
        case 2:
        {
            OptionB3ProblemViewController * vc = [[OptionB3ProblemViewController alloc]init];
            vc.mProblemId = 2;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 72;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 3:
        {
            //start
            viewController = [[DropProblemViewController alloc]init];
            viewController.mProblemId = 3;
        }
            break;
        case 4:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 4;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 33;
            vc.optionHInnerMargin = 13;
            viewController = vc;
        }
            break;
        case 5:
        {
            OptionInnerProblemViewController * vc = [[OptionInnerProblemViewController alloc]init];
            vc.mProblemId = 5;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 131;
            vc.optionVInnerMargin = 9;
            vc.mOptionCount = 4;
            viewController = vc;
        }
            break;
        case 6:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 6;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 29;
            vc.optionHInnerMargin = 19;
            vc.optionVInnerMargin = 8;
            viewController = vc;
        }
            break;
        case 7:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 7;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 31;
            vc.optionHInnerMargin = 17;
            vc.optionVInnerMargin = 9;
            viewController = vc;
        }
            break;
        case 8:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 8;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 19;
            vc.optionVInnerMargin = 10;
            viewController = vc;
        }
            break;
        case 9:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 12;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 21;
            vc.optionHInnerMargin = 22;
            vc.optionVInnerMargin = 16;
            viewController = vc;
        }
            break;
        case 10:
        {
            OptionB4ProbleViewController * vc = [[OptionB4ProbleViewController alloc]init];
            vc.mProblemId = 10;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 41;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 11:
        {
            
            OptionB4ProbleViewController * vc = [[OptionB4ProbleViewController alloc]init];
            vc.mProblemId = 11;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 70;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 12:
        {
            Option5ProblemViewController * vc = [MainService getOption5ProblemViewController];
            vc.mProblemId = 12;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 26;
            vc.optionH1InnerMargin = 14;
            vc.optionVInnerMargin = 8;
            vc.optionH2InnerMargin = 14;
            viewController = vc;
        }
            break;
        case 13:
        {
            OptionB3ProblemViewController * vc = [[OptionB3ProblemViewController alloc]init];
            vc.mProblemId = 13;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 68;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 14:
        {
            OptionB4ProbleViewController * vc = [[OptionB4ProbleViewController alloc]init];
            vc.mProblemId = 14;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 45;
            vc.optionHInnerMargin = 19;
            viewController = vc;
        }
            break;
        case 15:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 15;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 19;
            vc.optionVInnerMargin = 10;
            viewController = vc;
        }
            break;
        case 16:
        {
        //盘子
            viewController = [[DropProblemViewController alloc]init];
            viewController.mProblemId = 16;
        }
            break;
        case 17:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 17;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 10;
            viewController = vc;
        }
            break;
        case 18:
        {
            OptionB3ProblemViewController * vc = [[OptionB3ProblemViewController alloc]init];
            vc.mProblemId = 18;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 70;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 19:
            
            break;
        case 20:
        {
            OptionB3ProblemViewController * vc = [[OptionB3ProblemViewController alloc]init];
            vc.mProblemId = 20;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 70;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 21:
        {
            OptionB3ProblemViewController * vc = [[OptionB3ProblemViewController alloc]init];
            vc.mProblemId = 20;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 70;
            vc.optionHInnerMargin = 20;
            viewController = vc;
        }
            break;
        case 22:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 22;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 18;
            vc.optionVInnerMargin = 9;
            viewController = vc;
        }
            break;
        case 23:
        {
            Option5ProblemViewController * vc = [MainService getOption5ProblemViewController];
            vc.mProblemId = 23;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 29;
            vc.optionH1InnerMargin = 12;
            vc.optionVInnerMargin = 14;
            vc.optionH2InnerMargin = 19;
            viewController = vc;
        }
            break;
        case 24:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 24;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 13;
            viewController = vc;
        }
            break;
        case 25:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 25;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 18;
            vc.optionVInnerMargin = 9;
            viewController = vc;
        }
            break;
        case 26:
        {
            OptionInnerProblemViewController * vc = [[OptionInnerProblemViewController alloc]init];
            vc.mProblemId = 26;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 171;
            vc.optionVInnerMargin = 11;
            vc.mOptionCount = 3;
            viewController = vc;
        }
            break;
        case 27:
        {
            Option6ProblemViewController * vc = [[Option6ProblemViewController alloc]init];
            vc.mProblemId = 27;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 11;
            vc.optionVInnerMargin = 15;
            viewController = vc;
        }
            break;
        case 28:
        {
            Option4ProblemViewController * vc = [[Option4ProblemViewController alloc]init];
            vc.mProblemId = 28;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 24;
            vc.optionHInnerMargin = 22;
            vc.optionVInnerMargin = 16;
            viewController = vc;
        }
            break;
        case 29:
        {
            OptionInnerProblemViewController * vc = [[OptionInnerProblemViewController alloc]init];
            vc.mProblemId = 29;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 136;
            vc.optionVInnerMargin = 11;
            vc.mOptionCount = 5;
            viewController = vc;
        }
            break;
        case 30:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 30;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 14;
            viewController = vc;
        }
            break;
        case 31:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 31;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 33;
            vc.optionHInnerMargin = 17;
            viewController = vc;
        }
            break;
        case 32:
        {
            Option3ProbleViewController * vc = [[Option3ProbleViewController alloc]init];
            vc.mProblemId = 32;
            vc.mSingleSelect = YES;
            vc.mBInitData = YES;
            vc.optionMarginTop = 30;
            vc.optionHInnerMargin = 13;
            viewController = vc;
        }
            break;
        case 33:
        {
            OptionInnerProblemViewController * vc = [[OptionInnerProblemViewController alloc]init];
            vc.mProblemId = 33;
            vc.mSingleSelect = NO;
            vc.mBInitData = YES;
            vc.optionMarginTop = 167;
            vc.optionVInnerMargin = 12;
            vc.mOptionCount = 3;
            viewController = vc;
        }
            break;
        default:
            break;
    }
    if (viewController != nil) {
        viewController.mProblemId = problemId;
    }
    return viewController;
}

- (void) sendImage:(UIImage*)image
{
    if (_answerArray.count != 8) {
        return;
    }
    if (_uploadUtil == nil) {
        _uploadUtil = [[UploadUtil alloc]init];
    }
    if (_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    _uploadUtil.age = _curAgeType;
    _uploadUtil.name = _name;
    _uploadUtil.phone = _phone;
    
    NSString* serverIp = [_userDefaults objectForKey:SERVERKEY];
    if (serverIp == nil || serverIp.length == 0) {
        serverIp = @"192.168.1.100";
    }
    
    int score = (rightOption * 100)/totalOption;
    
    NSString* imageName = [NSString stringWithFormat:@"%@-%@-%d-%d-%@-%@-%@-%@-%@-%@-%@-%@.jpg", _phone, _name, _curAgeType, score, _answerArray[0], _answerArray[1], _answerArray[2], _answerArray[3], _answerArray[4], _answerArray[5], _answerArray[6], _answerArray[7]];
    
    [_uploadUtil post:image andName:imageName toIp:serverIp];
    BOOL isForbidQiniu = [_userDefaults boolForKey:QINIUKEY];
    if (!isForbidQiniu) {
        [_uploadUtil qiniuUpload:image andName:[NSString stringWithFormat:@"%@.jpg", _phone]];
    }
}

- (NSArray* ) getAnswer:(int)problemId
{
    NSArray* result = nil;
    switch (problemId) {
        case 1:
        {
            //start
            result = @[@"4"];
        }
            break;
        case 2:
        {
            result = @[@"0", @"1", @"2"];
        }
            break;
        case 3:
        {
            result = @[@"0", @"7", @"10", @"4", @"2", @"5"];
        }
            break;
        case 4:
        {
            result = @[@"2"];
        }
            break;
        case 5:
        {
            result = @[@"2"];
        }
            break;
        case 6:
        {
            result = @[@"3"];
        }
            break;
        case 7:
        {
            result = @[@"0"];
        }
            break;
        case 8:
        {
            result = @[@"0", @"1", @"2", @"3"];
        }
            break;
        case 9:
        {
           result = @[@"3"];
        }
            break;
        case 10:
        {
            result = @[@"0", @"1", @"2", @"3"];
        }
            break;
        case 11:
        {
            
            result = @[@"0", @"1", @"2", @"3"];
        }
            break;
        case 12:
        {
            result = @[@"2", @"3"];
        }
            break;
        case 13:
        {
            result = @[@"2"];
        }
            break;
        case 14:
        {
            result = @[@"0", @"1", @"2", @"3"];
        }
            break;
        case 15:
        {
            result = @[@"0", @"2", @"3"];
        }
            break;
        case 16:
        {
            //盘子
            result = @[@"0", @"1", @"2", @"3", @"4", @"5"];
        }
            break;
        case 17:
        {
            result = @[@"0", @"1"];
        }
            break;
        case 18:
        {
            result = @[@"0"];
        }
            break;
        case 19:
            
            break;
        case 20:
        {
            result = @[@"0", @"1", @"2"];
        }
            break;
        case 21:
        {
            result = @[@"0", @"1", @"2"];
        }
            break;
        case 22:
        {
            result = @[@"0", @"1", @"3"];
        }
            break;
        case 23:
        {
            result = @[@"4"];
        }
            break;
        case 24:
        {
            result = @[@"0", @"1", @"2"];
        }
            break;
        case 25:
        {
            result = @[@"0", @"3"];
        }
            break;
        case 26:
        {
            //都对
        }
            break;
        case 27:
        {
            result = @[@"0", @"1", @"2", @"3", @"4", @"5"];
        }
            break;
        case 28:
        {
            result = @[@"4"];
        }
            break;
        case 29:
        {
            result = @[@"0", @"1", @"2", @"4"];
        }
            break;
        case 30:
        {
            result = @[@"1"];
        }
            break;
        case 31:
        {
            result = @[@"1"];
        }
            break;
        case 32:
        {
            result = @[@"0"];
        }
            break;
        case 33:
        {
            result = @[@"0", @"1", @"2"];
        }
            break;
        default:
            break;
    }
    if ( result== nil) {
        return nil;
    }
    NSMutableArray* arr = [NSMutableArray array];
    for (NSNumber* num in result)
    {
        [arr addObject:[NSNumber numberWithInt:(num.intValue + 1)]];
    }
    return arr;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    if (mobileNum.length != 11) {
        return NO;
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
