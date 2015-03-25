//
//  FlowerInfoBaseViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerInfoBaseViewController.h"
#import "GoFutureModel.h"
#import "ToolsFunction.h"
#import "LocalizationSystem.h"
#import "MapViewController.h"
#import "Vars.h"
@implementation FlowerInfoBaseViewController

-(id)initWithFlowerId:(NSString*)flowerId{
	if((self=[super init])){
		thisDataObject=[[GoFutureModel getFlowerInfo:flowerId]retain];
		flowerInfoView=[[FlowerInfoViewController alloc]initWithScreenWidth:320];
	}
	return self;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetImageStyle:) name:SetImageStyleBig object:nil];
	[viewPortView addSubview:flowerInfoView.view];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[flowerInfoView.titleLabel setText:thisDataObject.flowerName];
	[titleLabel setText:AMLocalizedString(@"FlowerInfo",nil)];
	[ToolsFunction getImageFromURL:thisDataObject.flowerImageURL withTargetUIImageView:flowerInfoView.flowerImage withNotificationString:SetImageStyleBig];
	[flowerInfoView.contentLabel setText:thisDataObject.flowerContent];
	[flowerInfoView.areaTitle setText:thisDataObject.areaName];
	
	CGSize textRectSize=[ToolsFunction getContentTextSize:thisDataObject.flowerContent withWidth:290 withFontSize:16];
	[flowerInfoView.contentLabel setFrame:CGRectMake(flowerInfoView.contentLabel.frame.origin.x, flowerInfoView.contentLabel.frame.origin.y, textRectSize.width, textRectSize.height)];
	[flowerInfoView.mainScrollView setContentSize:CGSizeMake(textRectSize.width,textRectSize.height+70)];
	
	[rightBtn setHidden:NO];
	[rightMedBtn setHidden:NO];
	[rightMedBtn setBackgroundImage:[UIImage imageNamed:@"greenbarui_btn_plantposition.png"] forState:UIControlStateNormal];
	[rightMedBtn setBackgroundImage:[UIImage imageNamed:@"greenbarui_btn_plantposition_i.png"] forState:UIControlStateHighlighted];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[[NSNotificationCenter defaultCenter]removeObserver:self name:SetImageStyleBig object:nil];
}


- (void)dealloc {
	[flowerInfoView release];
	[thisDataObject release];
    [super dealloc];
}

-(IBAction)rightMidBtnAction:(id)sender{
	MapViewController *thisMapController=[[MapViewController alloc]initWithNowPosition:thisDataObject.exhibitPtId];
	[self.navigationController pushViewController:thisMapController animated:YES];
	[thisMapController release];
}
-(void)resetImageStyle:(NSNotification*)notification{
	[flowerInfoView settingTransform];
	[flowerInfoView setFlowerImageLocation];
}
@end
