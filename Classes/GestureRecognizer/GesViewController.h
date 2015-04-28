//
//  GesViewController.h
//  GestureRecognizer
//
//  Created by rongfzh on 13-2-26.
//  Copyright (c) 2013年 rongfzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GesViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong) AVAudioPlayer * chompPlayer;
@property (strong) AVAudioPlayer * hehePlayer;

@end
