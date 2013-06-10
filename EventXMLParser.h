//
//  EventXMLParser.h
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnlineEvent.h"

@interface EventXMLParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser* parser;
    OnlineEvent* currentOnlineEvent;
    NSMutableString* currentValue;
}

@property (strong, nonatomic) NSMutableArray* onlineEventlist;
@property (strong, nonatomic) NSString* imgUrl;

-(void)parseFromAddress:(NSString*)address;

@end
