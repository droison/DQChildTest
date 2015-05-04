//
//  DrawViewController.m
//  ChildTest
//
//  Created by 淞 柴 on 15/5/4.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()
{
    UIImageView* _bgImageView;
    UIButton* _reset;
    UIButton* _commit;
    UIButton* _erase;
}

@end

@implementation DrawViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIImage* titleImage = [UIImage imageNamed:@"draw_title@2x.png"];
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MMScreenWidth - titleImage.size.width)/2, 72/2, titleImage.size.width, titleImage.size.height)];
    titleImageView.image = titleImage;
    [self.view addSubview:titleImageView];
    
    UIImage* bgImage = [UIImage imageNamed:@"draw_bg"];
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MMScreenWidth - bgImage.size.width - 295/2, 247/2, bgImage.size.width, bgImage.size.height)];
    _bgImageView.image = bgImage;
    [self.view addSubview:_bgImageView];
    
    UIImage* resetImage = [UIImage imageNamed:@"draw_reset"];
    _reset = [[UIButton alloc]initWithFrame:CGRectMake(MMScreenWidth - 350/2 - resetImage.size.width, 310/2, resetImage.size.width, resetImage.size.height)];
    [_reset setImage:resetImage forState:UIControlStateNormal];
    [self.view addSubview:_reset];
    
    UIImage* commitImage = [UIImage imageNamed:@"draw_complete"];
    _commit = [[UIButton alloc]initWithFrame:CGRectMake((MMScreenWidth - commitImage.size.width)/2, (MMScreenHeight - commitImage.size.height - 152/2), commitImage.size.width, commitImage.size.height)];
    [_commit setImage:commitImage forState:UIControlStateNormal];
    [self.view addSubview:_commit];
    
    UIImage* logoImage = [UIImage imageNamed:@"draw_logo"];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (MMScreenHeight - logoImage.size.height - 110/2), logoImage.size.width, logoImage.size.height)];
    logoImageView.image = logoImage;
    [self.view addSubview:logoImageView];
    
    UIImage* eraseImage = [UIImage imageNamed:@"draw_erase"];
    _erase = [[UIButton alloc]initWithFrame:CGRectMake(50, 258/2, eraseImage.size.width, eraseImage.size.height)];
    [_erase setImage:eraseImage forState:UIControlStateNormal];
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
    UIImage* colorImage = [UIImage imageNamed:[NSString stringWithFormat:@"draw_color%d", i]];
    UIButton* colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, colorImage.size.width, colorImage.size.height)];
    [colorBtn setImage:colorImage forState:UIControlStateNormal];
    colorBtn.tag = 10200 + i;
    [colorBtn addTarget:self action:@selector(onClickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
    return colorBtn;
}

- (UIButton*) genImageBtn:(int)i
{
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"draw_img%d", i]];
    UIButton* imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageBtn setImage:image forState:UIControlStateNormal];
    imageBtn.tag = 10300 + i;
    [imageBtn addTarget:self action:@selector(onClickImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    return imageBtn;
}

- (void) onClickColorBtn:(UIButton*)sender
{

}

- (void) onClickImageBtn:(UIButton*)sender
{
    
}
@end
