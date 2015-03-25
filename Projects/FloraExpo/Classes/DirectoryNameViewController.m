//
//  ModifiedDirectoryNameViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DirectoryNameViewController.h"


@implementation DirectoryNameViewController
@synthesize directoryNameTextField;
@synthesize originKeyString;
/*
initWithDictionary:categoryDic withKeyString:@""
 */
-(id)initWithFavType:(NSInteger)thisQueryType{
	if((self=[super init])){
		queryType=thisQueryType;
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

@end
