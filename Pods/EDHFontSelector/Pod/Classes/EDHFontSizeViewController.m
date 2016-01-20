//
//  EDHFontSizeViewController.m
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/4/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHFontSizeViewController.h"

#import "EDHFontSelector.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface EDHFontSizeViewController ()

@property (nonatomic) NSArray *items;

@end

@implementation EDHFontSizeViewController

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
    [[EDHFontSelector sharedSelector] setFontSize:[self.items[indexPath.row] floatValue]];
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - Utilities

- (void)initItems {
    NSMutableArray *sizes = @[].mutableCopy;
    for (int i = 8; i <= 32; i++) {
        [sizes addObject:[@(i) stringValue]];
    }
    self.items = sizes;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *item = self.items[indexPath.row];
    
    cell.textLabel.text = item;
    
    cell.textLabel.font = [UIFont systemFontOfSize:[item floatValue]];
    if ([item floatValue] == [[EDHFontSelector sharedSelector] fontSize]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
