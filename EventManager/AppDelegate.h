//
//  AppDelegate.h
//  EventManager
//
//  Created by Yingdong Zhang on 3/27/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EventListController.h"
#import "Event.h"
#import "AddEventController.h"
#import "PhotoCollectionController.h"
//#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

//@property (nonatomic, retain) UINavigationController *navigationController;

@end
