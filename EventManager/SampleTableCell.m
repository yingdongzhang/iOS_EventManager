//
//  SampleTableCell.m
//  EventManager
//
//  Created by Yingdong Zhang on 4/7/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "SampleTableCell.h"

@implementation SampleTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel.text = self;
        self.locationLabel.text = self;
        self.peopleLabel.text = self;
        self.timeLabel.text = self;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
