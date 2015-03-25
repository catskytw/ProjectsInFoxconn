//
//  QueryPattern.m
//  FoxconnQueryLib
//
//  Created by 廖 晨志 on 2010/12/2.
//  Copyright 2010 foxconn. All rights reserved.
//

#import "QueryPattern.h"
#import "SBJsonParser.h"
#import "DownloadThreadObject.h"
#import "JSONCoreDataUtil.h"
@implementation QueryPattern

-(BOOL)prepareDicWithDictionary:(NSDictionary*)outsideDic{
	if(outsideDic!=nil)
		jsonDic=[[NSDictionary dictionaryWithDictionary:outsideDic]retain];
	return YES;
}
-(BOOL)prepareDic:(NSString*)urlString{
	NSLog(@"%@",urlString);
	jsonDic=[[NSDictionary dictionaryWithDictionary:(NSDictionary*)[self getJSONRawResult:urlString]]retain];

	return YES;
}
-(void)dealloc{
	[jsonDic release];
	[super dealloc];
}
-(BOOL)valueBinding:(id)uiComponents withKey:(NSString *)key withIndexArray:(NSUInteger)index{
	NSString *value=[self getValue:key withIndex:index];
	[self uiValueBinding:uiComponents withValue:value];
	return YES;
}
-(BOOL)valueBindings:(NSArray*)uiComponents withKey:(NSString*)key withIndexArray:(NSArray*)indexs{
	NSMutableArray *indexsClone;
	if(indexs!=nil){
		indexsClone=[NSMutableArray arrayWithArray:indexs];
		if([indexsClone count]<[uiComponents count]){
			for(int i=0;i<[uiComponents count]-[indexsClone count];i++)
				[indexsClone addObject:[NSNumber numberWithInt:-1]];
		}
	}
	for(int i=0;i<[uiComponents count];i++){
		NSString *value=(indexs==nil)?[self getValue:key withIndex:i]:
		[self getValue:key withIndex:[(NSNumber*)[indexsClone objectAtIndex:i]intValue]];
		[self uiValueBinding:[uiComponents objectAtIndex:i] withValue:value];
	}
	return YES;
}	
-(NSInteger)getNumberUnderNode:(NSString*)nodeName withKey:(NSString*)key{
	NSDictionary *resultDic=jsonDic;
	id baseNode=nil;
	NSInteger numberCount;
	JSONCoreDataUtil *baseCoreTool=[JSONCoreDataUtil new];
	JSONCoreDataUtil *searchTool=[JSONCoreDataUtil new];
	[baseCoreTool fetchObjects:resultDic withQueryString:nodeName];
	if([baseCoreTool.dataArray count]>0)
		baseNode=[baseCoreTool.dataArray objectAtIndex:0];
	[searchTool fetchObjectsWithNoTypeDataSource:baseNode withQueryString:key];
	numberCount=[searchTool.dataArray count];
	[baseCoreTool release];
	[searchTool release];
	return numberCount;
}
-(id)getObjectUnderNode:(NSString*)nodeName withIndex:(NSInteger)index{
	NSDictionary *resultDic=jsonDic;
	id baseNode=nil;
	JSONCoreDataUtil *baseCoreTool=[JSONCoreDataUtil new];
	[baseCoreTool fetchObjects:resultDic withQueryString:nodeName];
	if([baseCoreTool.dataArray count]>=index)
		baseNode=[baseCoreTool.dataArray objectAtIndex:index];
	return baseNode;
}
-(NSString*)getValueUnderNode:(NSString*)nodeName withKey:(NSString*)key withIndex:(NSUInteger)index{
	NSDictionary *resultDic=jsonDic;
	id baseNode=nil;
	NSString *resultString;
	JSONCoreDataUtil *baseCoreTool=[JSONCoreDataUtil new];
	JSONCoreDataUtil *searchTool=[JSONCoreDataUtil new];
	[baseCoreTool fetchObjects:resultDic withQueryString:nodeName];
	if([baseCoreTool.dataArray count]>0)
		baseNode=[baseCoreTool.dataArray objectAtIndex:0];
	[searchTool fetchObjectsWithNoTypeDataSource:baseNode withQueryString:key];
	resultString=[NSString stringWithString:[searchTool searchValue:index]];
	[baseCoreTool release];
	[searchTool release];
	return resultString;
}
-(NSString*)getValue:(NSString*)key withIndex:(NSUInteger)index{
	NSDictionary *resultDic=jsonDic;
	NSString *resultString;
	JSONCoreDataUtil *coreTool=[JSONCoreDataUtil new];
	[coreTool fetchObjects:resultDic withQueryString:key];
	resultString=[NSString stringWithString:[coreTool searchValue:index]];
	[coreTool release];
	return resultString;
}
-(NSInteger)getNumberForKey:(NSString*)key{
	NSDictionary *resultDic=jsonDic;
	JSONCoreDataUtil *coreTool=[JSONCoreDataUtil new];
	[coreTool fetchObjects:resultDic withQueryString:key];
	NSInteger resultNum=[coreTool.dataArray count];
	[coreTool release];
	return resultNum;
}
-(id)getJSONRawResult:(NSString*)urlString{
	NSString *escapedUrlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//id returnObject=[self objectWithUrl:[NSURL URLWithString:urlString]];
	id returnObject=[self objectWithUrl:[NSURL URLWithString:escapedUrlString]];
	return returnObject;
}

-(void)getImageData:(NSString*)urlString withUIComponent:(id)uiComponent withNotificationName:(NSString*)notificationName{
	DownloadThreadObject *o;
	if(notificationName==nil || [notificationName isEqualToString:@""])
		o=[DownloadThreadObject new];
	else {
		o=[[DownloadThreadObject alloc]initWithNotificationName:notificationName];
	}

    if ([uiComponent isKindOfClass:[UIImageView class]]){
		[o start:urlString withTargetView:(UIImageView*)uiComponent];
	}else if([uiComponent isKindOfClass:[UIButton class]]){
		[o start:urlString withTargetButton:(UIButton*)uiComponent];
	}else{
		NSLog(@"uiComponent class is not supported!");
	}
	[o release];
}

//You should not use this method.
-(id) objectWithUrl:(NSURL *)url
{
	SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url];
	NSLog(jsonString);
	id returnObject=[jsonParser objectWithString:jsonString error:NULL];
	[jsonParser release];
	return returnObject;
}

//You should not use this method.
-(NSString *)stringWithUrl:(NSURL *)url
{
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
	}@catch (id e) {
		return @"{}";
	}
 	// Construct a String around the Data from the response
	return [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]autorelease];
}

-(void)uiValueBinding:(id)uiComponent withValue:(NSString*)value{
	@try{
		if([uiComponent isKindOfClass:[UILabel class]]){
			[(UILabel*)uiComponent setText:value];
		}else if([uiComponent isKindOfClass:[UITextField class]]){
			[(UITextField*)uiComponent setText:value];
		}else if([uiComponent isKindOfClass:[UITextView class]]){
			[(UITextView*)uiComponent setText:value];
		}else if([uiComponent isKindOfClass:[UIButton class]]){
			if([value rangeOfString:@"http://"].length!=0)
				[self getImageData:value withUIComponent:uiComponent withNotificationName:nil];
			else 
				[(UIButton*)uiComponent setTitle:value forState:UIControlStateNormal];
		}else if([uiComponent isKindOfClass:[UIImageView class]])
			[self getImageData:value withUIComponent:uiComponent withNotificationName:nil];
	}@catch (NSException *e) {
		NSLog(@"Value binding error!");
	}
}
@end
