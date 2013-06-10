//
//  LocationAnnotation.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/9/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* subtitle;

-(id)initWithTitle:(NSString*)title subTitle:(NSString*)subtitle lat:(double)lat andLong:(double)lng;

@end
