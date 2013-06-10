//
//  PhotoCollectionController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/16/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCell.h"
#import "PhotoViewController.h"
#import "Photo.h"
#import <CoreData/CoreData.h>
#import "Event.h"

@protocol PhotoCollectionControllerDelegate <NSObject>

-(void)savePhoto:(Photo*)photo;

@end

@interface PhotoCollectionController : UICollectionViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, PhotoViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray* imageList;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSIndexPath* cellIndexPath;
@property (strong, nonatomic) Event* eventToEdit;

@property (strong, nonatomic) id<PhotoCollectionControllerDelegate> delegate;

- (IBAction)openCamera:(id)sender;

@end
