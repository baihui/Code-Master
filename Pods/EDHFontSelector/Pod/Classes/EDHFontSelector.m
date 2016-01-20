//
//  EDHFontSelector.m
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/3/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHFontSelector.h"

#import "EDHUtility.h"

//#import <objc/runtime.h>

NSString * const EDHFontSelectorPodName = @"EDHFontSelector";

#define kFontNameKey [NSString stringWithFormat:@"%@.%@", EDHFontSelectorPodName, @"kFontNameKey"]
#define kFontSizeKey [NSString stringWithFormat:@"%@.%@", EDHFontSelectorPodName, @"kFontSizeKey"]
#define kTextColorKey [NSString stringWithFormat:@"%@.%@", EDHFontSelectorPodName, @"kTextColorKey"]
#define kBackgroundColorKey [NSString stringWithFormat:@"%@.%@", EDHFontSelectorPodName, @"kBackgroundColorKey"]

@implementation EDHFontSelector

static EDHFontSelector *sharedInstance = nil;

+ (instancetype)sharedSelector {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        [self registarDefaults];
        
        self.previewText = [EDHUtility localizedString:@"ABCDEFGHIJKLM NOPQRSTUVWXYZ abcdefghijklm nopqrstuvwxyz 1234567890" withScope:EDHFontSelectorPodName];
    }
    return self;
}

- (UINavigationController *)settingsNavigationController {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[self settingsViewController]];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    return navController;
}

- (EDHFontSettingsViewController *)settingsViewController {
    return [[EDHFontSettingsViewController alloc] init];
}

- (void)applyToTextView:(UITextView *)textView {
    textView.textColor = [self textColor];
    textView.backgroundColor = [self backgroundColor];
    textView.font = [self font];
}

- (UIFont *)font {
    return [UIFont fontWithName:[self fontName] size:[self fontSize]];
}

- (NSString *)fontName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kFontNameKey];
}

- (CGFloat)fontSize {
    return [[NSUserDefaults standardUserDefaults] floatForKey:kFontSizeKey];
}

- (UIColor *)textColor {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kTextColorKey]];
}

- (UIColor *)backgroundColor {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kBackgroundColorKey]];
}

- (void)setFontName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:kFontNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setFontSize:(CGFloat)size {
    [[NSUserDefaults standardUserDefaults] setFloat:size forKey:kFontSizeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTextColor:(UIColor *)color {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:kTextColorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setBackgroundColor:(UIColor *)color {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:kBackgroundColorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reset {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kFontNameKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kFontSizeKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTextColorKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kBackgroundColorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)nameForColor:(UIColor *)color {
    for (NSDictionary *c in [self colors]) {
        if ([color isEqual:c[@"color"]]) {
            return c[@"name"];
        }
    }
    return @"";
}

- (NSArray *)colors {

    NSMutableArray *colors = @[
             @{
                 @"name" : [EDHUtility localizedString:@"Black" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor blackColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Dark gray" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor darkGrayColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Light gray" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor lightGrayColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"White" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor whiteColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Gray" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor grayColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Red" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor redColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Green" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor greenColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Blue" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor blueColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Cyan" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor cyanColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Yellow" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor yellowColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Magenta" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor magentaColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Orange" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor orangeColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Purple" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor purpleColor],
                 },
             @{
                 @"name" : [EDHUtility localizedString:@"Brown" withScope:EDHFontSelectorPodName],
                 @"color" : [UIColor brownColor],
                 },
             ].mutableCopy;
    
//    NSMutableArray *colors = @[].mutableCopy;
//    unsigned int count;
//    Method *methods;
//    Class targetClass = [UIColor class];
//
//    methods = class_copyMethodList(object_getClass(targetClass), &count);
//    for (int i = 0; i < count; i++) {
//        NSString *name = NSStringFromSelector(method_getName(methods[i]));
//        NSRange range = [name rangeOfString:@"^[^_].+?Color$" options:NSRegularExpressionSearch];
//        if (range.location != NSNotFound) {
//            SEL selector = NSSelectorFromString(name);
//            if ([UIColor respondsToSelector:selector]) {
//                UIColor *color =  [UIColor performSelector:selector];
//                if (color) {
//                    if ([color isEqual:[UIColor clearColor]]) {
//                        continue;
//                    }
//                    for (NSDictionary *c in colors) {
//                        if ([color isEqual:c[@"color"]]) {
//                            continue;
//                        }
//                    }
//                    
//                    [colors addObject:@{
//                                        //@"name" : name,
//                                        @"name" : [NSString stringWithFormat:@"%@ (%@)", name, [color description]],
//                                        @"color" : color,
//                                        }];
//                }
//            }
//        }
//    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [colors sortUsingDescriptors:@[descriptor]];
    
    return colors;
}

# pragma mark - Utilities

- (void)registarDefaults {    
    NSMutableDictionary *defaults = @{}.mutableCopy;
    [defaults setObject:@"HelveticaNeue" forKey:kFontNameKey];
    [defaults setObject:@(14.0f) forKey:kFontSizeKey];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:[UIColor blackColor]] forKey:kTextColorKey];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:[UIColor whiteColor]] forKey:kBackgroundColorKey];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

@end
