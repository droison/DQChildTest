//
//  TestViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/4/15.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "TestViewController.h"
#import "UploadUtil.h"



@interface TestViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UITextField* _ipField;
    UITextField* _picName;
    UIImageView* _imageView;
    UIImage* _image;
    
    UIImagePickerController* _localPicker;
    
    NSUserDefaults *_userDefaults;
    UploadUtil* _uploadUtil;
    
    UITextField* _drawWidth;
    UITextField* _drawDpi;
}
@end

@implementation TestViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIButton* backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(10, 30, 60, 30);
    backBtn.layer.borderColor = [UIColor blueColor].CGColor;
    backBtn.layer.borderWidth = 1;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton* saveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    saveBtn.frame = CGRectMake(90, 30, 60, 30);
    saveBtn.layer.borderColor = [UIColor blueColor].CGColor;
    saveBtn.layer.borderWidth = 1;
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];

    
    /**
    UIButton* chooseBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [chooseBtn setTitle:@"选个图" forState:(UIControlStateNormal)];
    chooseBtn.frame = CGRectMake(10, 30, 60, 30);
    chooseBtn.layer.borderColor = [UIColor blueColor].CGColor;
    chooseBtn.layer.borderWidth = 1;
    [chooseBtn addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseBtn];
    
    
    UIButton* sendBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    sendBtn.frame = CGRectMake(90, 30, 60, 30);
    sendBtn.layer.borderColor = [UIColor blueColor].CGColor;
    sendBtn.layer.borderWidth = 1;
    [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
     **/
    
    _ipField = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, 300, 40)];
    _ipField.placeholder = @"服务器ip地址(例:192.168.1.101)";
    _ipField.layer.borderColor = [UIColor grayColor].CGColor;
    _ipField.layer.borderWidth = 1;
    [self.view addSubview:_ipField];
    
    /**
    _picName = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, 300, 40)];
    _picName.placeholder = @"图片名，不加jpg或png扩展名";
    _picName.layer.borderColor = [UIColor grayColor].CGColor;
    _picName.layer.borderWidth = 1;
    [self.view addSubview:_picName];
     **/
    UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(10, 150, 80, 40)];
    [switchView addTarget:self action:@selector(switchQiniu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchView];
    
    UILabel* label = [[UILabel alloc]init];
    label.text = @"是否关闭客户端上传七牛";
    [label sizeToFit];
    label.frame = CGRectMake(100, 150, label.width, label.height);
    [self.view addSubview:label];
    
    
    UILabel* drawWidthLable = [[UILabel alloc]init];
    drawWidthLable.text = @"笔粗细(请输入1-50)";
    [drawWidthLable sizeToFit];
    drawWidthLable.frame = CGRectMake(10, switchView.bottom + 20, drawWidthLable.width, drawWidthLable.height);
    [self.view addSubview:drawWidthLable];
    _drawWidth = [[UITextField alloc]initWithFrame:CGRectMake(drawWidthLable.right + 10, drawWidthLable.top, 300, drawWidthLable.height)];
    _drawWidth.placeholder = @"";
    _drawWidth.layer.borderColor = [UIColor grayColor].CGColor;
    _drawWidth.layer.borderWidth = 1;
    [self.view addSubview:_drawWidth];
    
    UILabel* drawDpiLable = [[UILabel alloc]init];
    drawDpiLable.text = @"图片质量(请输入0.1-1)";
    [drawDpiLable sizeToFit];
    drawDpiLable.frame = CGRectMake(10, drawWidthLable.bottom + 20, drawDpiLable.width, drawDpiLable.height);
    [self.view addSubview:drawDpiLable];
    _drawDpi = [[UITextField alloc]initWithFrame:CGRectMake(drawDpiLable.right + 10, drawDpiLable.top, 300, drawDpiLable.height)];
    _drawDpi.placeholder = @"";
    _drawDpi.layer.borderColor = [UIColor grayColor].CGColor;
    _drawDpi.layer.borderWidth = 1;
    [self.view addSubview:_drawDpi];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 220, 300, 300)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    _userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* serverIp = [_userDefaults objectForKey:SERVERKEY];
    if (serverIp != nil && serverIp.length > 0)
    {
        _ipField.text = serverIp;
    }
    switchView.on = [_userDefaults boolForKey:QINIUKEY];
    
    NSInteger lineWidth = [_userDefaults integerForKey:DRAWWIDTHKEY];
    _drawWidth.placeholder = [NSString stringWithFormat:@"当前值:%d", lineWidth == 0? 8 : lineWidth];
    
    float dpi = [_userDefaults floatForKey:DRAWDPIKEY];
    _drawDpi.placeholder = [NSString stringWithFormat:@"当前值:%f", dpi == 0? 0.52 : dpi];
}

- (void) back
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) save
{
    NSString* ip = _ipField.text;
    [_userDefaults setObject:ip forKey:SERVERKEY];
    
    int lineWidth = [_drawWidth.text intValue];
    if (lineWidth < 1) {
        lineWidth = 1;
    }
    if (lineWidth > 50) {
        lineWidth = 50;
    }
    [_userDefaults setInteger:lineWidth forKey:DRAWWIDTHKEY];
    
    float dpi = _drawDpi.text.floatValue;
    if (dpi < 0.1) {
        dpi = 0.1;
    }
    if (dpi > 1) {
        dpi = 1;
    }
    [_userDefaults setInteger:dpi forKey:DRAWDPIKEY];
    
    [_userDefaults synchronize];
}

- (void) switchQiniu:(UISwitch*) switchView
{
    [_userDefaults setBool:switchView.on  forKey:QINIUKEY];
    [_userDefaults synchronize];
}

- (void) chooseImage
{
    _localPicker = [[UIImagePickerController alloc] init];
    _localPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _localPicker.delegate = self;
//    _localPicker.allowsEditing = YES;
    [self presentViewController:_localPicker animated:YES completion:nil];
}

- (void) send
{
    if (_uploadUtil == nil) {
        _uploadUtil = [[UploadUtil alloc]init];
    }
    NSString* name = _picName.text;
    NSString* ip = _ipField.text;
    if (name == nil || name.length == 0 || ip == nil || ip.length == 0) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"服务器地址和图片名字不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (_image == nil) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"图片不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    name = [NSString stringWithFormat:@"%@.jpg", name];
    [_userDefaults setObject:ip forKey:SERVERKEY];
    [_userDefaults synchronize];
    [_uploadUtil post:_image andName:name toIp:ip];
    [_uploadUtil qiniuUpload:_image andName:name];
    _picName.text = @"";
    _image = nil;
    _imageView.image = nil;
}


#pragma mark - UIImagePickerControllerDelegate
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _imageView.image = _image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
