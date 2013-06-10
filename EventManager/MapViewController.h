//
//  MapViewController.h
//  EventManager
//  This controller is used to selected a location on the map
//  when user chooses to add a new location to the location list
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationAnnotation.h"
#import "Location.h"

@protocol MapViewControllerDelegate <NSObject>

-(void)didAddAnnotation:(LocationAnnotation*)annotation;

@end

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) id<MKAnnotation> initialLocation;
@property (strong, nonatomic) LocationAnnotation* pointedLocationAnnotation;// the annotation of the location where user long presses on
@property (strong, nonatomic) id<MapViewControllerDelegate> delegate;

-(void)addAnnotation:(id<MKAnnotation>)annotation;
-(void)focusOn:(id<MKAnnotation>)annotation;

-(IBAction)changeMapType:(UISegmentedControl *)sender;
-(IBAction)longPressOnMap:(UILongPressGestureRecognizer *)sender;
- (IBAction)addLocationToList:(id)sender;

@end
