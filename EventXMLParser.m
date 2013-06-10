//
//  EventXMLParser.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/19/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "EventXMLParser.h"

@implementation EventXMLParser

-(id)init
{
    if(self = [super init])
    {
        self.onlineEventlist = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)parseFromAddress:(NSString *)address
{
    NSURL* url = [NSURL URLWithString:address];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    parser.delegate = self;
    [parser parse];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"])
    {
        currentOnlineEvent = [[OnlineEvent alloc] init];
    }
    /*
     // The url of the image is inside "enclousure" element
     // The following codes will take the url and save it into a NSString
    */
    if([elementName isEqualToString:@"enclosure"])
    {
        self.imgUrl = [attributeDict valueForKey:@"url"];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(currentValue == nil)
    {
        currentValue = [NSMutableString stringWithString:string];
    }
    else
    {
        [currentValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString* finalValue = [currentValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"item"])
    {
        [self.onlineEventlist addObject:currentOnlineEvent];
        currentOnlineEvent = nil;
    }
    if([elementName isEqualToString:@"title"])
    {
        currentOnlineEvent.title = finalValue;
    }
    if([elementName isEqualToString:@"description"])
    {
        currentOnlineEvent.description = finalValue;
    }
    if([elementName isEqualToString:@"pubDate"])
    {
        currentOnlineEvent.pubDate = finalValue;
    }
    if([elementName isEqualToString:@"link"])
    {
        currentOnlineEvent.link = finalValue;
    }
    // pass the stored image url to the current online event
    if([elementName isEqualToString:@"enclosure"])
    {
        currentOnlineEvent.imgUrl = self.imgUrl;
    }
    currentValue = nil;
}
@end
