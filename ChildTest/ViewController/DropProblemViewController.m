//
//  DropProblemViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/9.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DropProblemViewController.h"

@interface DropProblemViewController ()
{
    NSMutableArray* _originPointArray;
    UIImageView* plateImageView;
}

@end

@implementation DropProblemViewController
- (void) viewDidLoad
{
    optionCount = 11;
    if (problemId == 16) {
        optionCount = 7;
    }
    [super viewDidLoad];
    
    _originPointArray = [NSMutableArray arrayWithCapacity:optionCount];
    
    UIImage* titleImg = [UIImage DQImageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_title": @"p%d_title", problemId]];
    UIImageView* titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImg.size.width)/2, 240/2, titleImg.size.width, titleImg.size.height)];
    titleImageView.image = titleImg;
    [self.view addSubview:titleImageView];
    
    UIImage* plateImage = [UIImage DQImageNamed:@"plate"];
    plateImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - plateImage.size.width)/2, titleImageView.bottom + 30, plateImage.size.width, plateImage.size.height)];
    plateImageView.image = plateImage;
    [self.view addSubview:plateImageView];
    
    if (problemId == 16)
    {
        UIImageView* btn1 = [self genDropOptionBtn:1];
        btn1.origin = CGPointMake(35, 229 + 70);
        [self.view addSubview:btn1];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn1.origin]];
        
        UIImageView* btn2 = [self genDropOptionBtn:2];
        btn2.origin = CGPointMake(btn1.left, btn1.bottom + 30);
        [self.view addSubview:btn2];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn2.origin]];
        
        UIImageView* btn3 = [self genDropOptionBtn:3];
        btn3.origin = CGPointMake(btn1.right + 20, btn1.top);
        [self.view addSubview:btn3];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn3.origin]];
        
        UIImageView* btn4 = [self genDropOptionBtn:4];
        btn4.origin = CGPointMake(btn3.left, btn2.top);
        [self.view addSubview:btn4];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn4.origin]];
        
        UIImageView* btn5 = [self genDropOptionBtn:5];
        btn5.origin = CGPointMake(plateImageView.right + 15, btn1.top);
        [self.view addSubview:btn5];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn5.origin]];
        
        UIImageView* btn6 = [self genDropOptionBtn:6];
        btn6.origin = CGPointMake(btn5.left, btn2.top);
        [self.view addSubview:btn6];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn6.origin]];
        
        
        UIImageView* btn7 = [self genDropOptionBtn:7];
        btn7.origin = CGPointMake(btn5.right + 20, btn5.top + 70);
        [self.view addSubview:btn7];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn7.origin]];
        
    }
    else
    {
        UIImageView* btn1 = [self genDropOptionBtn:1];
        btn1.origin = CGPointMake(30, 229);
        [self.view addSubview:btn1];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn1.origin]];
        
        UIImageView* btn2 = [self genDropOptionBtn:2];
        btn2.origin = CGPointMake(btn1.left, btn1.bottom + 30);
        [self.view addSubview:btn2];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn2.origin]];
        
        UIImageView* btn3 = [self genDropOptionBtn:3];
        btn3.origin = CGPointMake(btn2.left, btn2.bottom + 30);
        [self.view addSubview:btn3];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn3.origin]];
        
        UIImageView* btn4 = [self genDropOptionBtn:4];
        btn4.origin = CGPointMake(btn1.right + 20, btn1.top);
        [self.view addSubview:btn4];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn4.origin]];
        
        UIImageView* btn5 = [self genDropOptionBtn:5];
        btn5.origin = CGPointMake(btn4.left, btn2.top);
        [self.view addSubview:btn5];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn5.origin]];
        
        UIImageView* btn6 = [self genDropOptionBtn:6];
        btn6.origin = CGPointMake(btn4.left, btn3.top);
        [self.view addSubview:btn6];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn6.origin]];
        
        
        UIImageView* btn7 = [self genDropOptionBtn:7];
        btn7.origin = CGPointMake(plateImageView.right + 20, titleImageView.bottom + 120);
        [self.view addSubview:btn7];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn7.origin]];
        
        UIImageView* btn8 = [self genDropOptionBtn:8];
        btn8.origin = CGPointMake(btn7.left, btn7.bottom + 25);
        [self.view addSubview:btn8];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn8.origin]];
        
        UIImageView* btn9 = [self genDropOptionBtn:9];
        btn9.origin = CGPointMake(btn7.right + 20, btn1.top);
        [self.view addSubview:btn9];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn9.origin]];
        
        UIImageView* btn10 = [self genDropOptionBtn:10];
        btn10.origin = CGPointMake(btn9.left, btn2.top);
        [self.view addSubview:btn10];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn10.origin]];
        
        UIImageView* btn11 = [self genDropOptionBtn:11];
        btn11.origin = CGPointMake(btn9.left, btn3.top);
        [self.view addSubview:btn11];
        [_originPointArray addObject:[NSValue valueWithCGPoint:btn11.origin]];
    }
}

- (UIImageView*) genDropOptionBtn:(int)i
{
    UIImage* image = [UIImage DQImageNamed:[NSString stringWithFormat:problemId<10? @"p0%d_option%d": @"p%d_option%d", problemId, i]];
    UIImageView* imageBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageBtn setImage:image];
    imageBtn.tag = ButtonTagBegin + i;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [imageBtn addGestureRecognizer:panGestureRecognizer];
    [imageBtn setUserInteractionEnabled:YES];
    return imageBtn;
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    [self focusCurRecognizer:recognizer];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
       
        if ([self isInPlate:recognizer.view.center]) {
            [self addOption:(recognizer.view.tag - ButtonTagBegin)];
        }
        else
        {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                recognizer.view.origin = [[_originPointArray objectAtIndex:(recognizer.view.tag - ButtonTagBegin - 1)] CGPointValue];
            } completion:^(BOOL finished) {
                [self removeOption:(recognizer.view.tag - ButtonTagBegin)];
            }];
        }
    }
}

- (BOOL) isInPlate:(CGPoint)point
{
    CGPoint center = plateImageView.center;
    int mX = point.x - center.x;
    int mY = point.y - center.y;
    
    int result = mX * mX + mY * mY;
    
    if (result > 170*170) {//盘子半径
        return false;
    }
    return true;
}

- (void) removeOption:(int)i
{
    BOOL canRemove = NO;
    for (NSNumber *number in answerArray) {
        if (number.intValue == i) {
            canRemove = YES;
            break;
        }
    }
    if (canRemove) {
        [answerArray removeObject:[NSNumber numberWithInt:i]];
    }
}

- (void) addOption:(int)i
{
    BOOL canInsert = YES;
    for (NSNumber *number in answerArray) {
        if (number.intValue == i) {
            canInsert = NO;
            break;
        }
    }
    if (canInsert) {
        [answerArray addObject:[NSNumber numberWithInt:i]];
    }
}

- (void) focusCurRecognizer:(UIGestureRecognizer*)recognizer
{
    UIView* view = recognizer.view;
    UIView* superview = view.superview;
    [superview bringSubviewToFront:view];
}


- (void) onClickNextBtn
{
    if (answerArray.count != 0)
    {
        [MainService addProblemAnswer:problemId Answer:answerArray];
        UIViewController* viewController = [MainService getViewControllerByProblemId:4];
        [MainService.mainWindow setRootViewController:viewController];
    }
}
@end
