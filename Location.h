//
//  Location.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/29/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSSet *events;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
