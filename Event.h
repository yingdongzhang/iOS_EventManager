//
//  Event.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property double latitude;
@property (nonatomic, retain) NSString * location;
@property double longitude;
@property (nonatomic, retain) NSString * people;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
