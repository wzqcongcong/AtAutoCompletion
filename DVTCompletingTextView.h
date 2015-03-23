//
//  DVTCompletingTextView.h
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DVTTextCompletionDataSource;

@interface DVTCompletingTextView : NSTextView

@property (readonly) DVTTextCompletionDataSource *completionsDataSource;

- (BOOL)shouldAutoCompleteAtLocation:(unsigned long long)arg1;

@end
