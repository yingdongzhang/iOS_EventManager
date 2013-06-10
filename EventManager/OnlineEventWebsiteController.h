//
//  OnlineEventWebsiteController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineEventWebsiteController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@property (strong, nonatomic) NSString* webAddress;

-(IBAction)goBack:(id)sender;
-(IBAction)goForward:(id)sender;

@end
