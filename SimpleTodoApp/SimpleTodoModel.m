//
//  SimpleTodoModel.m
//  SimpleTodoApp
//
//  Created by Wei on 3/14/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import "SimpleTodoModel.h"

@implementation SimpleTodoModel

+(SimpleTodoModel *)sharedInstance
{
    static SimpleTodoModel *shared = nil;
    static dispatch_once_t dispatch;

    dispatch_once(&dispatch, ^{
        shared = [[self alloc] init];
    });

    return shared;
}

-(void)loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSArray *items = [defaults objectForKey:@"Default Todo"];

    self.todoList = [[NSMutableArray alloc] init];

    if (items != nil) {
        for (NSDictionary *dic in items) {
            TodoItem *todo = [[TodoItem alloc]init];
            todo.name = [dic objectForKey:@"Name"];
            todo.priority = [[dic objectForKey:@"Priority"] intValue];

            [self.todoList addObject:todo];
        }
    }
}

-(void)saveData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableArray *items = [[NSMutableArray alloc] init];

    for (TodoItem *item in self.todoList) {
        [items addObject:@{@"Name": item.name, @"Priority": @(item.priority)}];
    }

    [defaults setObject:items forKey:@"Default Todo"];

    [defaults synchronize];
}

@end
