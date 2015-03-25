//
//  MyLifeDiscountDetailView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeDiscountDetailView.h"
#import "LocalizationSystem.h"

@implementation MyLifeDiscountDetailView
@synthesize dataObject;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DescriptionViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDataObject:(DiscountDetailObject*)thisDataObject{
	if((self=[super initWithDefaultStartY])){
		dataObject=[thisDataObject retain];
		dataStringArray=[[NSMutableArray arrayWithArray:dataObject.descriptionArray]retain];
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if(dataObject.hasDiscount){
		UIButton *disCountBtn=[UIButton buttonWithType:UIButtonTypeCustom];
		[disCountBtn setBackgroundImage:[UIImage imageNamed:@"trafficui_btn_redbar.png"] forState:UIControlStateNormal];
		[disCountBtn setBackgroundImage:[UIImage imageNamed:@"trafficui_btn_redbar_i.png"] forState:UIControlStateHighlighted];
		[disCountBtn setTitle:AMLocalizedString(@"DownloadDiscountTicket",nil) forState:UIControlStateNormal];
		[disCountBtn setFrame:CGRectMake(15, startY+10, 289, 44)];
		[disCountBtn addTarget:self action:@selector(selectedDiscountTicket:) forControlEvents:UIControlEventTouchUpInside];
		[thisScrollView addSubview:disCountBtn];
	}
	[thisScrollView setContentSize:CGSizeMake(320,startY+180)];
	[thisScrollView setContentOffset:CGPointZero];
}

-(void)selectedDiscountTicket:(id)sender{
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DownloadMobileTicket",nil),AMLocalizedString(@"ibonTicket",nil),nil];
	[pickAction showInView:self.view];
}

-(void)dealloc{
	[dataObject release];
	[super dealloc];
}
@end
