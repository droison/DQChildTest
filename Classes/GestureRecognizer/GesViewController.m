//
//  GesViewController.m
//  GestureRecognizer
//
//  Created by rongfzh on 13-2-26.
//  Copyright (c) 2013年 rongfzh. All rights reserved.
//

#import "GesViewController.h"
#import "HappyGestureRecognizer.h"

@interface GesViewController ()

@end

@implementation GesViewController

- (AVAudioPlayer *)loadWav:(NSString *)filename {
    NSURL * url = [[NSBundle mainBundle] URLForResource:filename withExtension:@"wav"];
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!player) {
        NSLog(@"Error loading %@: %@", url, error.localizedDescription);
    } else {
        [player prepareToPlay];
    }
    return player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *snakeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snake.png"]];
    UIImageView *dragonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dragon.png"]];
    
    [self configSubViews:@[@"AlbumAddQQSpaceBigHL@2x.png", @"AlbumAddTwitterBigHL@2x.png", @"AlbumCellGreenSelected@2x.png", @"AlbumCellRedSelected@2x.png", @"AlbumCheckmark@2x.png", @"AlbumGroupIconHL@2x.png"]];
    
    snakeImageView.frame = CGRectMake(120, 120, 100, 160);
    dragonImageView.frame = CGRectMake(50, 50, 100, 160);
    [self.view addSubview:snakeImageView];
    [self.view addSubview:dragonImageView];
    
    for (UIView *view in self.view.subviews) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handlePinch:)];
        
        UIRotationGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(handleRotate:)];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handleTap:)];
        
        HappyGestureRecognizer *happyRecognizer = [[HappyGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handleHappy:)];
        
        panGestureRecognizer.delegate = self;
        pinchGestureRecognizer.delegate = self;
        rotateRecognizer.delegate = self;
        [view addGestureRecognizer:panGestureRecognizer];
        [view addGestureRecognizer:pinchGestureRecognizer];
        [view addGestureRecognizer:rotateRecognizer];
        [view addGestureRecognizer:tapRecognizer];
        [view addGestureRecognizer:happyRecognizer];
        
        [tapRecognizer requireGestureRecognizerToFail:panGestureRecognizer];
         
        [view setUserInteractionEnabled:YES];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.chompPlayer = [self loadWav:@"chomp"];
    self.hehePlayer = [self loadWav:@"hehehe1"];}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    [self focusCurRecognizer:recognizer];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                       recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
        
    }
    
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self focusCurRecognizer:recognizer];
    [self.chompPlayer play];
}

- (void)handleHappy:(HappyGestureRecognizer *)recognizer{
    [self.hehePlayer play];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) focusCurRecognizer:(UIGestureRecognizer*)recognizer
{
    UIView* view = recognizer.view;
    UIView* superview = view.superview;
    [superview bringSubviewToFront:view];
}

- (void) configSubViews:(NSArray*) imageNames
{
    for (NSString* str in imageNames) {
        UIImage* image = [UIImage imageNamed:str];
        UIImageView *img6 = [[UIImageView alloc] initWithImage:image];
        img6.frame = CGRectMake(0, 100, image.size.width, image.size.height);
        [self.view addSubview:img6];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
