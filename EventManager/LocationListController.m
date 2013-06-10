//
//  LocationListController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "LocationListController.h"

@implementation LocationListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationList = [[NSMutableArray alloc] init];
    
    // Sample location
    LocationAnnotation* locAn = [[LocationAnnotation alloc]initWithTitle:@"Monash - Caulfield Campus" subTitle:@"28 Sir John Monash Dr, Caulfield East VIC 3145, Australia." lat:-37.877623 andLong:145.045374];
    [self.locationList addObject:locAn];
    [self.mapViewController addAnnotation:locAn];
    
    // load other locations from core data
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSError* error;
    
    NSMutableArray* fetchResults = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if(fetchResults != nil)
    {
        for(Location* location in fetchResults)
        {
            LocationAnnotation* locAn = [[LocationAnnotation alloc] initWithTitle:location.title subTitle:location.subtitle lat:location.latitude andLong:location.longitude];
            [self.locationList addObject:locAn];
        }
    }
    else
    {
        NSLog(@"Core Data Error: %@", [error description]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Add the annotation to the location list
 * remove duplicate locations if the title of the annotation 
 * already exists in the list
 */
- (void)didAddAnnotation:(LocationAnnotation *)annotation
{
    for(int i = 0; i < [self.locationList count]; i++ )
    {
        LocationAnnotation* loopAnnotation = [self.locationList objectAtIndex:i];
        
        if([loopAnnotation.title isEqualToString:annotation.title])
        {
            [self.locationList removeObject:annotation];
        }
    }
    
    // convert the annotation into a new location, and save it to core data
    Location* newLocation = (Location*)[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    newLocation.title = annotation.title;
    newLocation.subtitle = annotation.subtitle;
    newLocation.latitude = annotation.coordinate.latitude;
    newLocation.longitude = annotation.coordinate.longitude;
    
    NSError* error;
    if(!([self.managedObjectContext save:&error]))
    {
        NSLog(@"Core Data Save Error: %@", [error description]);
    }
    
    [self.locationList addObject:annotation];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // called when user chooses to select location on the map
    if([segue.identifier isEqualToString:@"chooseLocationOnMapSegue"])
    {
        MapViewController* controller = segue.destinationViewController;
        controller.delegate = self;
    }
    // calle when user chooses to view the selected location on the map
    if([segue.identifier isEqualToString:@"viewLocationOnMapSegue"])
    {
        ViewMapViewController* controller = segue.destinationViewController;
        NSIndexPath* selectedIndex = [self.tableView indexPathForCell:sender];
        controller.initialLocation = [self.locationList objectAtIndex:selectedIndex.row];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.locationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LocationAnnotation* locAn = [self.locationList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = locAn.title;
    cell.detailTextLabel.text = locAn.subtitle;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.locationList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
 


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
 // Called when user taps on a cell and jumps back to the add event view
 // This methods takes the title of the annotation which is in the selected cell
 // and sets its value to the location text field in the add event view
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [self.viewMapViewController focusOn:[self.locationList objectAtIndex:indexPath.row]];
    
    AddEventController* controller = [self.navigationController.viewControllers objectAtIndex:1];
    LocationAnnotation* selectedAnnotation = [self.locationList objectAtIndex:indexPath.row];
    controller.locationText.text = [NSString stringWithFormat:@"%@, %@", selectedAnnotation.title, selectedAnnotation.subtitle];
    controller.latitude = selectedAnnotation.coordinate.latitude;
    controller.longitude = selectedAnnotation.coordinate.longitude;
    controller.eventLocation = selectedAnnotation;
    
    [self.navigationController popToViewController:controller animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
