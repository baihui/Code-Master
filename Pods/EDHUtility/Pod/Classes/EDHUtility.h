//
//  EDHUtility.h
//  EDHUtility
//
//  Created by Tatsuya Tobioka on 10/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDHUtility : NSObject

+ (void)showErrorWithMessage:(NSString *)message controller:(UIViewController *)controller;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (BOOL)isFirstLaunch;
+ (void)setIsFirstLaunch:(BOOL)isFirstLaunch;

+ (NSString *)localizedString:(NSString *)string withScope:(NSString *)scope;
+ (NSError *)errorWithDescription:(NSString *)description;

@end
