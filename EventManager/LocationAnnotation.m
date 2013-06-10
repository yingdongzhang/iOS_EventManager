//
//  LocationAnnotation.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation

-(id)initWithTitle:(NSString *)title subTitle:(NSString *)subtitle lat:(double)lat andLong:(double)lng
{
    if(self = [super init])
    {
        self.title = title;
        self.subtitle = subtitle;
        CLLocationCoordinate2D loc;
        loc.latitude = lat;
        loc.longitude = lng;
        self.coordinate = loc;
    }
    return self;
}

@end
