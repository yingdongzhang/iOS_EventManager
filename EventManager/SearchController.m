//
//  SearchController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/18/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"searchTopEventSegue"])
    {
        OnlineEventListController *controller = segue.destinationViewController;
        NSString *address = [[NSString alloc]init];
        EventXMLParser *parser = [[EventXMLParser alloc] init];
        
        address = @"http://www.eventfinder.com.au/feed/top-events-this-week.rss";
        [parser parseFromAddress:address];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSLog(@"Top Events: %i" ,[parser.onlineEventlist count]);
        controller.searchResults = parser.onlineEventlist;
    }
    if([segue.identifier isEqualToString:@"searchComingEventSegue"])
    {
        OnlineEventListController *controller = segue.destinationViewController;
        NSString *address = [[NSString alloc]init];
        EventXMLParser *parser = [[EventXMLParser alloc] init];
        
        address = @"http://www.eventfinder.com.au/feed/events/australia/whatson/upcoming/tickets/yes.rss";
        [parser parseFromAddress:address];
        // when the app access the internet, show the network activity indicator for better user experience
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSLog(@"Coming Events: %i" ,[parser.onlineEventlist count]);
        controller.searchResults = parser.onlineEventlist;
    }
}

@end
