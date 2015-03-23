//
//  DVTSourceTextView+AAC.m
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import "MethodSwizzle.h"
#import "DVTSourceTextView+AAC.h"
#import "DVTTextStorage.h"

@implementation DVTSourceTextView (AAC)

+ (void)methodSwizzle
{
    MethodSwizzle([self class],
                  @selector(shouldAutoCompleteAtLocation:),
                  @selector(aac_shouldAutoCompleteAtLocation:));
}

- (BOOL)aac_shouldAutoCompleteAtLocation:(unsigned long long)arg1
{
    BOOL shouldAutoComplete = [self aac_shouldAutoCompleteAtLocation:arg1];

    if (!shouldAutoComplete) {
        shouldAutoComplete = [self acc_shouldAutoCompleteInTextView:self location:arg1];
    }

    return shouldAutoComplete;
}

- (BOOL)acc_shouldAutoCompleteInTextView:(DVTCompletingTextView *)textView location:(NSUInteger)location
{
    if (textView == nil) {
        return NO;
    }

    DVTTextStorage *textStorage = (DVTTextStorage *)textView.textStorage;
    NSString *atString = [textStorage.string substringWithRange:NSMakeRange(location-1, 1)];

    // check input: "@"
    if (atString && [atString isEqualToString:@"@"]) {
        return YES;
    } else {
        return NO;
    }

    // TODO: check more conditions
}

@end