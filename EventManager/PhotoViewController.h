//
//  PhotoViewController.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/16/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@protocol PhotoViewControllerDelegate <NSObject>

-(void)deleteSelectedPhoto:(Photo *)photo;

@end

@interface PhotoViewController : UIViewController

//@property (strong, nonatomic) UIImage* photoToView;
@property (strong, nonatomic) Photo* photoToView;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) id<PhotoViewControllerDelegate> delegate;

- (IBAction)deletePhoto:(id)sender;
@end
