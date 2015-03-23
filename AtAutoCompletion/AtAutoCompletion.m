//
//  AtAutoCompletion.m
//  AtAutoCompletion
//
//  Created by user on 3/23/15.
//  Copyright (c) 2015 GoKuStudio. All rights reserved.
//

#import "AtAutoCompletion.h"
#import "DVTSourceTextView+AAC.h"

static AtAutoCompletion *sharedPlugin;

@interface AtAutoCompletion()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation AtAutoCompletion

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(XcodeDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(XcodeMenuDidChange:)
                                                     name:NSMenuDidChangeItemNotification
                                                   object:nil];

        // when installing through Alcatraz the application has already launched
        if ([NSApplication sharedApplication].currentEvent) {
            [self XcodeDidFinishLaunching:nil];
        }
    }
    return self;
}

- (void)XcodeDidFinishLaunching:(NSNotification *)notification
{
    NSLog(@"load Xcode plugin: %@", [self.bundle.infoDictionary valueForKey:@"CFBundleName"]);

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSApplicationDidFinishLaunchingNotification
                                                  object:nil];

    [self swizzleMethods];
}

- (void)XcodeMenuDidChange:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMenuDidChangeItemNotification
                                                  object:nil];

    // Create menu items, initialize UI, etc.
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:[@"@" stringByAppendingString:[self.bundle.infoDictionary valueForKey:@"CFBundleName"]]
                                                                action:@selector(doMenuAction)
                                                         keyEquivalent:@""];
        [actionMenuItem setTarget:self];

        NSInteger menuIndex = [menuItem.submenu indexOfItemWithTitle: @"Undo"];
        if (menuIndex == -1) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            [[menuItem submenu] addItem:actionMenuItem];
        } else {
            [menuItem.submenu insertItem:[NSMenuItem separatorItem] atIndex:menuIndex];
            [menuItem.submenu insertItem:actionMenuItem atIndex:menuIndex];
        }
    }
}

- (void)swizzleMethods
{
    [DVTSourceTextView methodSwizzle];
}

- (void)doMenuAction
{
    NSURL *url = [NSURL URLWithString:@"https://github.com/wzqcongcong/AtAutoCompletion.git"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
