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
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _priorityDic = @{ @(SimpleTodoPriorityLow): @"Low",
                          @(SimpleTodoPriorityNormal): @"Normal",
                          @(SimpleTodoPriorityHigh): @"High" };
    }

    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.todoTextField.text = self.todoName;
    self.priorityLabel.text = [_priorityDic objectForKey:@(self.todoPriority)];
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
        controller.selectedIndex = [controller.items indexOfObject:[_priorityDic objectForKey:@(self.todoPriority)]];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.delegate todoItemViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    self.todoName = self.todoTextField.text;

    [self.delegate todoItemViewControllerDidComplete:self];
}


#pragma mark - SimpleItemPickerDelegate

- (void)simpleItemPicker:(SimpleItemPicker *)controller didSelectItem:(NSString *)item
{
    self.priorityLabel.text = item;

    self.todoPriority = [[[_priorityDic allKeysForObject:item] firstObject] intValue];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
