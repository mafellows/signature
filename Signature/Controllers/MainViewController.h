//
//  MainViewController.h
//  Signature
//
//  Created by Michael Fellows on 9/13/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sizeBarButton;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

- (IBAction)clearPressed:(id)sender;
- (IBAction)colorPressed:(id)sender;
- (IBAction)sizeButtonPressed:(id)sender;
- (IBAction)viewTapped:(id)sender;
- (IBAction)sharePressed:(id)sender;

@end
