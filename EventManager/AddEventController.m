//
//  AddEventController.m
//  EventManager
//
//  Created by Yingdong Zhang on 3/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "AddEventController.h"

@interface AddEventController ()

@end

@implementation AddEventController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleText.delegate = self;
    self.detailText.delegate = self;
    self.locationText.delegate = self;
    self.peopleText.delegate = self;
    self.timeText.delegate = self;
    
    self.names = [[NSString alloc]init]; // store contacts' names selected from address book
        
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    
    self.timeText.inputView = self.datePicker;

	// grab the value of each attribute of the event and set it on to respective element
    if(self.eventToEdit != nil)
    {
        self.editMode = YES;
        self.titleText.text = self.eventToEdit.title;
        self.detailText.text = self.eventToEdit.detail;
        self.locationText.text = self.eventToEdit.location;
        self.peopleText.text = self.eventToEdit.people;
        self.timeText.text = self.eventToEdit.time;
        self.latitude = self.eventToEdit.latitude;
        self.longitude = self.eventToEdit.longitude;
        
        // set the location on map to the event's location
        self.eventLocation = [[LocationAnnotation alloc] initWithTitle:self.eventToEdit.location subTitle:@"" lat:self.eventToEdit.latitude andLong:self.eventToEdit.longitude];
        NSLog(@"Editing an event");
    }
    else
    {
        // if adding a new event, disable the share button
        [self.shareButton setEnabled:NO];
        self.editMode = FALSE;
        NSLog(@"Add a new event");
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 10;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    if(!self.editMode)
    {
        self.eventToEdit = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    // if the location is not null, which means the location comes from the location of the event being edit, show the annotation and focus on it
    if(self.eventLocation != nil)
    {
        [self.eventMap removeAnnotations:self.eventMap.annotations];
        [self addAnnotation:self.eventLocation];
        [self focusOn:self.eventLocation];
    }
    // else, which means the user is current adding a new event, focus on the user's current location
    else
    {
        [self focusOn:self.eventMap.userLocation];
    }
}

//dismiss the keyboard then user click return key
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"chooseLocationFromList"])
    {
        LocationListController* controller = segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
    }
    if([segue.identifier isEqualToString:@"choosePhotoSegue"])
    {
        PhotoCollectionController* controller = segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
        controller.delegate = self;
        controller.eventToEdit = self.eventToEdit;
    }
}

// called when save a new event button is clicked
- (IBAction)saveEvent:(id)sender
{
    //if the title is blank, show an alert and ask the user to type in
    if([self.titleText.text isEqualToString: @""] || [self.locationText.text isEqualToString:@""] || [self.peopleText.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Title, location and people should not be blank, please check your input!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else
    {
        // adding a new event
        if(!self.editMode)
        {
            self.eventToEdit.title = self.titleText.text;
            self.eventToEdit.detail = self.detailText.text;
            self.eventToEdit.location = self.locationText.text;
            self.eventToEdit.people = self.peopleText.text;
            self.eventToEdit.time = self.timeText.text;
            self.eventToEdit.latitude = self.latitude;
            self.eventToEdit.longitude = self.longitude;
            [self.delegate didSaveEvent:self.eventToEdit];
        }
        // editing an event
        else
        {
            self.eventToEdit.title = self.titleText.text;
            self.eventToEdit.detail = self.detailText.text;
            self.eventToEdit.location = self.locationText.text;
            self.eventToEdit.people = self.peopleText.text;
            self.eventToEdit.time = self.timeText.text;
            self.eventToEdit.latitude = self.latitude;
            self.eventToEdit.longitude = self.longitude;

            [self.delegate didEditEvent:self.eventToEdit];
        }

        NSError* error;
        if(![self.managedObjectContext save:&error])
        {
            NSLog(@"Core Data Save Error: %@", [error description]);
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
}

// get called in PhotoCollectionController when user picks a photo in the photo library
// add the photo to the event
-(void)savePhoto:(Photo *)photo
{
    [self.eventToEdit addPhotosObject:photo];
    NSError* error;
    if(![self.managedObjectContext save:&error])
    {
        NSLog(@"Core Data Save Error: %@", [error description]);
    }
}

/**
 The following methods is referenced from:
 http://developer.apple.com/library/ios/#documentation/ContactData/Conceptual/AddressBookProgrammingGuideforiPhone/Chapters/QuickStart.html
 */
/*
 */
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self displayPerson:person];
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

/*
 Add the related records of selected contact to the text of people textfield in AddEventController
 */
-(void)displayPerson: (ABRecordRef)person
{
    NSString* fname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    self.names = [self.names stringByAppendingFormat:@"%@ %@, ", fname, lname];
    NSLog(@"%@", self.names);
    self.peopleText.text = self.names;
}

/*
 Open the systen contact application, called when the "add contact" button is clicked
 */
- (IBAction)openContactsPicker:(id)sender {
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* loc = [locations lastObject];
    currentLocation = loc.coordinate;
}

/*
 Convert the location(latitude and longtitude to address) 
 and insert the current location to the location textfield
 */
-(IBAction)insertCurrentLocation:(id)sender
{
    CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark* pm = [placemarks objectAtIndex:0];
        NSString * address = [NSString stringWithFormat:@"%@, %@, %@, %@",pm.name, pm.locality, pm.administrativeArea, pm.country];
    
                       LocationAnnotation* a = [[LocationAnnotation alloc] initWithTitle:pm.name subTitle:pm.locality lat:pm.location.coordinate.latitude andLong:pm.location.coordinate.longitude];
                       
                       self.locationText.text = address;
                       self.latitude = a.coordinate.latitude;
                       self.longitude = a.coordinate.longitude;
                       [self focusOn:a];
                       [self addAnnotation:a];
    }];
}

/*
 Called when user taps the share button
 Shows the sharing window and set the event's content
 to the selected sharing tool.
 */
- (IBAction)shareEvent:(id)sender
{
    NSString *content = [NSString stringWithFormat:@"Event:%@\nLocation: %@\nPeople: %@\nTime: %@\nNotes: %@\n", self.titleText.text, self.locationText.text, self.peopleText.text, self.timeText.text, self.detailText.text];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    [items addObject:content];
    
    NSArray *photos = [self.eventToEdit.photos allObjects];
    
    // put all the photos into an array and add the array to the items for sharing
    // user can share images along with the event's detail
    for(Photo* photo in photos)
    {
        NSData *imgData = photo.photo;
        UIImage *img = [UIImage imageWithData:imgData];
        [items addObject:img];
    }

    UIActivityViewController* controller = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

/*
 Add annotation to the mapView
 */
-(void)addAnnotation:(id<MKAnnotation>)annotation
{
    [self.eventMap addAnnotation:annotation];
}

/*
 Focus on the added annotation
 */
-(void)focusOn:(id<MKAnnotation>)annotation
{
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    MKCoordinateRegion region;
    region.span = span;
    
    self.eventMap.region = region;
    
    self.eventMap.centerCoordinate = annotation.coordinate;
    [self.eventMap selectAnnotation:annotation animated:YES];
}

// dismiss the keyboard when the user touch the background
- (IBAction)backgroundTap:(id)sender
{
    [self.titleText resignFirstResponder];
    [self.detailText resignFirstResponder];
    [self.locationText resignFirstResponder];
    [self.peopleText resignFirstResponder];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate* date = [self.datePicker date];
    NSString* eventDate = [dateFormatter stringFromDate:date];
    self.timeText.text = [NSString stringWithFormat:@"%@", eventDate];
    
    [self.timeText resignFirstResponder];
}
@end
