//
//  XMLParserObject.m
//  Hello_SOAP
//
//  Created by 廖 晨志 on 2011/6/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "XMLParserObject.h"


@implementation XMLParserObject
@synthesize rDic;
-(id)initWithXMLString:(NSString*)xmlString withSearchKeys:(NSArray*)keys{
    if((self=[super init])){
        rDic=[[NSMutableDictionary dictionary]retain];
        searchKeys=[[NSArray arrayWithArray:keys]retain];
        NSData *data=[xmlString dataUsingEncoding:NSUTF16StringEncoding];
        parser=[[NSXMLParser alloc] initWithData: data];
        [parser setDelegate: self];
        [parser setShouldResolveExternalEntities: YES];
        [parser parse];
        
    }
    return self;
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    for(NSString *key in searchKeys){
        if( [elementName isEqualToString:key])
        {
            if(!results)
            {
                results = [[NSMutableString alloc] init];
            }
            recordResults = YES;
        }
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if( recordResults )
	{
		[results appendString: string];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    for(NSString *key in searchKeys){
        if( [elementName isEqualToString:key])
        {
            recordResults = NO;
            [rDic setValue:results forKey:key];
            [results release];
            results = nil;
        }
    }
}

-(void)dealloc{
    [rDic release];
    [searchKeys release];
    [super dealloc];
}
@end
