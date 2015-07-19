//
//  SimpleTodoViewController.m
//  SimpleTodoApp
//
//  Created by Wei on 2/23/14.
//  Copyright (c) 2014 Wei. All rights reserved.
//

#import "SimpleTodoViewController.h"
#import "SimpleTodoModel.h"

@interface SimpleTodoViewController ()

@end

@implementation SimpleTodoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[SimpleTodoModel sharedInstance] loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [[SimpleTodoModel sharedInstance] saveData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Add Todo Item"]) {
        UINavigationController *navController = segue.destinationViewController;

        TodoItemViewController *detailsController = [navController viewControllers][0];

        detailsController.delegate = self;
        detailsController.action = @"add";
        detailsController.todoName = @"";
        detailsController.todoPriority = SimpleTodoPriorityNormal;
    }
    else if ([segue.identifier isEqualToString:@"Edit Todo Item"]) {
        UINavigationController *navController = segue.destinationViewController;
        
        TodoItemViewController *detailsController = [navController viewControllers][0];

        detailsController.delegate = self;
        detailsController.action = @"edit";
        TodoItem *item = [SimpleTodoModel sharedInstance].todoList[[self.tableView indexPathForSelectedRow].row];
        detailsController.uuid = item.uuid;
        detailsController.todoName = item.name;
        detailsController.todoPriority = item.priority;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SimpleTodoModel sharedInstance].todoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"Simple Todo Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];

    TodoItem *todoItem = [SimpleTodoModel sharedInstance].todoList[indexPath.row];
    cell.textLabel.text = todoItem.name;

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[SimpleTodoModel sharedInstance].todoList removeObjectAtIndex:indexPath.row];

        [self.tableView reloadData];
    }
}

#pragma mark - TodoItemViewControllerDelegate

-(void)todoItemViewControllerDidCancel:(TodoItemViewController *)controller
{

}

-(void)todoItemViewControllerDidComplete:(TodoItemViewController *)controller
{
    if ([controller.action isEqualToString:@"add"]) {
        TodoItem *item = [[TodoItem alloc] init];
        item.uuid = [[NSUUID UUID] UUIDString];
        item.name = controller.todoName;
        item.priority = controller.todoPriority;
        [[SimpleTodoModel sharedInstance].todoList addObject:item];
    } else {
        NSMutableArray *items = [SimpleTodoModel sharedInstance].todoList;
        
        for (TodoItem *item in items) {
            if ([item.uuid isEqualToString:controller.uuid]) {
                item.name = controller.todoName;
                item.priority = controller.todoPriority;
                break;
            }
        }
    }

    [self.tableView reloadData];
}

@end
