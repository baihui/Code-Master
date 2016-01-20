//
//  EDHFinder.h
//  EDHFinder
//
//  Created by Tatsuya Tobioka on 10/1/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EDHFinderListViewController.h"
#import "EDHFinderItem.h"

extern NSString * const EDHFinderPodName;

@protocol EDHFinderDelegate;

@interface EDHFinder : NSObject

@property (nonatomic, copy) NSString *rootPath;
@property (nonatomic, copy) UIColor *iconColor;
@property (nonatomic) BOOL toolbarHidden;
@property (nonatomic, weak) id<EDHFinderDelegate> finderDelegate;

+ (instancetype)sharedFinder;

- (UINavigationController *)listNavigationController;
- (EDHFinderListViewController *)listViewController;

- (UINavigationController *)listNavigationControllerWithDelegate:(id<EDHFinderListViewControllerDelegate>)delegate;
- (EDHFinderListViewController *)listViewControllerWithDelegate:(id<EDHFinderListViewControllerDelegate>)delegate;

- (EDHFinderItem *)rootItem;

- (NSString *)relativePathFromRoot:(NSString *)path;

@end


@protocol EDHFinderDelegate <NSObject>

@optional

- (EDHFinderListViewController *)listViewControllerWithPath:(NSString *)path delegate:(id<EDHFinderListViewControllerDelegate>)delegate;

@end
