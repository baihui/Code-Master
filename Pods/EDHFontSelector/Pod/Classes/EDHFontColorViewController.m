//
//  EDHFontColorViewController.m
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/4/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHFontColorViewController.h"

#import "EDHFontSelector.h"
#import "EDHUtility.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

static const CGFloat kImageSize = 44.0f;

@interface EDHFontColorViewController ()

@property (nonatomic) NSArray *items;
@property (nonatomic) EDHFontColorViewControllerType type;

@end

@implementation EDHFontColorViewController

- (id)initWithType:(EDHFontColorViewControllerType)type {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self initItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case EDHFontColorViewControllerTypeText: {
            [[EDHFontSelector sharedSelector] setTextColor:self.items[indexPath.row][@"color"]];
            break;
        }
        case EDHFontColorViewControllerTypeBackground: {
            [[EDHFontSelector sharedSelector] setBackgroundColor:self.items[indexPath.row][@"color"]];
            break;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - Utilities

- (void)initItems {
    self.items = [[EDHFontSelector sharedSelector] colors];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.items[indexPath.row][@"name"];
    UIColor *color = self.items[indexPath.row][@"color"];

    BOOL isSelected = NO;

    cell.textLabel.text = name;
    
    switch (self.type) {
        case EDHFontColorViewControllerTypeText: {
            if ([color isEqual:[[EDHFontSelector sharedSelector] textColor]]) {
                isSelected = YES;
            }
            break;
        }
        case EDHFontColorViewControllerTypeBackground: {
            if ([color isEqual:[[EDHFontSelector sharedSelector] backgroundColor]]) {
                isSelected = YES;
            }
            break;
        }
    }
    
    if (isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.imageView.image = [EDHUtility imageWithColor:color size:CGSizeMake(kImageSize, kImageSize)];
}

@end
