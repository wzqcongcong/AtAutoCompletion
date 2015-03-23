//
//  MethodSwizzle.m
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import "MethodSwizzle.h"

void MethodSwizzle(Class cls, SEL org_sel, SEL alt_sel)
{
    Method org_method = nil, alt_method = nil;

    org_method = class_getInstanceMethod(cls, org_sel);
    alt_method = class_getInstanceMethod(cls, alt_sel);

    if (org_method != nil && alt_method != nil) {
        method_exchangeImplementations(org_method, alt_method);
    }
}
