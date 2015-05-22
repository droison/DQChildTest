//
//  PIDrawerViewController.m
//  PIImageDoodler
//
//  Created by Pavan Itagi on 07/03/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import "PIDrawerViewController.h"
#import "PIDrawerView.h"
#import "PIColorPickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PIDrawerViewController ()
@property (weak, nonatomic) IBOutlet PIDrawerView *drawerView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *pickImageButton;
@property (weak, nonatomic) IBOutlet UIButton *pickColorButton;
@property (weak, nonatomic) IBOutlet UIButton *pickEraserButton;
@property (weak, nonatomic) IBOutlet UIButton *writeButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic, strong) UIColor *selectedColor;

- (IBAction)pickImageButtonPressed:(id)sender;
- (IBAction)pickColorButtonPressed:(id)sender;
- (IBAction)pickEraserButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)writeButtonPressed:(id)sender;
@end

@implementation PIDrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pickColorButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.pickColorButton.layer setBorderWidth:5.0];
    [self.pickColorButton.layer setCornerRadius:3.0];
    
    self.selectedColor = [UIColor redColor];
    [self.pickColorButton setBackgroundColor:self.selectedColor];
    [self.drawerView setSelectedColor:self.selectedColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action methods
- (IBAction)pickImageButtonPressed:(id)sender
{

}

- (IBAction)pickColorButtonPressed:(id)sender
{
}

- (IBAction)pickEraserButtonPressed:(id)sender
{
    [self.drawerView setDrawingMode:DrawingModeErase];
}

- (IBAction)saveButtonPressed:(id)sender
{
    
}

- (IBAction)writeButtonPressed:(id)sender
{
    [self.drawerView setDrawingMode:DrawingModePaint];
}
@end
