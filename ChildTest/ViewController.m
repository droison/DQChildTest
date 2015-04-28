//
//  ViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/3/18.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import <QiniuSDK.h>
#import "GesViewController.h"
#import "PIDrawerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    UIImage* img = [QRCodeGenerator qrImageForString:@"http://7vii9n.com1.z0.glb.clouddn.com/iosqiniutest.png" imageSize:button.bounds.size.width];
    [button setImage:img forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openDrawVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) openGesVC
{
    GesViewController* vc = [[GesViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) openDrawVC
{
    PIDrawerViewController* vc = [[PIDrawerViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
