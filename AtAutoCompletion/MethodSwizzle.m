//
//  MethodSwizzle.m
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import "MethodSwizzle.h"

void MethodSwizzle(Class the_class, SEL original_sel, SEL swizzled_sel)
{
    Method original_method = nil;
    Method swizzled_method = nil;

    original_method = class_getInstanceMethod(the_class, original_sel);
    swizzled_method = class_getInstanceMethod(the_class, swizzled_sel);

    if (original_method && swizzled_method) {
        BOOL didAddMethod = class_addMethod(the_class,
                                            original_sel,
                                            method_getImplementation(swizzled_method),
                                            method_getTypeEncoding(swizzled_method));

        if (didAddMethod) {
            class_replaceMethod(the_class,
                                swizzled_sel,
                                method_getImplementation(original_method),
                                method_getTypeEncoding(original_method));
        } else {
            method_exchangeImplementations(original_method, swizzled_method);
        }
    }
}
