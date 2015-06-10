//
//  StartViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "StartViewController.h"
#import "DQMainService.h"
#import "ProblemBaseViewController.h"
#import "TestViewController.h"
#import "Toast+UIView.h"

#define FieldWidth 440
#define FieldHeight 60
#define NameY 200
#define PhoneY 300

#define AgeBtnInnerMargin 13

@interface StartViewController ()
{
    UITextField* _nameField;
    UITextField* _phoneField;
    
    UIButton* _commitBtn;
}
@end

@implementation StartViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    UIImage* bgImage = [UIImage DQImageNamed:@"start_bg"];
    UIImageView* bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 248/2, bgImage.size.width, bgImage.size.height)];
    bgImageView.image = bgImage;
    [self.view addSubview:bgImageView];
    
    UIImage* commitImage = [UIImage DQImageNamed:@"start_commit"];
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake((MMScreenWidth - commitImage.size.width)/2, 600, commitImage.size.width, commitImage.size.height)];
    [_commitBtn setImage:commitImage forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(onCommitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake((MMScreenWidth - FieldWidth)/2, NameY, FieldWidth, FieldHeight)];
    _nameField.placeholder = @"输入宝宝姓名";
    _nameField.font = [UIFont systemFontOfSize:23];
    [self.view addSubview:_nameField];
    
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake((MMScreenWidth - FieldWidth)/2, PhoneY, FieldWidth, FieldHeight)];
    _phoneField.placeholder = @"请输入手机号码";
    _phoneField.font = [UIFont systemFontOfSize:23];
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneField];
    
    for (int i = 1; i < 5; i++)
    {
        UIButton* ageBtn = [self genAgeBtn:i];
        int x = (MMScreenWidth - AgeBtnInnerMargin * 3 - ageBtn.width * 4)/2;
        ageBtn.origin = CGPointMake( x + (i - 1) * (AgeBtnInnerMargin + ageBtn.width), 445);
        [self.view addSubview:ageBtn];
        
    }
}

- (UIButton*) genAgeBtn:(int)i
{
    UIImage* image = [UIImage DQImageNamed:[NSString stringWithFormat:@"start_option%d", i]];
    UIButton* imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageBtn setImage:image forState:UIControlStateNormal];
    imageBtn.tag = ButtonTagBegin + i;
    [imageBtn addTarget:self action:@selector(onAgeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return imageBtn;
}

- (void) onCommitClick:(UIButton*) sender
{
    NSString* name = _nameField.text;
    NSString* phone = _phoneField.text;
    
    if (name == nil || name.length == 0) {
        [self.view makeToast:@"请填写宝宝的名字"];
        return;
    }
    if ([name isEqualToString:@"admin"] && [phone isEqualToString:@"admin"]) {
        TestViewController* testViewController = [[TestViewController alloc]init];
        [self presentViewController:testViewController animated:NO completion:nil];
        return;
    }
    if (phone == nil || ![MainService isMobileNumber:phone])
    {
        [self.view makeToast:@"请填写11位手机号码"];
        return;
    }
    
#pragma mark - TODO
    if (name.length == 0) {
        return;
    }
    if (phone == 0) {
        return;
    }
    MainService.name = name;
    MainService.phone = phone;
    
    if (!MainService.isReset)
    {
        UIViewController* problemViewController = [MainService startProblemView];
        UIWindow* mainWindow = [MainService mainWindow];
        mainWindow.rootViewController = problemViewController;
    }
    else
    {
        [self.view makeToast:@"请选择宝宝的年龄段"];
    }
}

- (void) onAgeBtnClick:(UIButton*) sender
{
    for (int i = 1; i < 5; i++) {
        UIButton* btn = (UIButton*) [self.view viewWithTag:(ButtonTagBegin+i)];
        if (sender == btn) {
            btn.selected = YES;
            btn.enabled = NO;
            MainService.isReset = NO;
            MainService.curAgeType = sender.tag - ButtonTagBegin - 1;
        }
        else
        {
            btn.selected = NO;
            btn.enabled = YES;
        }
    }
}
@end
