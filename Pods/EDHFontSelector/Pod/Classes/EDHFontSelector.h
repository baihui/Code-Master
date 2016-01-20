//
//  EDHFontSelector.h
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/3/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EDHFontSettingsViewController.h"

extern NSString * const EDHFontSelectorPodName;

@interface EDHFontSelector : NSObject

@property (nonatomic) NSString *previewText;

+ (instancetype)sharedSelector;

- (UINavigationController *)settingsNavigationController;
- (EDHFontSettingsViewController *)settingsViewController;

- (void)applyToTextView:(UITextView *)textView;

- (UIFont *)font;

- (NSString *)fontName;
- (CGFloat)fontSize;
- (UIColor *)textColor;
- (UIColor *)backgroundColor;

- (void)setFontName:(NSString *)name;
- (void)setFontSize:(CGFloat)size;
- (void)setTextColor:(UIColor *)color;
- (void)setBackgroundColor:(UIColor *)color;

- (void)reset;

- (NSString *)nameForColor:(UIColor *)color;
- (NSArray *)colors;

@end
