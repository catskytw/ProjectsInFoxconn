//
//  RootViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#define FADE_OUT_RATE2		1.0/100.0
#define FADE_OUT_RATE1		1.0/500.0

#import "RootViewController.h"
#import "TrafficTabViewController.h"
#import "FloraExpoRootViewController.h"
#import "Vars.h"
#import "TrafficDataModel.h"
@implementation RootViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	hasRunningAnimated=YES;
	preView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	UIImageView *personImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indexui_img_firstimage.png"]];
	[personImage setFrame:CGRectMake(0, 0, 320, 460)];
	[preView addSubview:[personImage autorelease]];
	[self.view addSubview:preView];
	
	[self.navigationController setNavigationBarHidden:YES];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	timer=[NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(fadeTimerEvent) userInfo:nil repeats:YES];
}
- (void)fadeTimerEvent
{
	if (preView.alpha <= 0)
	{
		if(hasRunningAnimated){
			// At this point, layer1 is now visible  
			[timer invalidate];
			[preView removeFromSuperview];
			timer = nil;      
			LocalizationSetLanguage(@"zh_TW");
			[TrafficDataModel verifyUser];
            [self showAlertMsg];
			hasRunningAnimated=NO;
		}
	}
	else
	{ 
		// Fade upper layer out (decrease alpha)
		preView.alpha -= (preView.alpha<0.6)?FADE_OUT_RATE2:FADE_OUT_RATE1;
	}
}

-(void)showAlertMsg{
    NSString *tmpString=[NSString stringWithString:[TrafficDataModel getAlertMessage]];
    UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:nil message:tmpString delegate:nil cancelButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles: nil];
    
    for(UIView *view in alertMsg.subviews){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *thisLabel=(UILabel*)view;
            thisLabel.textAlignment=UITextAlignmentLeft;
            [thisLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17.0f]];
        }
    }
    [alertMsg show];
    [alertMsg release];
}
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	if(trafficController!=nil)
		[trafficController release];
	if(floraExpoRootController!=nil)
		[floraExpoRootController release];
	if(myLifeController!=nil)
		[myLifeController release];
    [super dealloc];
}

-(IBAction)enterTraffic:(id)sender{
	//singleton
	trafficController=[TrafficTabViewController currentTrafficTabViewcontroller];
	[self.navigationController pushViewController:trafficController animated:YES];
}


-(IBAction)enterFloraExpo:(id)sender{
	floraExpoRootController=[FloraExpoRootViewController currentForaExpoRootView];
	[self.navigationController pushViewController:floraExpoRootController animated:YES];
}

-(IBAction)enterMyLife:(id)sender{
	myLifeController=[MyLifeTabViewController currentMyLifeTabViewcontroller];
	[self.navigationController pushViewController:myLifeController animated:YES];
}
@end

