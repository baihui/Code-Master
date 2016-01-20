//
//  EDHFontColorViewController.h
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/4/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EDHFontColorViewControllerType) {
    EDHFontColorViewControllerTypeText,
    EDHFontColorViewControllerTypeBackground,
};

@interface EDHFontColorViewController : UITableViewController

- (id)initWithType:(EDHFontColorViewControllerType)type;

@end
