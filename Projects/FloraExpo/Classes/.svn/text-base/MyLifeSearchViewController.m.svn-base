//
//  MyLifeSearchViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeSearchViewController.h"
#import "AreaPicker.h"
#import "CategoryPicker.h"
#import "MyLifeSearchResultTableView.h"
#import "LocalizationSystem.h"
@implementation MyLifeSearchViewController
@synthesize mainKey;
@synthesize subKey;
@synthesize districtKey;
@synthesize category;
@synthesize area;
-(id)init{
	if((self=[super init])){
		mainKey=[[NSString stringWithString:@""]retain];
		subKey=[[NSString stringWithString:@""]retain];
		districtKey=[[NSString stringWithString:@""]retain];
		alert=nil;
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationItem setTitle: AMLocalizedString(@"LifeDatabase",nil)];
	
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];
}
-(void)searchAction:(id)sender{
	NSArray *split=[category.placeholder componentsSeparatedByString:@","];
	
	MyLifeSearchResultTableView *mt=[[MyLifeSearchResultTableView alloc]initWithMainKey:(NSString*)[split objectAtIndex:0] withSubKey:(NSString*)[split objectAtIndex:1] withDistrictKey:area.placeholder];
	[self.navigationController pushViewController:mt animated:YES];
	[mt release];
	if(alert!=nil){
		[alert dismissWithClickedButtonIndex:0 animated:YES];
		[alert release];
		alert=nil;
	}
	
}
- (void)dealloc {
	[mainKey release];
	[subKey release];
	[districtKey release];
    [super dealloc];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return NO;
}

//以區域來選擇
-(IBAction)selectArea:(id)sender{
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
	AreaPicker *pickerView=
	[[AreaPicker alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withTargetTextField:(UITextField*)sender];
	pickerView.showsSelectionIndicator=YES;
	
	[pickAction addSubview:pickerView];
	[pickAction showInView:self.view];
	[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
	[pickerView release];
	[pickAction release];
}

//以分類來選擇
-(IBAction)selectCategory:(id)sender{
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
	CategoryPicker *pickerView=
	[[CategoryPicker alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withTargetTextField:(UITextField*)sender];
	pickerView.showsSelectionIndicator=YES;
	
	[pickAction addSubview:pickerView];
	[pickAction showInView:self.view];
	[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
	[pickerView release];
	[pickAction release];
}
@end
