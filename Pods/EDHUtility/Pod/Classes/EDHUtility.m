//
//  EDHUtility.m
//  EDHUtility
//
//  Created by Tatsuya Tobioka on 10/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHUtility.h"

static NSString * const kPodName = @"EDHUtility";
#define kIsFirstLaunchKey [NSString stringWithFormat:@"%@.%@", kPodName, @"kIsFirstLaunchKey"]

@implementation EDHUtility

+ (void)load {
    NSMutableDictionary *defaults = @{}.mutableCopy;
    
    [defaults setObject:@(YES) forKey:kIsFirstLaunchKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

+ (void)showErrorWithMessage:(NSString *)message controller:(UIViewController *)controller {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[self localizedString:@"Error" withScope:kPodName] message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[self localizedString:@"OK" withScope:kPodName] style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);

    UIGraphicsBeginImageContext(size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillRect(contextRef, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)isFirstLaunch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstLaunchKey];
}

+ (void)setIsFirstLaunch:(BOOL)isFirstLaunch {
    [[NSUserDefaults standardUserDefaults] setBool:isFirstLaunch forKey:kIsFirstLaunchKey];
}

+ (NSString *)localizedString:(NSString *)string withScope:(NSString *)scope {
    NSString *key = [NSString stringWithFormat:@"%@.%@", scope, string];
    
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:scope ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *language = NSLocale.preferredLanguages.count? NSLocale.preferredLanguages.firstObject: @"en";
    if (![bundle.localizations containsObject:language]) {
        language = [language componentsSeparatedByString:@"-"].firstObject;
    }
    if ([bundle.localizations containsObject:language]) {
        bundlePath = [bundle pathForResource:language ofType:@"lproj"];
    }
    
    bundle = [NSBundle bundleWithPath:bundlePath] ?: NSBundle.mainBundle;

    string = [bundle localizedStringForKey:key value:string table:nil];
    return [NSBundle.mainBundle localizedStringForKey:key value:string table:nil];
}

+ (NSError *)errorWithDescription:(NSString *)description {
    return [NSError errorWithDomain:kPodName code:0 userInfo:@{ NSLocalizedDescriptionKey : description }];
}

@end
