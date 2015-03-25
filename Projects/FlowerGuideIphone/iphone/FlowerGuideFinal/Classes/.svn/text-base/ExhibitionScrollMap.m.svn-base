//
//  ExhibitionScrollMap.m
//  FlowerGuide
//
//  Created by Liao Change on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionScrollMap.h"
#import "AreaInfoObject.h"
#import "CommonDescriptionViewController.h"
#import "GoFutureModel.h"
#import "CommonDescriptionObject.h"
#import "DescriptionObject.h"
#import "ContentObject.h"
#import "CommonContentDescriptionView.h"
#import "Vars.h"
#import "UserInfoButton.h"
@implementation ExhibitionScrollMap
@synthesize myScrollMap,parentNavigationController;

- (void)dealloc {
    [super dealloc];
}
-(IBAction)buttonAction:(id)sender{
	//TODO how to know the areaId?
	UserInfoButton *thisButton=(UserInfoButton*)sender;
	AreaInfoObject *nextViewDataObject=[GoFutureModel getAreaInfo:(NSString*)thisButton.userinfo];
	ContentObject *inputDataObject=[ContentObject new];
	//TODO give right picURL
	inputDataObject.picUrl=(nextViewDataObject.picURL==nil)?nil:[NSString stringWithString:nextViewDataObject.picURL];
	inputDataObject.title=[NSString stringWithString:nextViewDataObject.title];
	inputDataObject.contentArray=[NSArray arrayWithArray:nextViewDataObject.descList];
	
	CommonContentDescriptionView *nextController=[[CommonContentDescriptionView alloc]initWithDataObject:inputDataObject];
	[parentNavigationController pushViewController:nextController animated:YES];
	[nextController release];
	[inputDataObject release];
}
@end
