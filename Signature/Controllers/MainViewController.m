//
//  MainViewController.m
//  Signature
//
//  Created by Michael Fellows on 9/13/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "ColorPickerView.h"
#import "MFSignatureView.h"
#import "SizePickerView.h"

@interface MainViewController ()

@property (nonatomic, assign, getter=isPickerShown) BOOL pickerShown;
@property (nonatomic, strong) MFSignatureView *signatureView;

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pickerShown = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.signatureView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(viewTapped:)]; 
    [self.navigationController.navigationBar addGestureRecognizer:tapRecognizer];
}

#pragma mark - Properties

- (MFSignatureView *)signatureView
{
    if (!_signatureView) {
        CGFloat viewHeight = CGRectGetHeight(self.view.frame) -
                    CGRectGetHeight(self.bottomToolbar.frame) -
                    CGRectGetHeight(self.navigationController.navigationBar.frame) - 1;
        _signatureView = [[MFSignatureView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           CGRectGetWidth(self.view.frame),
                                                                           viewHeight)];
        _signatureView.lineWidth = 10;
        _signatureView.lineColor = [UIColor blackColor];
        _signatureView.bgColor = [UIColor clearColor];
    }
    return _signatureView;
}

#pragma mark - Selector

- (IBAction)clearPressed:(id)sender {
    [self.signatureView setPath:nil];
    [self.signatureView setNeedsDisplay];
}

- (IBAction)colorPressed:(id)sender {
    
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//    CGFloat menuWidth = screenWidth * 0.5f;
//    CGFloat menuHeight = screenHeight * 0.7f;
//    CGFloat padding = 40.0f;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - menuWidth - padding, (screenHeight * 0.3f) - padding, menuWidth, menuHeight)];
//    view.backgroundColor = [UIColor redColor];
//    view.layer.cornerRadius = 10.0f;
//    view.layer.borderColor = [UIColor blackColor].CGColor;
//    [self.view addSubview:view];
//    
//    NKOColorPickerDidChangeColorBlock colorDidChangeBlock = ^(UIColor *color){
//        //Your code handling a color change in the picker view.
//        NSLog(@"Color: %@", color);
//        view.backgroundColor = color;
//    };
//    
//    NKOColorPickerView *colorPickerView = [[NKOColorPickerView alloc] initWithFrame:view.bounds color:[UIColor blueColor] andDidChangeColorBlock:colorDidChangeBlock];
//    
//    //Add color picker to your view
//    [view addSubview:colorPickerView];
    
    if ([[SizePickerView view] isShown]) {
        [[SizePickerView view] remove]; 
    }
    
    ColorPickerView *colorPicker = [ColorPickerView view];
    if ([colorPicker isShown]) {
        [[ColorPickerView view] remove];
    } else {
        [colorPicker showInView:self.view];
    }
}

- (IBAction)sizeButtonPressed:(id)sender
{
    if ([[ColorPickerView view] isShown]) {
        [[ColorPickerView view] remove];
    }
    
    SizePickerView *sizePicker = [SizePickerView view];
    if ([sizePicker isShown]) {
        [sizePicker remove];
    } else {
        [sizePicker showInView:self.view];
    }
}

- (IBAction)viewTapped:(id)sender {
    if ([[ColorPickerView view] isShown]) {
        [[ColorPickerView view] remove];
    }
    
    if ([[SizePickerView view] isShown]) {
        [[SizePickerView view] remove]; 
    }
}

- (IBAction)sharePressed:(id)sender
{
    
}

@end
