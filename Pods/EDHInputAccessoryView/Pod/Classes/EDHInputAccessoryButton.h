//
//  EDHInputAccessoryButton.h
//  EDHInputAccessoryView
//
//  Created by Tatsuya Tobioka on 10/12/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDHInputAccessoryView;
@protocol EDHInputAccessoryButtonDelegate;
@class FAKIcon;

@interface EDHInputAccessoryButton : UIButton

@property (nonatomic) NSString *string;
@property (nonatomic) FAKIcon *icon;
@property (nonatomic, copy) void (^tapHandler)(EDHInputAccessoryButton *);
@property (nonatomic) EDHInputAccessoryView *inputAccessoryView;

+ (EDHInputAccessoryButton *)buttonWithString:(NSString *)string;
+ (EDHInputAccessoryButton *)buttonWithIcon:(FAKIcon *)icon tapHandler:(void (^)(EDHInputAccessoryButton *))tapHandler;

@end
