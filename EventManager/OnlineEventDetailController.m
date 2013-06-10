//
//  OnlineEventDetailController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "OnlineEventDetailController.h"

@interface OnlineEventDetailController ()

@end

@implementation OnlineEventDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.titleText.text = [NSString stringWithFormat:@"Title: %@", self.selectedEvent.title];
    self.pubDateText.text = [NSString stringWithFormat:@"Publish Date: %@", self.selectedEvent.pubDate];
    self.descriptionText.text = self.selectedEvent.description;
    // parse the image url and return the image as an NSData object
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.selectedEvent.imgUrl]];
    // convert the image data into UIImage and set it to the event image
    self.eventImg.image = [UIImage imageWithData:imageData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // pass the event link to the web view in order to load it
    if([segue.identifier isEqualToString:@"webSegue"])
    {
        OnlineEventWebsiteController* controller = segue.destinationViewController;
        controller.webAddress =self.selectedEvent.link;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
