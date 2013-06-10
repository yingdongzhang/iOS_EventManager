//
//  SampleTableCell.h
//  EventManager
//
//  Created by Yingdong Zhang on 4/7/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *peopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
