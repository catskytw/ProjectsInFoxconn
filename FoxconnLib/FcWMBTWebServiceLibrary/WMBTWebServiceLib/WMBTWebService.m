//
//  WMBTWebService.m
//  WMBTWebServiceLib
//
//  Created by 廖 晨志 on 2011/6/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "WMBTWebService.h"
#import "OrderDtlObject.h"
#import "XMLParserObject.h"
@interface WMBTWebService (PrivateMethod)
-(NSString*)advanceString:(NSArray*)advanceProdDtlModelArray;
-(BOOL)orderResult:(NSData*)inputData;
@end


@implementation WMBTWebService
@synthesize resultDic;
@synthesize _urlPrefix;
-(id)initWithNotificationName:(NSString*)notificationName withURLPrefix:(NSString*)urlPrefix{
    if((self=[super init])){
        resultDic=nil;
        _notificationName=[[NSString stringWithString:notificationName]
                        retain];
        _urlPrefix=[[NSString stringWithString:urlPrefix] retain];
    }
    return self;
}
-(void)dealloc{
    if(resultDic!=nil)
        [resultDic release];
    if(_notificationName!=nil)
        [_notificationName release];
    if(_urlPrefix!=nil)
        [_urlPrefix release];
    [super dealloc];
}
-(BOOL)createAdvance:(NSArray*)advanceProdDtlModelArray withCpy:(NSString*)cpyId withMember:(NSString*)memberId{
    BOOL r=NO;
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><createAdvance xmlns=\"http://service.foxconn.com\"><in0>%@</in0><in1>%@</in1><in2>%@</in2></createAdvance></soap:Body></soap:Envelope>",[self advanceString:advanceProdDtlModelArray],cpyId,memberId];
    NSLog(@"SOAP Request:%@",soapMessage);
    NSURL *url = [NSURL URLWithString:_urlPrefix];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://service.foxconn.com/createAdvance" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest addValue:@"10.155.4.121:7000" forHTTPHeaderField:@"HOST"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
    return r;
}

-(BOOL)orderResult:(NSData*)inputData{
    NSMutableData *_webData=[NSMutableData dataWithData:inputData];
    NSString *theXML = [[[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding]autorelease];
    NSLog(@"XML:%@",theXML);
    XMLParserObject *parser=[[XMLParserObject alloc]initWithXMLString:theXML withSearchKeys:[NSArray arrayWithObjects:@"out", nil]];
    resultDic=[[NSMutableDictionary dictionaryWithDictionary:parser.rDic]retain];
    return YES;
}
-(NSString*)advanceString:(NSArray*)advanceProdDtlModelArray{
    NSString *r=@"";
    for(OrderDtlObject *o in advanceProdDtlModelArray){
        r=[r stringByAppendingFormat:@"<AdvanceProdDtlModel xmlns=\"http://model.kiosk.connector.hh.com\"><price>%@</price><prodId>%@</prodId><prodQty>%@</prodQty></AdvanceProdDtlModel>",o.prodPrice,o.prodId,o.prodQty];
    }
    return r;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"connection start!!");
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
    [resultDic setValue:@"-1" forKey:@"out"];
    [[NSNotificationCenter defaultCenter]postNotificationName:_notificationName object:nil userInfo:resultDic];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
    [self orderResult:webData];
    [[NSNotificationCenter defaultCenter]postNotificationName:_notificationName object:nil userInfo:resultDic];
}
@end
