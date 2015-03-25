//
//  DirectionArrowViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DirectionArrowViewController.h"
#import "DirectionArrowCaculator.h"
#import "Coordination.h"
#import "MapFeature.h"
#import "MapPoint.h"
#import "UserInfoButton.h"
#import "GoFutureModel.h"
#import "ExhibitPtObject.h"
#import "LocalizationSystem.h"
@implementation DirectionArrowViewController
@synthesize mainView;
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
	//TEST CODE
	[self drawDirectionArrow:CGRectMake(0, 0, 2000, 2000) withStandingPosition:CGPointMake(1000,1000)];
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
	[arrowContentArray release];
    [super dealloc];
}

-(void)drawDirectionArrow:(CGRect)rangRect withStandingPosition:(CGPoint)standPoint{
	//label貼在箭頭時,向下調整值
	//加入各個不同方向之key,object,由正北,每45度為一類
	DirectionArrowCaculator *caculator=[[DirectionArrowCaculator alloc]initWithRadius:110];
	arrowContentArray=[[caculator searchFeaturePointInArea:rangRect withStandingPoint:standPoint]retain];
	
	NSArray *allKeys=[arrowContentArray allKeys];
	
	for(NSString *key in allKeys){
		NSMutableArray *facilityForThisKey=[arrowContentArray valueForKey:key];
		UserInfoButton *arrowSprite=[UserInfoButton buttonWithType:UIButtonTypeCustom];
		
		if([facilityForThisKey count]>0)
			([facilityForThisKey count]>1)?[arrowSprite setBackgroundImage:[UIImage imageNamed:@"mapui_icon_facility_arrows.png"] forState:UIControlStateNormal]:[arrowSprite setBackgroundImage:[UIImage imageNamed:@"mapui_icon_facility_arrow_01.png"] forState:UIControlStateNormal];
		else
			continue;
		if([facilityForThisKey count]==1){
			//該物件資料
			MapFeature *thisFeature=(MapFeature*)[facilityForThisKey objectAtIndex:0];
			MapPoint *thisFeatureStyleObject=(MapPoint*)thisFeature.styleObject;
			UILabel *thisArrowLabel=[[[UILabel alloc]initWithFrame:CGRectMake(33-8, 10, 66, 85)]autorelease];
			[thisArrowLabel setNumberOfLines:3];
			[thisArrowLabel setTextColor:[UIColor whiteColor]];
			[thisArrowLabel setBackgroundColor:[UIColor clearColor]];
			[thisArrowLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
			/**
			 bitmapID
			 0:內容點
			 1:出入口
			 2:服務處
			 3:廁所
			 */
			switch (thisFeatureStyleObject.bmpId) {
				case 1:
					[thisArrowLabel setText:@"出\n入\n口"];
					break;
				case 2:
					[thisArrowLabel setText:@"服\n務\n處"];
					break;
				case 3:
					[thisArrowLabel setText:@"廁\n所"];
					break;
				default:
					break;
			}
			[arrowSprite addSubview:thisArrowLabel];
		}
		arrowSprite.userinfo=[NSMutableArray arrayWithArray:facilityForThisKey];
		//if([facilityForThisKey count]>1)
		//	NSLog(@"");
		Coordination *thisLocation=(Coordination*)[caculator.directionArrowPoint objectAtIndex:[key intValue]];
		//NSLog(@"width,height:%i,%i",arrowSprite.frame.size.width,arrowSprite.frame.size.height);
		[arrowSprite setFrame:CGRectMake(160+thisLocation.x, 191+thisLocation.y, 66, 85)];
		[arrowSprite setCenter:CGPointMake(160+thisLocation.x, 191+thisLocation.y)];
		arrowSprite.transform=CGAffineTransformMakeRotation([key intValue]*(M_PI/4));
		[arrowSprite addTarget:self action:@selector(pressArrow:) forControlEvents:UIControlEventTouchUpInside];
		[mainView addSubview:arrowSprite];
	}
	[caculator release];
}
-(IBAction)closeThisView:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}

-(IBAction)pressArrow:(id)sender{
	int count=0;
	NSMutableArray *nameArray=[NSMutableArray array];
	NSMutableString *showString=[NSMutableString string];
	UserInfoButton *thisButton=(UserInfoButton*)sender;
	NSArray *facilityArray=[GoFutureModel getExhibitPtFacilityList];
	for(MapFeature *thisMapFeature in thisButton.userinfo){
		for(ExhibitPtObject *thisObject in facilityArray){
			if(thisMapFeature.featureId==[thisObject.exhibitPtId intValue]){
				[nameArray addObject:thisObject.exhibitPtName];
			}
		}
	}
	
	for(NSString *name in nameArray){
		if(count==0)
			[showString appendFormat:@"%@",name];
		else
			[showString appendFormat:@",%@",name];
		count++;
	}
	
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"FacilityTitle",nil) message:showString delegate:nil cancelButtonTitle:AMLocalizedString(@"Confirm",nil) otherButtonTitles:nil];
	[alert show];
	[alert release];
}
@end
