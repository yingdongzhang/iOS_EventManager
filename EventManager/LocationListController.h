//
//  LocationListController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "LocationAnnotation.h"
#import "ViewMapViewController.h"
#import "AddEventController.h"
#import <CoreData/CoreData.h>
#import "Location.h"

@interface LocationListController : UITableViewController <MapViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray* locationList;
@property (strong, nonatomic) MapViewController* mapViewController;
@property (strong, nonatomic) ViewMapViewController* viewMapViewController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

@end
