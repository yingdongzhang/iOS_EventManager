//
//  AddEventController.h
//  EventManager
//
//  Created by Yingdong Zhang on 3/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <AddressBookUI/AddressBookUI.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LocationAnnotation.h"
#import "PhotoCollectionController.h"
#import "LocationListController.h"

@protocol AddEventControllerDelegate <NSObject>

-(void)didSaveEvent:(Event*)event;
-(void)didEditEvent:(Event*)event;

@end

@interface AddEventController : UIViewController <UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate, CLLocationManagerDelegate, PhotoCollectionControllerDelegate>
{
    CLLocationManager* locationManager;
    CLLocationCoordinate2D currentLocation;
}

@property (strong, nonatomic) IBOutlet UITextField *titleText;
@property (strong, nonatomic) IBOutlet UITextView *detailText;
@property (strong, nonatomic) IBOutlet UITextField *peopleText;
@property (strong, nonatomic) IBOutlet UITextField *timeText;
@property (strong, nonatomic) IBOutlet UITextView *locationText;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (strong, nonatomic) IBOutlet MKMapView *eventMap;
@property double latitude;
@property double longitude;
@property (strong, nonatomic)Photo* photo;
@property (strong, nonatomic) id<MKAnnotation> eventLocation; // the location of the event


@property (strong, nonatomic) Event* eventToEdit;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSString* names;
@property (strong, nonatomic) NSArray* emailArray;

@property (weak, nonatomic) id<AddEventControllerDelegate> delegate;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property BOOL editMode;

- (IBAction)saveEvent:(id)sender;
- (IBAction)openContactsPicker:(id)sender;
- (IBAction)insertCurrentLocation:(id)sender;
- (IBAction)shareEvent:(id)sender;
-(void)addAnnotation:(id<MKAnnotation>)annotation;
-(void)focusOn:(id<MKAnnotation>)annotation;

@end
