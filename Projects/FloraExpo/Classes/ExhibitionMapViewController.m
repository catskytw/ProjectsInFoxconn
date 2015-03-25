//
//  ExhibitionMapViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionMapViewController.h"
#import "FloraExpoModel.h"
#import "AreaExhibitionObject.h"
#import "ExhibitionObject.h"
#import "DescriptionContentViewController.h"
#import "Vars.h"
@implementation ExhibitionMapViewController
@synthesize myScrollView;
-(void)viewWillAppear:(BOOL)animated {
	[self.navigationItem setTitle:AMLocalizedString(@"ExhibitionInfo",nil)];
	exhibitionsInArea=nil;
	[myScrollView setBackgroundColor:[UIColor blackColor]];
	[myScrollView setFrame:CGRectMake(0, 0, 320, 371)];
	[myScrollView setContentSize:CGSizeMake(686,430)];
	[super viewWillAppear:animated];
}

-(IBAction)enterExhibitionArea:(id)sender{
	NSMutableArray *allAreaExhibition=[((DescriptionPageDataObject*)[FloraExpoModel getAllAreaExhibitionName]).contentArray retain];
	NSString *title=[NSString stringWithString:((UIButton*)sender).titleLabel.text];
	for(AreaExhibitionObject *thisObject in allAreaExhibition){
		if([thisObject.areaNme compare:title]==NSOrderedSame){
			exhibitionsInArea=[[NSArray arrayWithArray: thisObject.allExhibitionNames]retain];
			break;
		}
	}
	if(exhibitionsInArea!=nil){
		UIActionSheet *exhibitionAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ChooseExhibition",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:nil];
		for(ExhibitionObject *thisExhibitionInArea in exhibitionsInArea){
			[exhibitionAction addButtonWithTitle:thisExhibitionInArea.exhibitionName];
		}
		[exhibitionAction showInView:self.parentViewController.tabBarController.view];
		[exhibitionAction release];
	}

	[allAreaExhibition release];
}
-(void)dealloc{
	if(exhibitionsInArea!=nil)
		[exhibitionsInArea release];
	[super dealloc];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex==0)
		return;
	ExhibitionObject *selectedObject=(ExhibitionObject*)[exhibitionsInArea objectAtIndex:buttonIndex-1];
	DescriptionContentViewController *dcbc=[[DescriptionContentViewController alloc]initWithType:ExhibitionInfo withKey:selectedObject.key];
	//-(id)initWithType:(NSInteger)type withKey:(NSString*)key{
	[self.navigationController pushViewController:dcbc animated:YES];
	[dcbc release];
}

@end
