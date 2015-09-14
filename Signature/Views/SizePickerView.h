//
//  SizePickerView.h
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SizePickerDelegate

- (void)didPickSize:(NSInteger)size;

@end

@interface SizePickerView : UIView

/**
 @discuss indicates whether the view is shown or not
 **/
@property (nonatomic, assign, getter=isShown) BOOL shown;

/**
 @discuss The most recently selected color
 **/
@property (nonatomic, strong) UIColor *currentColor;

/**
 @discuss Delegate responsible for handling the user's selection of a color
 **/
@property (nonatomic, assign) id<SizePickerDelegate> delegate;

/**
 @return Singleton instance of our ColorPickerView
 **/
+ (SizePickerView *)view;

/**
 @discuss Animates view and shows on screen.
 @param parent view for the picker view
 **/
- (void)show;

/**
 @discuss Removes the view with animation
 **/
- (void)remove;


@end
