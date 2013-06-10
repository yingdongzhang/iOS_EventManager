//
//  EventListController.m
//  EventManager
//
//  Created by Yingdong Zhang on 3/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "EventListController.h"
#import "ViewController.h"

@interface EventListController ()

@end

@implementation EventListController


// when user saves an new event, add the new event to the event list,
// sort the list by time and refresh the table view
-(void)didSaveEvent:(Event *)event
{
    [self.eventList addObject:event];
    [self startArraySort:@"time" isAscending:NO];
    [self.tableView reloadData];
}

// when user finish editing an event,
// sort the list again by the time and refresh the table view
-(void)didEditEvent:(Event *)event
{
    [self startArraySort:@"time" isAscending:NO];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // if the segue is to add event, navigate to AddEventController
    if([segue.identifier isEqualToString:@"AddSegue"])
    {
        AddEventController* addEventcontroller = segue.destinationViewController;
        addEventcontroller.delegate = self;
        addEventcontroller.managedObjectContext = self.managedObjectContext;
        addEventcontroller.eventToEdit = nil;
    }
    // if the segue is to edit event, navigate to AddEventController
    else if([segue.identifier isEqualToString:@"EditSegue"])
    {
        AddEventController* editEventController = segue.destinationViewController;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        Event* event = [self.eventList objectAtIndex:indexPath.row];
        editEventController.delegate = self;
        editEventController.managedObjectContext = self.managedObjectContext;
        editEventController.eventToEdit = event;
        //editEventController.eventToEdit.photos = event.photos;
    }
}

//sort the event list by a passing NSString
-(void)startArraySort:(NSString *)keystring isAscending:(BOOL)isAsending
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:keystring ascending:isAsending];
    self.eventList = [[NSMutableArray alloc]initWithArray:[self.eventList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
}


- (void)viewDidLoad
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* eventDescription = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:eventDescription];
    
    NSError* error;
    
    NSMutableArray* fetchResults = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];

    if(fetchResults != nil)
    {
        self.eventList = fetchResults;
        [self startArraySort:@"time" isAscending:NO];// when the page loads, sort the event list
    }
    else
    {
        NSLog(@"Core Data Fetch Error: %@", [error description]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.eventList count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SampleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Event* event = [self.eventList objectAtIndex:indexPath.row];
    if(![event.title isEqualToString: NULL])
    {
        cell.titleLabel.text = event.title;
        cell.locationLabel.text = event.location;
        cell.peopleLabel.text = event.people;
        cell.timeLabel.text = event.time;
        
    }
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObject* objectToDelete = [self.eventList objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:objectToDelete];
        [self.managedObjectContext save:nil];
        [self.eventList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Table view delegate
@end
