//
//  OnlineEventDetailController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineEvent.h"
#import "OnlineEventWebsiteController.h"

@interface OnlineEventDetailController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *pubDateText;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UIImageView *eventImg;

@property (strong ,nonatomic) OnlineEvent* selectedEvent;
@end
