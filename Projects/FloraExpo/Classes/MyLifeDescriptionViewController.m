//
//  MyLifeDescriptionViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeDescriptionViewController.h"
#import "MyLifeDiscountDetailView.h"
#import "DescriptionObject.h"
#import "DiscountDetailObject.h"
#import "MyLifeModel.h"
#import "Vars.h"
@implementation MyLifeDescriptionViewController
@synthesize parentViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DescriptionViewController" bundle:nibBundleOrNil]) {
    }
    return self;
}
-(id)initWithDataObject:(MyLifeDescriptionObject*)dataObject{
	if((self=[super initWithDefaultStartY])){
		startY=0;
		//TODO storeKey
		[self addDataArray:dataObject];
		//discountObject=[dataObject retain];
		thisScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 289)];
		thisScrollView.backgroundColor=[UIColor clearColor];
		[self constructThisPage];
		/*
		if([dataObject.discountKey intValue]!=-1){
			UIButton *promoteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
			[promoteBtn setBackgroundImage:[UIImage imageNamed:@"trafficui_btn_redbar.png"] forState:UIControlStateNormal];
			[promoteBtn setBackgroundImage:[UIImage imageNamed:@"trafficui_btn_redbar_i.png"] forState:UIControlStateHighlighted];
			[promoteBtn setTitle:AMLocalizedString(@"StorePromote",nil) forState:UIControlStateNormal];
			[promoteBtn setFrame:CGRectMake(15, startY+10, 289, 44)];
			[promoteBtn addTarget:self action:@selector(promoteAction:) forControlEvents:UIControlEventTouchUpInside];
			[thisScrollView addSubview:promoteBtn];
		}
		 */
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//加入一個按鍵,並延長scrollView的高度
}
-(void)addDataArray:(MyLifeDescriptionObject*)dataObject{
	NSArray *contentArray=[NSArray arrayWithObjects:
//						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Introdution",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeWebView withText:dataObject.introduction]autorelease],						   
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Telephone",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText: dataObject.telephone]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Address",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:dataObject.address]autorelease],
/*						   
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Fax",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:dataObject.fax]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Web",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText: dataObject.web]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"OpenTime",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:[NSString stringWithFormat:@"%@~%@",dataObject.hour_open,dataObject.hour_close]]autorelease],						   
						   
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Payment",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(dataObject.payment==0)?AMLocalizedString(@"NO",nil):AMLocalizedString(@"YES",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Parking",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText: (dataObject.parking==0)?AMLocalizedString(@"NO",nil):AMLocalizedString(@"YES",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Indoor_navi",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(dataObject.indoor_navi==0)?AMLocalizedString(@"NO",nil):AMLocalizedString(@"YES",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Pet_allow",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(dataObject.pet_allow==0)?AMLocalizedString(@"NO",nil):AMLocalizedString(@"YES",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:AMLocalizedString(@"Wifi",nil)]autorelease],
						   [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(dataObject.wifi==0)?AMLocalizedString(@"NO",nil):AMLocalizedString(@"YES",nil)]autorelease],
*/
						   nil];
	dataStringArray=[[NSArray arrayWithArray:contentArray]retain];
}

-(UIWebView*)getWebView:(NSString*)stringText{	
	UIWebView *thisWebView;
	if([stringText isEqualToString:@""]||stringText==nil){
		thisWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,0)];
	}else{
		thisWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,289)];
		[thisWebView loadHTMLString:stringText baseURL:nil];
		thisWebView.backgroundColor=[UIColor clearColor];
		[thisWebView setOpaque:NO];
	}
	[thisWebView setTag:DescriptionTypeWebView];
	return [thisWebView autorelease];
}
-(void)promoteAction:(id)sender{
	/*
	DiscountDetailObject *tmpDataObject=[MyLifeModel getDicountDetailInfo:discountObject.discountKey];
	MyLifeDiscountDetailView *myDetail=[[MyLifeDiscountDetailView alloc]initWithDataObject:tmpDataObject];		
	[parentViewController.navigationController pushViewController:myDetail animated:YES];
	[myDetail release];
	 */
}


-(void)dealloc{
	//[discountObject release];
	[thisScrollView release];
	[super dealloc];
}
@end
