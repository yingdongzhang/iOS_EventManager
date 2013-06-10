//
//  EventListController.h
//  EventManager
//
//  Created by Yingdong Zhang on 3/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AddEventController.h"
#import "SampleTableCell.h"

@interface EventListController : UITableViewController <AddEventControllerDelegate>

@property (strong, nonatomic) NSMutableArray* eventList;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSIndexPath* cellIndexPath;


//- (IBAction)aboutButtonPress:(id)sender;


@end
