//
//  ViewMapViewController.h
//  EventManager
//  This controller is used to take a selected location
//  in the location list and view its position on the map
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationAnnotation.h"
#import "Location.h"

@protocol ViewMapControllerDelegate <NSObject>

@end

@interface ViewMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) id<MKAnnotation> initialLocation;
@property (weak, nonatomic) id<ViewMapControllerDelegate> delegate;

-(void)addAnnotation:(id<MKAnnotation>)annotation;
-(void)focusOn:(id<MKAnnotation>)annotation;
-(IBAction)changeMapType:(UISegmentedControl *)sender;

@end
