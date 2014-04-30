//
//  SimpleTodoViewController.h
//  SimpleTodoApp
//
//  Created by Wei on 2/23/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoItemViewController.h"

@interface SimpleTodoViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, TodoItemViewControllerDelegate>

@end
