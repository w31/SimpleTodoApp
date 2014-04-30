//
//  SimpleTodoModel.h
//  SimpleTodoApp
//
//  Created by Wei on 3/14/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodoItem.h"

@interface SimpleTodoModel : NSObject

+ (SimpleTodoModel *)sharedInstance;

@property (strong, nonatomic) NSMutableArray *todoList;

- (void)loadData;
- (void)saveData;

@end
