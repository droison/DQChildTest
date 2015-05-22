//
//  AppDelegate.m
//  ChildTest
//
//  Created by 淞 柴 on 15/3/18.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "DrawViewController.h"
#import "PIDrawerViewController.h"

#import <FIR/FIR.h>

#define __MAKE_VERSION__(platform, major, minor, build) \
((platform << 24) | (major << 16) | (minor << 8) | (build))


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController* viewcontroller = [[StartViewController alloc]init];
    self.window.rootViewController = viewcontroller;
    [self.window makeKeyAndVisible];
    
    //crash report
    [FIR handleCrashWithKey:@"1ea3cac84fdf07f02664a1d2681976e5"];
    [self tryUpdate];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) tryUpdate
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fir.im/api/v2/app/version/552d4a4dfc0b1a33700006ae"]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            @try {
                NSDictionary *result= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                //对比版本
                NSString * version=result[@"version"]; //对应 CFBundleVersion, 对应Xcode项目配置"General"中的 Build
                UInt32 lastVersion = [self getVersion:version];
                
                NSString * localVersion=[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
                UInt32 curVersion = [self getVersion:localVersion];
                
                NSString *url=result[@"installUrl"]; //如果有更新 需要用Safari打开的地址
                
                if (curVersion < lastVersion) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@", url]]];
                }
                //这里放对比版本的逻辑  每个 app 对版本更新的理解都不同
                //有的对比 version, 有的对比 build
                
            }
            @catch (NSException *exception) {
                //返回格式错误 忽略掉
            }
        }
        
    }];
}

- (UInt32) getVersion :(NSString*)strVersion
{
    NSArray *versionBitSet = [strVersion componentsSeparatedByString:@"."];
    if (versionBitSet.count != 3) {
        return 0;
    }
    
    UInt32 major = [[versionBitSet objectAtIndex:0] unsignedIntValue];
    UInt32 minor = [[versionBitSet objectAtIndex:1] unsignedIntValue];
    UInt32 build = [[versionBitSet objectAtIndex:2] unsignedIntValue];
    UInt32 uiVersion = __MAKE_VERSION__(1, major, minor, build);
    
    return uiVersion;
}
@end
