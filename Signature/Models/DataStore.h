//
//  DataStore.h
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) NSInteger currentSize;

+ (DataStore *)sharedStore;

@end
