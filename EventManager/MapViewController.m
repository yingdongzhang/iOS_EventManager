//
//  MapViewController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
	// Do any additional setup after loading the view.
}

/*
 When the view appears, show the current location
 */
- (void)viewDidAppear:(BOOL)animated
{
    [self.mapView setShowsUserLocation:YES];
    //Customize the "Current Location" annotation to annotation with title and subtitle
    LocationAnnotation* locAn = [[LocationAnnotation alloc] initWithTitle:self.mapView.userLocation.title subTitle:self.mapView.userLocation.subtitle lat:self.mapView.userLocation.coordinate.latitude andLong:self.mapView.userLocation.coordinate.longitude];
    [self focusOn:locAn];
    [self addAnnotation:locAn];
    //self.mapView.delegate = self;
}


/*
 move to the current location when the map view appears
 */
-(void)mapView:(MKMapView*)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView* annotationView = [views objectAtIndex:0];
    id<MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 5000, 5000);
    
    [mv setRegion:region animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Add annotation to the mapView
 */
-(void)addAnnotation:(id<MKAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
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
    
    self.mapView.region = region;
    
    self.mapView.centerCoordinate = annotation.coordinate;
    [self.mapView selectAnnotation:annotation animated:YES];
}

/*
 Change the map type when a certain map type segment is selected
 */
-(IBAction)changeMapType:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break; 
        default:
            self.mapView.mapType = MKMapTypeStandard;
    }
}

/*
 * Using a long press gesture recognizer to plot a location on the map
 * Using a Geocoder to get the name of the location that is to be plotted on the map
 * This method keeps and return only one annotation on the mapview, each time a long press happends, the new annotation will replace the old one.
 */
- (IBAction)longPressOnMap:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"%i",[self.mapView.annotations count]);
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coor = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        NSLog(@"Lat: %f Long: %f", coor.latitude, coor.longitude);
        
        CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
        CLLocation* loc = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
        
        [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error)
         {
             CLPlacemark* pm = [placemarks objectAtIndex:0];
             
             LocationAnnotation* locAn = [[LocationAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"%@, %@", pm.name, pm.locality] subTitle:[NSString stringWithFormat:@"%@ - %@", pm.administrativeArea, pm.country] lat:coor.latitude andLong:coor.longitude];
             
             for (int i = 0; i < [self.mapView.annotations count]; i++)
             {
                 [self.mapView removeAnnotation:[self.mapView.annotations objectAtIndex:i]];
             }
             [self addAnnotation:locAn];
         }];
    }
}

/*
 Add the newest annotation to the location list.
 */
- (IBAction)addLocationToList:(id)sender
{
    self.pointedLocationAnnotation = [self.mapView.annotations objectAtIndex:0];
    [self.delegate didAddAnnotation:self.pointedLocationAnnotation];
}

@end
