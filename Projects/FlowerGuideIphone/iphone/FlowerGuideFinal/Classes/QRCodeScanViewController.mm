//
//  QRCodeScanViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import "MapViewController.h"
#import "AllContentPointProperties.h"

#ifdef QRCODE
#import "QRCodeReader.h"
#endif
@interface QRCodeScanViewController()
@end
@implementation QRCodeScanViewController
@synthesize picView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[systembarTimer invalidate];
	systembarTimer=nil;
	
	[rightBtn setHidden:NO];
	[rightMedBtn setHidden:NO];
	[rightMedBtn setBackgroundImage:[UIImage imageNamed:@"greenbarui_btn_normalmap.png"] forState:UIControlStateNormal];
	[rightMedBtn setBackgroundImage:[UIImage imageNamed:@"greenbarui_btn_normalmap_i.png"] forState:UIControlStateHighlighted];
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
    [super dealloc];
}

-(IBAction)homeAction:(id)sender{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)preAction:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)rightMidBtnAction:(id)sender{
	int position=1;
	AllContentPointProperties *currentAllContent=[AllContentPointProperties current];
	[currentAllContent setScaned:position];
	MapViewController *mapView=[[MapViewController alloc]initWithNowPosition:position];
	mapView.isShowArrow=YES;
	[self.navigationController pushViewController:mapView animated:YES];
	[mapView release];
}

#ifdef QRCODE
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
#ifdef DEBUG_MODE
	//[debugLabel setText:result];
#endif
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
@end
