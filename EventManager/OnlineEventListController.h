//
//  OnlineEventListController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineEventDetailController.h"
#import "OnlineEvent.h"

@interface OnlineEventListController : UITableViewController

@property (strong, nonatomic) NSArray* searchResults;

@end
