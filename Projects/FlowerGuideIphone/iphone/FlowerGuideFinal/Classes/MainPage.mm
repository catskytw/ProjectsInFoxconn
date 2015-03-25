//
//  MainPage.m
//  FlowerGuide
//
//  Created by Change Liao on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#define FADE_OUT_RATE2		1.0/100.0
#define FADE_OUT_RATE1		1.0/500.0
#define DESTINATIONPOINT 14 //最終點id,每次更換圖資時需變動
#import "MyTestController.h"
#import "Vars.h"
#import "MainPage.h"
#import "MapViewController.h"
#import "QRCodeScanViewController.h"
#import "AboutFutureMainPageView.h"
#import "FlowerSearchBaseViewController.h"
#import "GoFutureViewController.h"
#import "AllContentPointProperties.h"
#import "AboutFutureModel.h"
#import "LocalizationSystem.h"
#import "AreaListObject.h"
#ifdef QRCODE
#import "QRCodeReader.h"
#endif
@interface MainPage()
@end
@implementation MainPage
@synthesize thisSearchTextField;
@synthesize areaButton1,areaButton2,areaButton3,areaButton4,areaButton5,areaButton6,areaButton7,areaButton8,areaButton9,areaButton10,areaButton11,areaButton12,areaButton13;
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
	BOOL hasConntected=[ToolsFunction hasConnected];
	NSArray *areaArray=(hasConntected)?[AboutFutureModel getAreaList:@""]:nil; 
		
	areaObjectArray=[[NSMutableArray arrayWithObjects:nil]retain];
	preView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	UIImageView *systemBarImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneui_bg.png"]];
	UIImageView *personImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indexui_img_brandimage.png"]];
	[systemBarImage setFrame:CGRectMake(0, 0, 320, 33)];
	[personImage setFrame:CGRectMake(0, 33, 320, 447)];
	[preView addSubview:[systemBarImage autorelease]];
	[preView addSubview:[personImage autorelease]];
	[self.view addSubview:preView];
	
	disableKeyBoardBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[disableKeyBoardBtn setBackgroundColor:[UIColor clearColor]];
	[disableKeyBoardBtn setFrame:CGRectMake(0, 0, 320, 480)];
	[disableKeyBoardBtn addTarget:self action:@selector(disableKeyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
	if(hasConntected && [areaArray count]>0){
		[areaButton1.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:0]).areaId];
		[areaButton2.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:1]).areaId];
		[areaButton3.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:2]).areaId];
		[areaButton4.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:3]).areaId];
		[areaButton5.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:4]).areaId];
		[areaButton6.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:5]).areaId];
		[areaButton7.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:6]).areaId];
		[areaButton8.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:7]).areaId];
		[areaButton9.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:8]).areaId];
		[areaButton10.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:9]).areaId];
		[areaButton11.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:10]).areaId];
		[areaButton12.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:11]).areaId];
		[areaButton13.titleLabel setText:((AreaListObject*)[areaArray objectAtIndex:12]).areaId];
	}
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	timer=[NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(fadeTimerEvent) userInfo:nil repeats:YES];
#ifdef SHOWMEM
	[ToolsFunction report_memory];
#endif
}

- (void)fadeTimerEvent
{
	if (preView.alpha <= 0)
	{
		// At this point, layer1 is now visible  
		[timer invalidate];
		[preView removeFromSuperview];
		timer = nil;      
	}
	else
	{ 
		// Fade upper layer out (decrease alpha)
		preView.alpha -= (preView.alpha<0.8)?FADE_OUT_RATE2:FADE_OUT_RATE1;
	}
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
	[preView release];
	[thisSearchTextField release];
	[areaObjectArray release];
	[areaButton1 release];
	[areaButton2 release];
	[areaButton3 release];
	[areaButton4 release];
	[areaButton5 release];
	[areaButton6 release];
	[areaButton7 release];
	[areaButton8 release];
	[areaButton9 release];
	[areaButton10 release];
	[areaButton11 release];
	[areaButton12 release];
	[areaButton13 release];
    [super dealloc];
}
/**
 test comment
 */

-(IBAction)areaQueryAction:(id)sender{
	UIButton *thisBtn=(UIButton*)sender;
	
	if([ToolsFunction hasConnected]){
		[areaObjectArray removeAllObjects];
		[areaObjectArray addObjectsFromArray:[AboutFutureModel getAreaList:thisBtn.titleLabel.text]];
		
		UIAlertView *tmpAlertview;
		if([areaObjectArray count]==1){
			AreaListObject *selectedObject=(AreaListObject*)[areaObjectArray objectAtIndex:0];
			int position=selectedObject.exhibitId;
			[self enterMapScene:position];
		}
		else if([areaObjectArray count]>0){
			tmpAlertview=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"SelecteExhibit",nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
			for(AreaListObject *tmpObject in areaObjectArray){
				[tmpAlertview addButtonWithTitle:tmpObject.name];
			}
			[tmpAlertview addButtonWithTitle:AMLocalizedString(@"Cancel",nil)];
			[tmpAlertview show];
			[tmpAlertview release];
		}else{
			tmpAlertview=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Warning",nil) message:AMLocalizedString(@"NoExhibitContent",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
			[tmpAlertview addButtonWithTitle:AMLocalizedString(@"Cancel",nil)];
			[tmpAlertview show];
			[tmpAlertview release];
		}
	}
}
-(IBAction)closeApp:(id)sender{

}
-(IBAction)goFuture:(id)sender{
	GoFutureViewController *fvc=[GoFutureViewController new];
	[self.navigationController pushViewController:fvc animated:YES];
	[fvc release];
}
-(IBAction)qrCodeScane:(id)sender{
	/*
	QRCodeScanViewController *qrScene=[QRCodeScanViewController new];
	[self.navigationController pushViewController:qrScene animated:YES];
	[qrScene release];
	 */
#ifdef QRCODE
	ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
	QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
	NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
	[qrcodeReader release];
	widController.readers = readers;
	[readers release];
	[self presentModalViewController:widController animated:YES];
	[widController release];
#endif
}
-(IBAction)goAboutFuture:(id)sender{
	AboutFutureMainPageView *afpv=[AboutFutureMainPageView new];
	[self.navigationController pushViewController:afpv animated:YES];
	[afpv release];
}

-(IBAction)goFlowerSearch:(id)sender{
	FlowerSearchBaseViewController *fsvc=[FlowerSearchBaseViewController new];
	[self.navigationController pushViewController:fsvc animated:YES];
	[fsvc release];
}

#ifdef QRCODE
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
	NSArray *splitQRString=[result componentsSeparatedByString:@","];
	if([splitQRString count]>=2){
		[self dismissModalViewControllerAnimated:NO];
		int action=[((NSString*)[splitQRString objectAtIndex:0]) intValue];
		int positionId=[((NSString*)[splitQRString objectAtIndex:1]) intValue];
		if([ToolsFunction hasConnected]){
			AllContentPointProperties *currentAllContent=[AllContentPointProperties current];
			[currentAllContent setScaned:positionId];
			MapViewController *mapView=[[MapViewController alloc]initWithNowPosition:positionId];
			mapView.isShowArrow=(action==2)?YES:NO;
			[self.navigationController pushViewController:mapView animated:YES];
			[mapView release];
		}
	}
}
- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
	[self dismissModalViewControllerAnimated:YES];
}
#endif

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	[self.view addSubview:disableKeyBoardBtn];
	return YES;
}
-(void)disableKeyBoardAction:(id)sender{
	[thisSearchTextField resignFirstResponder];
	[disableKeyBoardBtn removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[disableKeyBoardBtn removeFromSuperview];
	[textField resignFirstResponder];
	int position=[textField.text intValue];
	MapViewController *mapView=[[MapViewController alloc]initWithNowPosition:position];
	[self.navigationController pushViewController:mapView animated:YES];
	[mapView release];
	return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex>=[areaObjectArray count]) return;
	AreaListObject *selectedObject=(AreaListObject*)[areaObjectArray objectAtIndex:buttonIndex];
	
	int position=selectedObject.exhibitId;
	[self enterMapScene:position];
}
-(void)enterMapScene:(NSInteger)m_nowPosition{
	MapViewController *mapView=[[MapViewController alloc]initWithNowPosition:m_nowPosition];
	[mapView prepareWalk:m_nowPosition withEndPointFeatureId:DESTINATIONPOINT];
	[mapView startWalking];
	[self.navigationController pushViewController:mapView animated:YES];
	[mapView release];
}
@end