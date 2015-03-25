//
//  TopControlPanel.m
//  FlowerGuide
//
//  Created by Change Liao on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TopControlPanel.h"
#import "ContentViewController.h"
#import "FlowerAreaGallery.h"
#import "DirectionArrowViewController.h"
#import "Vars.h"
#import "LocalizationSystem.h"
#import "AllContentPointProperties.h"
@implementation TopControlPanel
@synthesize switchBtn,ptNameBtn,ptDescBtn,flowerBtn,forwardBtn,cancelBtn,distanceLabel;
@synthesize directionPointer,isForwardingMode;
@synthesize nowPositionId;
-(id)init{
	if((self=[super init])){
		//預設本panel是開啟
		isOpen=YES;
		isForwardingMode=NO;
	}
	return self;
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
}

- (void)dealloc {
	[switchBtn release];
	[ptNameBtn release];
	[ptDescBtn release];
	[flowerBtn release]; 
	[forwardBtn release]; 
	[cancelBtn release];
	[directionPointer release];
	[distanceLabel release];
	[super dealloc];
}

//變更方向之燈
-(void)changeDirectionPointer:(NSInteger)directionPoint{
	switch(directionPoint){
		default:
		case directionNone:
			[directionPointer setImage:[UIImage imageNamed:@"mapui_ic_looknone.png"]];
			break;
		case directionLeft:
			[directionPointer setImage:[UIImage imageNamed:@"mapui_ic_lookleft.png"]];
			break;
		case directionUp:
			[directionPointer setImage:[UIImage imageNamed:@"mapui_ic_lookfront.png"]];
			break;
		case directionRight:
			[directionPointer setImage:[UIImage imageNamed:@"mapui_ic_lookright.png"]];
			break;
		case directionDown:
			[directionPointer setImage:[UIImage imageNamed:@"mapui_ic_lookback.png"]];
			break;
	}
}

-(void)changeValue:(ExhibitionInfoObject*)dataObject{
	[ptNameBtn setTitle:dataObject.ptName forState:UIControlStateNormal];
	[ptDescBtn setTitle:dataObject.areaName forState:UIControlStateNormal];
	[flowerBtn setEnabled:dataObject.hasFlower];
	tmpDataObject=dataObject;
	[self changeDirectionPointer:dataObject.direction];
}
/********************
 action method
 */

//開關上方panel之按鍵
-(IBAction)switchPanel:(id)sender{
	NSInteger yPosition=self.view.frame.origin.y;
	NSInteger newYPosition=(isOpen)?(yPosition-110):(yPosition+110);

	[UIView beginAnimations:@"TopPanelAnimation" context:nil];
	[UIView setAnimationDuration:0.75];
	[self.view setFrame:CGRectMake(self.view.frame.origin.x, newYPosition, self.view.frame.size.width, self.view.frame.size.height)];
	[UIView commitAnimations];
	NSString *switchBtnString=(isOpen)?@"mapui_btn_tpanel_open":@"mapui_btn_tpanel_close";
	[switchBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",switchBtnString]] forState:UIControlStateNormal];
	[switchBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_i.png",switchBtnString]] forState:UIControlStateHighlighted];
	
	isOpen=!isOpen;
}

-(IBAction)openContentView:(id)sender{
	AllContentPointProperties *tmpPointProperty=[AllContentPointProperties current];
	[tmpPointProperty setPassed:nowPositionId];
	ContentViewController *cvc=[[ContentViewController alloc]initWithAreaId:tmpDataObject.areaId];
	[[self.view superview] addSubview:cvc.view];
}

-(IBAction)openFlowerArea:(id)sender{
	FlowerAreaGallery *fag=[[FlowerAreaGallery alloc]initWithFeatureId:[NSString stringWithFormat:@"%i",nowPositionId]];
	[[self.view superview] addSubview:fag.view];
}
-(IBAction)openFeatureDesc:(id)sender{
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:tmpDataObject.areaName 
												 message:tmpDataObject.ptDesc 
												delegate:self cancelButtonTitle:AMLocalizedString(@"Confirm",nil) otherButtonTitles:nil];
	[alert show];
}
-(IBAction)openTest:(id)sender{
	DirectionArrowViewController *fcc=[DirectionArrowViewController new];
	[[self.view superview] addSubview:fcc.view];
}

-(IBAction)forwardAction:(id)sender{
	[[NSNotificationCenter defaultCenter]postNotificationName:MapForwardWalking object:nil userInfo:nil];
}

-(IBAction)cancelAction:(id)sender{
	[[NSNotificationCenter defaultCenter]postNotificationName:MapCancelWalking object:nil userInfo:nil];
}


-(void)switchContentMode{
	//舊版使用switch方式,新版則是固定  2010.11.04
	/*
	if(isForwardingMode){
		ptDescBtn.hidden=YES;
		distanceLabel.hidden=NO;
		forwardBtn.hidden=NO;
		cancelBtn.hidden=NO;
	}else{
		ptDescBtn.hidden=NO;
		distanceLabel.hidden=YES;
		forwardBtn.hidden=YES;
		cancelBtn.hidden=YES;
	}*/
}

-(void)setButtonEnable{
	ptDescBtn.enabled=YES;
	flowerBtn.enabled=tmpDataObject.hasFlower;
	forwardBtn.enabled=YES;
	ptNameBtn.enabled=YES;
	cancelBtn.enabled=YES;
}

-(void)setButtonDisable{
	ptDescBtn.enabled=NO;
	flowerBtn.enabled=NO;
	forwardBtn.enabled=NO;
	ptNameBtn.enabled=NO;
	cancelBtn.enabled=NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	[actionSheet release];
}

@end
