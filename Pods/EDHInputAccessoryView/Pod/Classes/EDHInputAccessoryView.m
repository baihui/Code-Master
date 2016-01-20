//
//  EDHInputAccessoryView.m
//  EDHInputAccessoryView
//
//  Created by Tatsuya Tobioka on 10/12/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHInputAccessoryView.h"

#import "EDHInputAccessoryButton.h"

#import <FontAwesomeKit/FontAwesomeKit.h>

static const CGFloat kViewHeight = 44.0f;
static const CGFloat kBorderWidth = 1.0f;
static const CGFloat kIconSize = 20.0f;

@interface EDHInputAccessoryView ()

@property (nonatomic) UIScrollView *scrollView;

@end

@implementation EDHInputAccessoryView

- (id)initWithTextView:(UITextView *)textView {
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(applicationFrame), kViewHeight);

    if (self = [super initWithFrame:frame]) {
        self.textView = textView;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.scrollView.delaysContentTouches = YES;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        [self initButtons];
        
        // #d7d7d7
        self.backgroundColor = [UIColor colorWithRed:215.0f / 255.0f green:215.0f / 255.0f blue:215.0f / 255.0f alpha:1.0f];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    NSUInteger numberOfButtonsInPage = width / kViewHeight;
    CGFloat buttonWidth = (width - kBorderWidth * numberOfButtonsInPage) / numberOfButtonsInPage;
    
    CGFloat x = 0.0f;
    NSUInteger i = 0;
    for (EDHInputAccessoryButton *button in self.buttons) {
        CGRect frame = button.frame;
        frame.origin.x = x;
        frame.size.width = buttonWidth;
        button.frame = frame;
        
        i++;
        
        x = CGRectGetMaxX(button.frame);
        
        if (i % numberOfButtonsInPage != 0) {
            x += kBorderWidth;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(self.scrollView.bounds));
}

- (void)initButtons {
    NSMutableArray *buttons = @[].mutableCopy;
    
    FAKIcon *leftIcon = [FAKFontAwesome caretLeftIconWithSize:kIconSize];
    EDHInputAccessoryButton *leftButton = [EDHInputAccessoryButton buttonWithIcon:leftIcon tapHandler:^(EDHInputAccessoryButton *button) {
        NSRange range = self.textView.selectedRange;
        range.location -= 1;
        self.textView.selectedRange = range;
    }];
    [buttons addObject:leftButton];

    FAKIcon *rightIcon = [FAKFontAwesome caretRightIconWithSize:kIconSize];
    EDHInputAccessoryButton *rightButton = [EDHInputAccessoryButton buttonWithIcon:rightIcon tapHandler:^(EDHInputAccessoryButton *button) {
        NSRange range = self.textView.selectedRange;
        range.location += 1;
        self.textView.selectedRange = range;
    }];
    [buttons addObject:rightButton];

    FAKIcon *undoIcon = [FAKFontAwesome undoIconWithSize:kIconSize];
    EDHInputAccessoryButton *undoButton = [EDHInputAccessoryButton buttonWithIcon:undoIcon tapHandler:^(EDHInputAccessoryButton *button) {
        [self.textView.undoManager undo];
    }];
    [buttons addObject:undoButton];
    
    FAKIcon *repeatIcon = [FAKFontAwesome repeatIconWithSize:kIconSize];
    EDHInputAccessoryButton *redoButton = [EDHInputAccessoryButton buttonWithIcon:repeatIcon tapHandler:^(EDHInputAccessoryButton *button) {
        [self.textView.undoManager redo];
    }];
    [buttons addObject:redoButton];
    
    
    NSString *strings = @"!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    [strings enumerateSubstringsInRange:NSMakeRange(0, strings.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        EDHInputAccessoryButton *button = [EDHInputAccessoryButton buttonWithString:substring];
        [buttons addObject:button];
    }];

    self.buttons = buttons;
}

- (void)setButtons:(NSArray *)buttons {
    _buttons = buttons;
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (EDHInputAccessoryButton *button in self.buttons) {
        button.inputAccessoryView = self;
        [self.scrollView addSubview:button];
    }
    
    [self setNeedsLayout];
}

@end
