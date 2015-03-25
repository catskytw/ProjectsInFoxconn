//
//  JSONParser.m
//  FloraExpo2010
//
//  Created by Liao Change on 8/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JSONObject.h"
#import "JSON.h"
#import "ToolsFunction.h"
#import "LocalizationSystem.h"
#import "Vars.h"
@implementation JSONObject
- (id) objectWithUrl:(NSURL *)url
{
	SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url];
	
	id returnObject=[jsonParser objectWithString:jsonString error:NULL];
	[jsonParser release];
	return returnObject;
}
- (NSString *)stringWithUrl:(NSURL *)url
{	
	NSThread *waitCursorThread=[[NSThread alloc]initWithTarget:[ToolsFunction class] selector:@selector(addWaitCursor) object:nil];
	[waitCursorThread start];
	sleep(1);
	// Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	@try{
		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
													cachePolicy:NSURLRequestReturnCacheDataElseLoad
												timeoutInterval:30];
		
		// Make synchronous request
		urlData = [NSURLConnection sendSynchronousRequest:urlRequest
										returningResponse:&response
													error:&error];
	}@catch (id ex) {
		urlData=nil;
	}
	[ToolsFunction delWaitCursor];
	[waitCursorThread release];
	
 	// Construct a String around the Data from the response
	return (urlData!=nil)?[[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]autorelease]:
	@"";
}
@end
