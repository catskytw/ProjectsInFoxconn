//
//  DemoJSONTemplateViewController.m
//  DemoJSONTemplate
//
//  Created by 廖 晨志 on 2010/12/2.
//  Copyright 2010 foxconn. All rights reserved.
//
#define FADE_OUT_RATE2		1.0/100.0
#define FADE_OUT_RATE1		1.0/500.0
#import "DemoJSONTemplateViewController.h"
#import "QueryPattern.h"
@implementation DemoJSONTemplateViewController
@synthesize demoLabel1,demoLabel2,demoLabel3,demoLabel4;
@synthesize demoUIImageView,demoButton;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	hasRunningAnimated=YES;
	preView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	UIImageView *personImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indexui_img_firstimage.png"]];
	[personImage setFrame:CGRectMake(0, 0, 320, 460)];
	[preView addSubview:[personImage autorelease]];
	[self.view addSubview:preView];	
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
			hasRunningAnimated=NO;
		}
	}
	else
	{ 
		// Fade upper layer out (decrease alpha)
		preView.alpha -= (preView.alpha<0.6)?FADE_OUT_RATE2:FADE_OUT_RATE1;
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

-(IBAction)getJSONValue{
	NSArray *uis=[NSArray arrayWithObjects:demoLabel1,
				  demoLabel2,demoLabel3,demoButton,demoLabel4,nil];
	NSArray *indexs=[NSArray arrayWithObjects:[NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:4],
					 [NSNumber numberWithInt:2],nil];
	
	QueryPattern *pattern=[QueryPattern new];
	[pattern prepareDic:@"http://163.29.36.98/FloraQuery/Query.aspx?method=105&ln=1"];
	[pattern valueBindings:uis withKey:@"ExhibitionName" withIndexArray:indexs];
	[pattern release];
}
-(IBAction)getUIImageValue{
	QueryPattern *pattern=[QueryPattern new];
	[pattern getImageData:@"http://163.29.36.103/aspnet/taipeistore2/images/upload/store/8662_store_01.jpg" withUIComponent:demoUIImageView withNotificationName:nil];
	[pattern release];
}
- (void)dealloc {
    [super dealloc];
}

@end
