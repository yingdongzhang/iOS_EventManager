//
//  PhotoViewController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/16/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

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
    NSData* imgData = self.photoToView.photo;
    UIImage* img = [UIImage imageWithData:imgData];
    self.photoView.image = img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deletePhoto:(id)sender {
    [self.delegate deleteSelectedPhoto:self.photoToView];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
