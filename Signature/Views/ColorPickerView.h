//
//  ColorPickerView.h
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKOColorPickerView.h"

@protocol ColorPickerViewDelegate

- (void)userSelectedColor:(UIColor *)color;

@end

@interface ColorPickerView : UIView

/** 
 @discuss indicates whether the view is shown or not
 **/ 
@property (nonatomic, assign, getter=isShown) BOOL shown;

/** 
 @discuss the color picking component of the ColorPickerView
 **/
@property (nonatomic, strong) NKOColorPickerView *colorPickerView;

/** 
 @discuss The most recently selected color
 **/
@property (nonatomic, strong) UIColor *currentColor;

/** 
 @discuss Delegate responsible for handling the user's selection of a color
 **/
@property (nonatomic, assign) id<ColorPickerViewDelegate> delegate;

/** 
 @return Singleton instance of our ColorPickerView
 **/ 
+ (ColorPickerView *)view;

/** 
 @discuss Animates view and shows on screen.
 **/ 
- (void)show; 

/**
 @discuss Removes the view with animation
 **/
- (void)remove;

@end
