//
//  DrawViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DrawViewController.h"
#import "HappyGestureRecognizer.h"
#import "PJRSignatureView.h"
#import "DQMainService.h"
#import "EndViewController.h"
#import "TestViewController.h"

#define RGBColor(a, b, c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1.0]

#define ColorArray @[RGBColor(53, 33, 22), RGBColor(233, 61, 130), RGBColor(248, 210, 1), RGBColor(152, 222, 250), RGBColor(132, 211, 83)]

@interface DrawViewController ()<UIGestureRecognizerDelegate>
{
    UIImageView* _bgImageView;
    UIButton* _reset;
    UIButton* _commit;
    UIButton* _erase;
    
    BOOL isDrawing;  //YES表示用于画笔
    PJRSignatureView* _drawView;
    
    NSMutableArray* _drawingImageViewArray;
    
    NSInteger _lineWidth;
}

@end

@implementation DrawViewController

- (void) viewDidLoad
{
    isDrawing = NO;
    _drawingImageViewArray = [NSMutableArray array];
    [super viewDidLoad];
    
    UIImage* titleImage = [UIImage DQImageNamed:@"draw_title"];
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImage.size.width)/2, 72/2, titleImage.size.width, titleImage.size.height)];
    titleImageView.image = titleImage;
    [self.view addSubview:titleImageView];
    
    UIImage* bgImage = [UIImage DQImageNamed:@"draw_bg"];
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MMScreenWidth - bgImage.size.width - 295/2, 247/2, bgImage.size.width, bgImage.size.height)];
    _bgImageView.image = bgImage;
    _bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImageView];
    
    _drawView = [[PJRSignatureView alloc] initWithFrame:CGRectMake(30, 20, _bgImageView.width - 55, _bgImageView.height - 40)];
    _drawView.drawingMode = DrawingModeNone;
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    _lineWidth = [userDefaults integerForKey:DRAWWIDTHKEY];
    _lineWidth = _lineWidth == 0? 8 : _lineWidth;
    [_drawView setLineWidth:_lineWidth];
    [_drawView setBackgroundColor:[UIColor clearColor]];
    [_bgImageView addSubview:_drawView];
    
    UIImage* fgImage = [UIImage DQImageNamed:@"draw_fg"];
    UIImageView* fgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 410, fgImage.size.width, fgImage.size.height)];
    fgImageView.image = fgImage;
    fgImageView.userInteractionEnabled = NO;
    [_bgImageView addSubview:fgImageView];
    
    UIImage* resetImage = [UIImage DQImageNamed:@"draw_reset"];
    _reset = [[UIButton alloc]initWithFrame:CGRectMake(MMScreenWidth - 350/2 - resetImage.size.width, 310/2, resetImage.size.width, resetImage.size.height)];
    [_reset setImage:resetImage forState:UIControlStateNormal];
    [_reset addTarget:self action:@selector(onClickResetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reset];
    
    UIImage* commitImage = [UIImage DQImageNamed:@"draw_complete"];
    _commit = [[UIButton alloc]initWithFrame:CGRectMake((MMScreenWidth - commitImage.size.width)/2, (MMScreenHeight - commitImage.size.height - 152/2), commitImage.size.width, commitImage.size.height)];
    [_commit setImage:commitImage forState:UIControlStateNormal];
    [_commit addTarget:self action:@selector(onClickCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commit];
    
    UIImage* logoImage = [UIImage DQImageNamed:@"draw_logo"];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (MMScreenHeight - logoImage.size.height - 110/2), logoImage.size.width, logoImage.size.height)];
    logoImageView.image = logoImage;
    [self.view addSubview:logoImageView];
    
    UIImage* eraseImage = [UIImage DQImageNamed:@"draw_erase"];
    _erase = [[UIButton alloc]initWithFrame:CGRectMake(50, 258/2, eraseImage.size.width, eraseImage.size.height)];
    [_erase setImage:eraseImage forState:UIControlStateNormal];
    [_erase addTarget:self action:@selector(onClickEraseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_erase];
    
    int y = _erase.bottom + 18 - 10;
    for (int i = 1; i < 6; i++) {
        UIButton* btn = [self genColorBtn:i];
        btn.origin = CGPointMake(_erase.x, y + 10);
        [self.view addSubview:btn];
        y = btn.bottom;
    }
    
    y = _erase.top - 5;
    for (int i = 1; i < 6; i++) {
        UIButton* btn = [self genImageBtn:i];
        btn.origin = CGPointMake(MMScreenWidth - btn.width - 25, y + 5);
        [self.view addSubview:btn];
        y = btn.bottom;
    }
    
}

- (UIButton*) genColorBtn:(int)i
{
    UIImage* colorImage = [UIImage DQImageNamed:[NSString stringWithFormat:@"draw_color%d", i]];
    UIButton* colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, colorImage.size.width, colorImage.size.height)];
    [colorBtn setImage:colorImage forState:UIControlStateNormal];
    colorBtn.tag = 10200 + i;
    [colorBtn addTarget:self action:@selector(onClickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
    return colorBtn;
}

- (UIButton*) genImageBtn:(int)i
{
    UIImage* image = [UIImage DQImageNamed:[NSString stringWithFormat:@"draw_img%d", i]];
    UIButton* imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageBtn setImage:image forState:UIControlStateNormal];
    imageBtn.tag = 10300 + i;
    [imageBtn addTarget:self action:@selector(onClickImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    return imageBtn;
}


- (void) onClickColorBtn:(UIButton*)sender
{
    isDrawing = YES;
    _drawView.drawingMode = DrawingModePaint;
    _drawView.lineColor = ColorArray[sender.tag - 10200 - 1];
    _drawView.lineWidth = _lineWidth;
}

- (void) onClickEraseBtn:(UIButton*)sender
{
    isDrawing = YES;
    _drawView.drawingMode = DrawingModePaint;
    _drawView.lineColor = [UIColor whiteColor];
    _drawView.lineWidth = _lineWidth + 10;
}

- (void) onClickResetBtn:(UIButton*)sender
{
    isDrawing = NO;
    _drawView.drawingMode = DrawingModeNone;
    _drawView.lineWidth = _lineWidth;
    [_drawView clear];
    for (UIView* view in _drawingImageViewArray) {
        [view removeFromSuperview];
    }
    [_drawingImageViewArray removeAllObjects];
    
}

- (void) onClickCommitBtn:(UIButton*)sender
{
    UIImage *imageRet = nil;
    UIGraphicsBeginImageContext(_bgImageView.frame.size);
    //获取图像
    [_bgImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [MainService sendImage:imageRet];
    [MainService.mainWindow setRootViewController:[[EndViewController alloc]init]];
}

- (void) onClickImageBtn:(UIButton*)sender
{
    isDrawing = NO;
    _drawView.drawingMode = DrawingModeNone;
    
    UIImage* image = [UIImage DQImageNamed:[NSString stringWithFormat:@"draw%d", (int)(sender.tag - 10300)]];
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.center = CGPointMake(_drawView.width/2, _drawView.height/2);
    [_drawingImageViewArray addObject:imageView];
    
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
    [imageView addGestureRecognizer:panGestureRecognizer];
    [imageView addGestureRecognizer:pinchGestureRecognizer];
    [imageView addGestureRecognizer:rotateRecognizer];
    [imageView addGestureRecognizer:tapRecognizer];
    [imageView addGestureRecognizer:happyRecognizer];
    
    [tapRecognizer requireGestureRecognizerToFail:panGestureRecognizer];
    
    [imageView setUserInteractionEnabled:YES];
    
    [_drawView addSubview:imageView];
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    [self focusCurRecognizer:recognizer];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:_drawView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
//        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
            
        } completion:^(BOOL finished) {
            if (finalPoint.x < 0 || finalPoint.y < 0 || finalPoint.x > _drawView.width || finalPoint.y > _drawView.height)
            {
                [_drawingImageViewArray removeObject:recognizer.view];
                [recognizer.view removeFromSuperview];
            }
        }];
        
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
 
}

- (void)handleHappy:(HappyGestureRecognizer *)recognizer{
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (isDrawing) {
        return NO;
    }
    return YES;
}

- (void) focusCurRecognizer:(UIGestureRecognizer*)recognizer
{
    UIView* view = recognizer.view;
    UIView* superview = view.superview;
    [superview bringSubviewToFront:view];
}

@end
