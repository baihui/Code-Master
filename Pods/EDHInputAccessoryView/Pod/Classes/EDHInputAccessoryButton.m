//
//  EDHInputAccessoryButton.m
//  EDHInputAccessoryView
//
//  Created by Tatsuya Tobioka on 10/12/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHInputAccessoryButton.h"

#import "EDHInputAccessoryView.h"
#import "EDHUtility.h"

#import <FontAwesomeKit/FontAwesomeKit.h>

@implementation EDHInputAccessoryButton

+ (EDHInputAccessoryButton *)buttonWithString:(NSString *)string {
    return [self buttonWithString:string icon:nil tapHandler:nil];
}

+ (EDHInputAccessoryButton *)buttonWithIcon:(FAKIcon *)icon tapHandler:(void (^)(EDHInputAccessoryButton *))tapHandler {
    return [self buttonWithString:nil icon:icon tapHandler:tapHandler];
}

+ (EDHInputAccessoryButton *)buttonWithString:(NSString *)string icon:(FAKIcon *)icon tapHandler:(void (^)(EDHInputAccessoryButton *))tapHandler {

    EDHInputAccessoryButton *button = [EDHInputAccessoryButton buttonWithType:UIButtonTypeCustom];

    button.string = string;
    button.icon = icon;
    button.tapHandler = tapHandler;

    return button;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(buttonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        // #f7f7f7
        [self setBackgroundImage:[EDHUtility imageWithColor:[UIColor colorWithRed:247.0f / 255.0f green:247.0f / 255.0f blue:247.0f / 255.0f alpha:1.0f] size:CGSizeMake(1.0f, 1.0f)] forState:UIControlStateNormal];
        // #d7d7d7
        [self setBackgroundImage:[EDHUtility imageWithColor:[UIColor colorWithRed:215.0f / 255.0f green:215.0f / 255.0f blue:215.0f / 255.0f alpha:1.0f] size:CGSizeMake(1.0f, 1.0f)] forState:UIControlStateHighlighted];
    }
    return self;
}

                               
- (void)setInputAccessoryView:(EDHInputAccessoryView *)inputAccessoryView {
    _inputAccessoryView = inputAccessoryView;
    
    CGFloat height = CGRectGetHeight(inputAccessoryView.bounds);

    // #1f1f21
    UIColor *titleColor = [UIColor colorWithRed:31.0f / 255.0f green:31.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
    
    if (self.string) {
        [self setTitle:[NSString stringWithFormat:@" %@ ", self.string] forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:22.0f];
    } else {
        [self.icon addAttribute:NSForegroundColorAttributeName value:titleColor];
        [self setImage:[self.icon imageWithSize:CGSizeMake(height, height)] forState:UIControlStateNormal];
    }
    [self sizeToFit];
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)buttonDidTap:(id)sender {
    if (self.tapHandler) {
        self.tapHandler(self);
    } else if (self.string) {
        [self.inputAccessoryView.textView insertText:self.string];
    }
}

@end
