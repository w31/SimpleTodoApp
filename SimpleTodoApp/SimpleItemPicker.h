//
//  SimpleItemPicker.h
//  SimpleTodoApp
//
//  Created by Wei on 4/27/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleItemPicker;

@protocol SimpleItemPickerDelegate <NSObject>

- (void)simpleItemPicker:(SimpleItemPicker *)controller didSelectItem:(NSString *)item;

@end

@interface SimpleItemPicker : UITableViewController

@property (weak, nonatomic) id <SimpleItemPickerDelegate> delegate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *items;
@property (nonatomic) int selectedIndex;

@end
