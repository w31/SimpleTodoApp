//
//  SimpleItemPicker.m
//  SimpleTodoApp
//
//  Created by Wei on 4/27/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import "SimpleItemPicker.h"

@implementation SimpleItemPicker

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.title;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Simple Item Cell"];

    cell.textLabel.text = self.items[indexPath.row];

    cell.accessoryType = indexPath.row == self.selectedIndex ? UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;

    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.selectedIndex != NSNotFound) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];

        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    self.selectedIndex = indexPath.row;

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    [self.delegate simpleItemPicker:self didSelectItem:cell.textLabel.text];
}

@end
