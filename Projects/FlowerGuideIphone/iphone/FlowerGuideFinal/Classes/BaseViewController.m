//
//  BaseViewController.m
//  FlowerGuide
//
//  Created by Change Liao on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "ToolsFunction.h"
#import "Vars.h"
@implementation BaseViewController
@synthesize rightBtn,rightMedBtn,medBtn,leftMedBtn,leftBtn,viewPortView,greenBarView,systemBarView,titleLabel,rightUpBtn,timeLabel,batteryImage;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[systembarTimer invalidate];
	systembarTimer=nil;
}
-(void)viewWillAppear:(BOOL)animated{
	[self baseViewControllerSetting];
}
-(void)baseViewControllerSetting{
	[[UIDevice currentDevice]setBatteryMonitoringEnabled:YES];
	[self updateSystemInfo];
	systembarTimer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateSystemInfo) userInfo:nil repeats:YES];
	[rightBtn setHidden:YES];
	[rightMedBtn setHidden:YES];
	[medBtn setHidden:YES];
	[leftMedBtn setHidden:YES];
	[leftBtn setHidden:NO];
	[rightUpBtn setHidden:YES];
	[batteryImage setHidden:NO];
}
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



-(IBAction)leftBtnAction:(id)sender{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)rightBtnAction:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)leftMidBtnAction:(id)sender{
}
-(IBAction)rightMidBtnAction:(id)sender{
}
-(IBAction)MidBtnAction:(id)sender{
}
-(IBAction)rightUpBtnAction:(id)sender{
}

-(void)updateSystemInfo{
	NSDate *now=[NSDate date];
	NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"HH:mm"];
	float batteryLevel=[[UIDevice currentDevice]batteryLevel];
	
	if(batteryLevel<0.05){
		[batteryImage setImage:[UIImage imageNamed:@"phoneui_icon_battery0.png"]];
	}else{
		int batteryIndex=ceil(batteryLevel*10);
		[batteryImage setImage:[ToolsFunction getBatteryImage:batteryIndex]];
	}
	[timeLabel setText:[formatter stringFromDate:now]];
	[formatter release];
}
@end
