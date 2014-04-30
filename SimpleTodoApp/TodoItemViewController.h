//
//  TodoItemViewController.h
//  SimpleTodoApp
//
//  Created by Wei on 3/16/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleItemPicker.h"
#import "TodoItem.h"

@class TodoItemViewController;

@protocol TodoItemViewControllerDelegate <NSObject>

- (void)todoItemViewControllerDidCancel:(TodoItemViewController *)controller;
- (void)todoItemViewController:(TodoItemViewController *)controller didAddTodoItem:(TodoItem *)item;

@end

@interface TodoItemViewController : UITableViewController <SimpleItemPickerDelegate>

@property (nonatomic, weak) id <TodoItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *todoTextField;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end
