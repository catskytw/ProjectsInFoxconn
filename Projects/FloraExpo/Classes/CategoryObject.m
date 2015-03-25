//
//  CategoryObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryObject.h"


@implementation CategoryObject
@synthesize categoryKey;
@synthesize mainCategoryName;
@synthesize subCategoryNames;

-(id)initWithMainCategoryName:(NSString*)mainName withCategoryKey:(NSString*)key withSubCategoryNames:(NSArray*)subNames{
	if((self=[super init])){
		categoryKey=[[NSString stringWithString:key]retain];
		mainCategoryName=[[NSString stringWithString:mainName]retain];
		subCategoryNames=[[NSArray arrayWithArray:subNames]retain];
	}
	return self;
}

-(void)dealloc{
	[categoryKey release];
	[mainCategoryName release];
	[subCategoryNames release];
	[super dealloc];
}
@end
