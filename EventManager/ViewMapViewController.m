//
//  ViewMapViewController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "ViewMapViewController.h"

@interface ViewMapViewController ()

@end

@implementation ViewMapViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self addAnnotation:self.initialLocation];
    [self focusOn:self.initialLocation];
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

@end
