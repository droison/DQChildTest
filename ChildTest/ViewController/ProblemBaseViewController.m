//
//  ProblemBaseViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/5.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "ProblemBaseViewController.h"
#import "DQMainService.h"

@interface ProblemBaseViewController ()
{
    UIImageView* _titleImageView;
    UIButton* _nextBtn;
}
@end

@implementation ProblemBaseViewController
@synthesize mProblemId = problemId;
@synthesize mSingleSelect = singleSelect;
@synthesize mOptionCount = optionCount;

- (void) viewDidLoad
{
    answerArray = [NSMutableArray array];
    [super viewDidLoad];
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"problem_title%d", (int)(MainService.curAgeType + 1)]];
    _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - image.size.width)/2, 40, image.size.width, image.size.height)];
    _titleImageView.image = image;
    [self.view addSubview:_titleImageView];
    
    UIImage* nextImage = [UIImage imageNamed:@"problem_next"];
    _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(MMScreenWidth - nextImage.size.width - 25, 20, nextImage.size.width, nextImage.size.height)];
    [_nextBtn setImage:nextImage forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(onClickNextBtnV2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:_titleImageView];
}

- (UIButton*) genOptionBtn:(int)i
{
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_option%d": @"p%d_option%d", problemId, i]];
    UIImage* imageHL = [UIImage imageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_option%d_hl": @"p%d_option%d_hl", problemId, i]];
    UIButton* imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageBtn setImage:image forState:UIControlStateNormal];
    [imageBtn setImage:imageHL forState:UIControlStateHighlighted];
    [imageBtn setImage:imageHL forState:UIControlStateSelected];
    imageBtn.tag = ButtonTagBegin + i;
    [imageBtn addTarget:self action:@selector(onOptionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return imageBtn;
}

//单选
- (void) onOptionBtnClick:(UIButton*) sender
{
    if (!singleSelect) {
        sender.selected = !sender.selected;
        if (sender.selected)
        {
            [answerArray addObject:[NSNumber numberWithLong:(sender.tag - ButtonTagBegin + 1)]];//答案应该从1开始算
        }
        else
        {
            [answerArray removeObject:[NSNumber numberWithLong:(sender.tag - ButtonTagBegin + 1)]];//答案应该从1开始算
        }
        return;
    }
    [answerArray removeAllObjects];
    [answerArray addObject:[NSNumber numberWithLong:(sender.tag - ButtonTagBegin + 1)]]; //答案应该从1开始算
    for (int i = 0; i < optionCount; i++) {
        UIButton* btn = (UIButton*) [self.view viewWithTag:(ButtonTagBegin + i)]; //答案应该从1开始算
        if (sender == btn) {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
    }
}

- (void) onClickNextBtnV2
{
    if (answerArray.count != 0)
    {
        [MainService addProblemAnswer:problemId Answer:answerArray];
    }
}

- (void) onClickNextBtn
{

}

@end
