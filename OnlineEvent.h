//
//  OnlineEvent.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineEvent : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* pubDate;
@property NSString* link;
@property NSString* imgUrl;

@end
