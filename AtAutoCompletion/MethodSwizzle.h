//
//  MethodSwizzle.h
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import <objc/runtime.h>

void MethodSwizzle(Class the_class, SEL original_sel, SEL swizzled_sel);
