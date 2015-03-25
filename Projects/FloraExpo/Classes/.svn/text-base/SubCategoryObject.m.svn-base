//
//  SubCategoryObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SubCategoryObject.h"


@implementation SubCategoryObject
@synthesize key;
@synthesize isSelected;
@synthesize subCategoryName;

-(id)initWithSubCategoryName:(NSString*)name isSelected:(BOOL)selectedFlag{
	if((self=[super init])){
		isSelected=selectedFlag;
		subCategoryName=[NSString stringWithString:name];
	}
	return self;
}

-(void)dealloc{
	[key release];
	[subCategoryName release];
	[super dealloc];
}
@end
