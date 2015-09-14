//
//  DataStore.m
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

+ (DataStore *)sharedStore
{
    static DataStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

- (UIColor *)currentColor
{
    
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    
}

- (NSInteger)currentSize
{
    
}

- (void)setCurrentSize:(NSInteger)currentSize
{
    
}

@end
