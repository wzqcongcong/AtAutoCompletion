//
//  AtAutoCompletion.h
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface AtAutoCompletion : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end