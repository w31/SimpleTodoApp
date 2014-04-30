//
//  TodoItemViewController.m
//  SimpleTodoApp
//
//  Created by Wei on 3/16/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import "TodoItemViewController.h"

@implementation TodoItemViewController
{
    NSDictionary *_priorityDic;

    SimpleTodoPriority _priority;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _priorityDic = @{ @(SimpleTodoPriorityLow): @"Low",
                          @(SimpleTodoPriorityNormal): @"Normal",
                          @(SimpleTodoPriorityHigh): @"High" };

        _priority = SimpleTodoPriorityNormal;
    }

    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.priorityLabel.text = [_priorityDic objectForKey:@(_priority)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.todoTextField becomeFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Todo Priority"]) {
        SimpleItemPicker *controller = segue.destinationViewController;

        controller.delegate = self;
        controller.title = @"Select Priority";
        controller.items = [_priorityDic allValues];
        controller.selectedIndex = [controller.items indexOfObject:[_priorityDic objectForKey:@(_priority)]];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.delegate todoItemViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    TodoItem *todoItem = [[TodoItem alloc] init];
    todoItem.name = self.todoTextField.text;
    todoItem.priority = _priority;

    [self.delegate todoItemViewController:self didAddTodoItem:todoItem];
}


#pragma mark - SimpleItemPickerDelegate

- (void)simpleItemPicker:(SimpleItemPicker *)controller didSelectItem:(NSString *)item
{
    self.priorityLabel.text = item;

    _priority = [[[_priorityDic allKeysForObject:item] firstObject] intValue];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
