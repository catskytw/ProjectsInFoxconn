//
//  MyFavoriteDirectoryPickerView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteDirectoryPickerView.h"
#import "MyfavoritePListTool.h"
#import "MyFavoriteModel.h"
#import "DirectoryObject.h"
@implementation MyFavoriteDirectoryPickerView
@synthesize selectedString,destId,destLabel;
- (id)initWithFrame:(CGRect)frame withFavoriteType:(NSInteger)type{
	if((self=[super initWithFrame:frame])){
		self.delegate=self;
		myFavoriteType=type;
		pickerArray=[[MyFavoriteModel getFavoriteFolderList:type]retain];
		if([pickerArray count]>0){
			selectedString=((DirectoryObject*)[pickerArray objectAtIndex:0]).folderName;
			destId=((DirectoryObject*)[pickerArray objectAtIndex:0]).folderId;
		}else{
			selectedString=@"";
			destId=@"";
		}
	}
	return self;
}
-(void)dealloc{
	[pickerArray release];
	[super dealloc];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	[destLabel setText:destId];
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [pickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString=((DirectoryObject*)[pickerArray objectAtIndex:row]).folderName;
	return thisResponseString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	selectedString=((DirectoryObject*)[pickerArray objectAtIndex:row]).folderName;
	destId=((DirectoryObject*)[pickerArray objectAtIndex:row]).folderId;
	[destLabel setText:destId];
}

@end
