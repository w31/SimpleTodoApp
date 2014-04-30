//
//  TodoItem.h
//  SimpleTodoApp
//
//  Created by Wei on 3/21/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SimpleTodoPriority) {
    SimpleTodoPriorityLow,
    SimpleTodoPriorityNormal,
    SimpleTodoPriorityHigh
};

@interface TodoItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) SimpleTodoPriority priority;

@end
