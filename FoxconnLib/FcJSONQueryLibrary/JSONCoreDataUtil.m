//
//  JSONCoreDataUtil.m
//  FoxconnQueryLib
//
//  Created by 廖 晨志 on 2010/12/21.
//  Copyright 2010 foxconn. All rights reserved.
//
#define MAX_DEPTH 100000

#import "JSONCoreDataUtil.h"
#import "JSON.h"
#import "NSString+SBJSON.h"
#import "QueryPattern.h"
@implementation JSONCoreDataUtil
@synthesize dataArray,depthIndex;
-(id)init{
	if((self=[super init])){
		dataArray=[[NSMutableArray arrayWithObjects:nil]retain];
        depthIndex=MAX_DEPTH;
	}
	return self;
}

-(void)dealloc{
	[dataArray removeAllObjects];
	[dataArray release];
	[super dealloc];
}
-(void)fetchObjectsWithNoTypeDataSource:(id)dataSource withQueryString:(NSString*)queryString{
	if ([dataSource isKindOfClass:[NSDictionary class]]) {
		[self fetchObjects:(NSDictionary*)dataSource withQueryString:queryString];
	}else if ([dataSource isKindOfClass:[NSArray class]]) {
		[self fetchObjectsInArray:(NSArray*)dataSource withQueryString:queryString];
	}
}
//加搜尋深度
-(void)fetchObjects:(NSDictionary*)dataDic withQueryString:(NSString *)queryString withDepth:(NSInteger)depth{
    depthIndex=depth;
    [self fetchObjects:dataDic withQueryString:queryString];
}
-(void)fetchObjects:(NSDictionary*)dataDic withQueryString:(NSString*)queryString{
	NSArray *allKeys=[dataDic allKeys];
    depthIndex--;
	for(NSString *key in allKeys){
		id value=[dataDic valueForKey:key];
		if([key isEqualToString:queryString]){
			[dataArray addObject:value];
		}else if([value isKindOfClass:[NSDictionary class]]){
            if(depthIndex<1) continue;
            depthIndex--;
			[self fetchObjects:(NSDictionary*)value withQueryString:queryString];
        }
		else if([value isKindOfClass:[NSArray class]]){
            if(depthIndex<1) continue;
            depthIndex--;
			[self fetchObjectsInArray:(NSArray*)value withQueryString:queryString];
        }
	}
}
-(void)fetchObjectsInArray:(NSArray*)fetchArray withQueryString:(NSString*)queryString{
	for(id e in fetchArray){
		if([e isKindOfClass:[NSDictionary class]])
			[self fetchObjects:(NSDictionary*)e withQueryString:queryString];
	}
}
-(NSString*)searchValue:(NSInteger)index{	
	NSInteger upperBound=[dataArray count]-1;
	if( (index<0) || (index>upperBound) || [dataArray objectAtIndex:index]==[NSNull null]){
		return @"";
    }else {
		id value=[dataArray objectAtIndex:index];
		return ([value isKindOfClass:[NSString class]])?(NSString*)value:[value stringValue];
	}
}										  
@end
