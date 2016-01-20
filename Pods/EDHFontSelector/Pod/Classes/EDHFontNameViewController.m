//
//  EDHFontNameViewController.m
//  EDHFontSelector
//
//  Created by Tatsuya Tobioka on 10/5/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

#import "EDHFontNameViewController.h"

#import "EDHFontSelector.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface EDHFontNameViewController ()

@property (nonatomic) NSDictionary *sections;
@property (nonatomic) NSArray *sectionTitles;

@end

@implementation EDHFontNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self initSections];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self itemsInSections:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionTitles;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[EDHFontSelector sharedSelector] setFontName:[self itemsInSections:indexPath.section][indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - Utilities

- (void)initSections {
    NSMutableArray *fontNames = @[].mutableCopy;
    NSArray *families = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *family in families) {
        NSArray *names = [[UIFont fontNamesForFamilyName:family] sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *name in names) {
            [fontNames addObject:name];
        }
    }
    
    NSMutableDictionary *sections = @{}.mutableCopy;
    for (NSString *name in fontNames) {
        NSString *initial = [name substringToIndex:1].uppercaseString;
        if (!sections[initial]) {
            sections[initial] = @[].mutableCopy;
        }
        [sections[initial] addObject:name];
    }
    
    self.sections = sections;
    self.sectionTitles = [[sections allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [self itemsInSections:indexPath.section][indexPath.row];
    
    cell.textLabel.text = item;
    
    cell.textLabel.font = [UIFont fontWithName:item size:cell.textLabel.font.pointSize];
    if ([item isEqualToString:[[EDHFontSelector sharedSelector] fontName]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (NSArray *)itemsInSections:(NSUInteger)section {
    NSString *title = self.sectionTitles[section];
    return self.sections[title];
}

@end
