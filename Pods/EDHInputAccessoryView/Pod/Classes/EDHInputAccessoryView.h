//
//  EDHInputAccessoryView.h
//  EDHInputAccessoryView
//
//  Created by Tatsuya Tobioka on 10/12/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDHInputAccessoryView : UIView

@property (nonatomic) NSArray *buttons;
@property (nonatomic) UITextView *textView;

- (id)initWithTextView:(UITextView *)textView;

@end
