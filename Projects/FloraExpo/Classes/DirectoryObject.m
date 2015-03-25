//
//  DirectoryObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DirectoryObject.h"


@implementation DirectoryObject
@synthesize folderId,folderName,itemCount;
-(void)dealloc{
	[folderId release];
	[folderName release];
	[itemCount release];
	[super dealloc];
}
@end
