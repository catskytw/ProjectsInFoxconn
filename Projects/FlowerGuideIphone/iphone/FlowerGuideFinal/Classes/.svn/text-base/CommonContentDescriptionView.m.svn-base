//
//  CommonContentDescriptionView.m
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommonContentDescriptionView.h"
#import "CommonDescriptionObject.h"
#import "DescriptionObject.h"
#import "Vars.h"
#import "LocalizationSystem.h"
#import "ToolsFunction.h"
@implementation CommonContentDescriptionView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
    }
    return self;
}
-(id)initWithDataObject:(ContentObject*)dataObject{
	if((self=[super init])){
		BOOL hasPhoto=(dataObject.picUrl!=nil)?YES:NO;
		thisContentViewController=[[CommonDescriptionViewController alloc]initWithTextWidth:290 hasPhoto:hasPhoto];
		thisContentViewController.dataStringArray=[NSMutableArray arrayWithObjects:nil];
		for(CommonDescriptionObject *thisContentObject in dataObject.contentArray){
			DescriptionObject *convertDataTitleObject=[DescriptionObject new];
			convertDataTitleObject.descriptionType=DescriptionTypeSubject;
			convertDataTitleObject.textString=[NSString stringWithString:thisContentObject.subject];
			DescriptionObject *convertDataContentObject=[DescriptionObject new];
			convertDataContentObject.descriptionType=DescriptionTypeContent;
			convertDataContentObject.textString=[NSString stringWithString:thisContentObject.content];
			
			[thisContentViewController.dataStringArray addObject:[convertDataTitleObject autorelease]];
			[thisContentViewController.dataStringArray addObject:[convertDataContentObject autorelease]];
		}
		titleString=[NSString stringWithString: dataObject.title];
		if(hasPhoto==YES){
			thisContentViewController.photoImage=[[[UIImageView alloc]initWithFrame:CGRectMake(28, 23, 260, 180)]autorelease];
			[ToolsFunction getImageFromURL:dataObject.picUrl withTargetUIImageView:thisContentViewController.photoImage];
		}
		[thisContentViewController constructThisPage];
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[rightBtn setHidden:NO];
	[titleLabel setText:titleString];
	[viewPortView addSubview:thisContentViewController.thisScrollView];
}
-(void)dealloc{
	[thisContentViewController release];
	[super dealloc];
}
@end
