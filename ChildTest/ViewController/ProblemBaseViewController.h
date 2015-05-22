//
//  ProblemBaseViewController.h
//  ChildTest
//
//  Created by 淞 柴 on 15/5/5.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DQBaseViewController.h"
#import "DQMainService.h"

#define ButtonTagBegin 12390

@interface ProblemBaseViewController : DQBaseViewController
{
    int problemId;
    int optionCount;
    BOOL singleSelect;
    NSMutableArray* answerArray;
}

@property (nonatomic, assign) BOOL mBInitData; // 数据外界处理
@property (nonatomic, assign) int mProblemId;
@property (nonatomic, assign) BOOL mSingleSelect;
@property (nonatomic, assign) int mOptionCount;

- (UIButton*) genOptionBtn:(int)i;
- (void) onOptionBtnClick:(UIButton*) sender;
- (void) onClickNextBtn;
@end
