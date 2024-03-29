//
//  SizePickerView.m
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import "SizePickerView.h"
#import "JNWSpringAnimation.h"
#import "UIColor+SigColors.h"

@interface SizePickerView ()

@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, weak) UIView *colorPreviewView;

@end

@implementation SizePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shown = NO;
        
        _currentColor = [UIColor sigGray];
        
        UIView *contentContainer = [[UIView alloc] init];
        contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
        contentContainer.backgroundColor = [UIColor sigLightGray];
        contentContainer.layer.cornerRadius = 18.0f;
        contentContainer.layer.borderColor = [UIColor sigGray].CGColor;
        contentContainer.layer.borderWidth = 0.5f;
        contentContainer.clipsToBounds = YES;
        [self addSubview:contentContainer];
        
        UIView *topContainer = [[UIView alloc] init];
        topContainer.translatesAutoresizingMaskIntoConstraints = NO;
        topContainer.backgroundColor = [UIColor clearColor];
        [contentContainer addSubview:topContainer];
        
        UIView *middleContainer = [[UIView alloc] init];
        middleContainer.translatesAutoresizingMaskIntoConstraints = NO;
        middleContainer.backgroundColor = [UIColor clearColor];
        [contentContainer addSubview:middleContainer];
        
        UIView *bottomContainer = [[UIView alloc] init];
        bottomContainer.translatesAutoresizingMaskIntoConstraints = NO;
        bottomContainer.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomContainer];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(topContainer, middleContainer, bottomContainer, contentContainer);
        
        {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentContainer]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:views]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomContainer]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:views]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentContainer][bottomContainer(==15)]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:views]];
            
            [contentContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topContainer]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            
            [contentContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[middleContainer]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            
            
            
            NSString *vString = @"V:|[topContainer(==40)][middleContainer]|";
            [contentContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vString
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
        }
        
        /**
         Top container
         **/
        UIView *colorPreviewView = [[UIView alloc] init];
        colorPreviewView.translatesAutoresizingMaskIntoConstraints = NO;
        colorPreviewView.layer.cornerRadius = 5.0f;
        [topContainer addSubview:colorPreviewView];
        _colorPreviewView = colorPreviewView;
        
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
        [dismissButton setImage:[[UIImage imageNamed:@"183_x-circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                       forState:UIControlStateNormal];
        [dismissButton addTarget:self
                          action:@selector(remove)
                forControlEvents:UIControlEventTouchUpInside];
        [topContainer addSubview:dismissButton];
        
        UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        acceptButton.translatesAutoresizingMaskIntoConstraints = NO;
        [acceptButton setImage:[[UIImage imageNamed:@"306_Check-circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                      forState:UIControlStateNormal];
        [topContainer addSubview:acceptButton];
        
        [acceptButton addTarget:self
                         action:@selector(acceptPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *topViews = NSDictionaryOfVariableBindings(colorPreviewView, dismissButton, acceptButton);
        
        colorPreviewView.backgroundColor = self.currentColor;
        [dismissButton setTintColor:self.currentColor];
        [acceptButton setTintColor:self.currentColor];
        
        /**
         Middle container
         **/
        
        UISlider *slider = [[UISlider alloc] init];
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider.minimumValue = 1.0f;
        slider.maximumValue = 15.0f;
        slider.minimumTrackTintColor = self.currentColor;
        [middleContainer addSubview:slider];
        _slider = slider;
        
        [slider addTarget:self
                   action:@selector(sliderChanged:)
         forControlEvents:UIControlEventValueChanged];
        
        /**
         Bottom container
         **/
        //         [bottomContainer addSubview:triangleView];
        
        /**
         Constraints
         **/
        {
            [topContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[colorPreviewView]-(0)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:topViews]];
            
            
            
//            [topContainer addConstraint:[NSLayoutConstraint constraintWithItem:colorPreviewView
//                                                                     attribute:NSLayoutAttributeCenterY
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:topContainer
//                                                                     attribute:NSLayoutAttributeCenterY
//                                                                    multiplier:1.0f
//                                                                      constant:1.0f]];
            //
            //
            //            CGFloat width = CGRectGetWidth(self.frame) - 140.0f;
            //            [topContainer addConstraint:[NSLayoutConstraint constraintWithItem:colorPreviewView
            //                                                                     attribute:NSLayoutAttributeWidth
            //                                                                     relatedBy:NSLayoutRelationEqual
            //                                                                        toItem:nil
            //                                                                     attribute:NSLayoutAttributeNotAnAttribute
            //                                                                    multiplier:1.0f
            //                                                                      constant:width]];
            
            [topContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[dismissButton]-(0)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:topViews]];
            
            [topContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[acceptButton]-(0)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:topViews]];
            
            [topContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[dismissButton]-(16)-[colorPreviewView]-(16)-[acceptButton]-(16)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:topViews]];
        }
        {
            [middleContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[slider]-(16)-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:NSDictionaryOfVariableBindings(slider)]];
            
            [middleContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[slider]-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:NSDictionaryOfVariableBindings(slider)]];
        }
        
    }
    return self;
}

+ (SizePickerView *)view
{
    static SizePickerView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat menuWidth = screenWidth * 0.5f;
        CGFloat menuHeight = screenHeight * 0.3f;
        CGFloat padding = 40.0f;
        
        view = [[SizePickerView alloc] initWithFrame:CGRectMake(screenWidth - menuWidth - 10.0f, (screenHeight * 0.7f) - padding, menuWidth, menuHeight)];
    });
    return view;
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item;
{
    UIView *barButtonView = [item valueForKey:@"view"];
    NSLog(@"View: %@", barButtonView);
}

#pragma mark - Selector

- (void)acceptPressed:(id)sender
{
    NSLog(@"Foobar.."); 
    
    NSInteger value = (NSInteger)self.slider.value;
    NSLog(@"int value: %ld", (long)value);
    [self.delegate didPickSize:value];
    [self remove];
}

- (void)sliderChanged:(UISlider *)slider
{
    NSLog(@"%f", slider.value);
    NSInteger v = (NSInteger)slider.value;
    CGRect frame = self.colorPreviewView.frame;
    frame.size.height = v;
    frame.origin.y = 18 + ((15 - v) / 2);
    NSLog(@"origin: %f", frame.origin.y);
    self.colorPreviewView.frame = frame;
}

- (void)remove
{
    self.shown = NO;
    
    // Fade the overlay and alert view together
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0.0f;
                         self.alpha = 0.0f;
                     } completion:NULL];
    
    // Animate the alert’s scale from 1.0 down to .5
    JNWSpringAnimation *scale =
    [JNWSpringAnimation animationWithKeyPath:@"transform.scale"];
    scale.damping = 17;
    scale.stiffness = 17;
    scale.mass = 1;
    scale.fromValue = @(1.0);
    scale.toValue = @(0.5);
    
    [self.layer addAnimation:scale forKey:scale.keyPath];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    
    // Animate the position from 0 (original position) back off the screen
    JNWSpringAnimation *translate = [JNWSpringAnimation
                                     animationWithKeyPath:@"transform.translation.y"];
    translate.damping = 4;
    translate.stiffness = 4;
    translate.mass = 1;
    translate.fromValue = @(0);
    translate.toValue = @(600);
    
    [self.layer addAnimation:translate forKey:translate.keyPath];
    self.transform = CGAffineTransformTranslate(self.transform, 100, 600);
    
}

- (void)show
{
    self.shown = YES;
    
    // Fade the overlay and alert view together
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 1.0f;
                     } completion:NULL];
    
    // Animate the alert’s scale from 1.0 down to .5
    JNWSpringAnimation *scale = [JNWSpringAnimation animationWithKeyPath:@"transform.scale"];
    scale.damping = 17;
    scale.stiffness = 17;
    scale.mass = 1;
    scale.fromValue = @(0.5);
    scale.toValue = @(1.0);
    
    [self.layer addAnimation:scale forKey:scale.keyPath];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    
    // Animate the position from 0 (original position) back off the screen
    JNWSpringAnimation *translate = [JNWSpringAnimation animationWithKeyPath:@"transform.translation.y"];
    translate.damping = 25;
    translate.stiffness = 25;
    translate.mass = 1;
    translate.fromValue = @(600);
    translate.toValue = @(0);
    
    [self.layer addAnimation:translate forKey:translate.keyPath];
    self.transform = CGAffineTransformTranslate(self.transform, 0, 0);
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

@end
