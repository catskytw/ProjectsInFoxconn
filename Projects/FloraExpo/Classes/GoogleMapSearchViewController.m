//
//  GoogleMapSearchViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapSearchViewController.h"
#import "MapSearchSettingViewController.h"
#import "GoogleMapRoutePlainViewController.h"
#import "LocalizationSystem.h"
#import "MyLifeDescriptionContentView.h"
#import "Vars.h"
#import "TrafficDataModel.h"
@implementation GoogleMapSearchViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	UIBarButtonItem *settingButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Setting",nil) style:UIBarButtonItemStylePlain target:self action:@selector(settingAction:)];
	[self.navigationItem setRightBarButtonItem:settingButton animated:NO];
	[settingButton release];
}

-(void)settingAction:(id)sender{
	MapSearchSettingViewController *searchView=[MapSearchSettingViewController new];
	[self.navigationController pushViewController:searchView animated:YES];
	[searchView release];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	selectedStationString=[NSString stringWithString:view.annotation.title];
	UIActionSheet *tmpView=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ForThisPOI",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"StartRoutePlan",nil),nil];
	[tmpView showInView:self.parentViewController.tabBarController.view];
	[tmpView release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	GoogleMapRoutePlainViewController *gmpvc;
	NSString *googleMapString;
	DescriptionViewController *parkingDetail;
	
	POI *thisPOI;
	for(POI *tmpPOI in allStopPoint){
		if([tmpPOI.title isEqualToString:selectedStationString]) thisPOI=tmpPOI;
	}
	
	switch (buttonIndex) {
		case 0:
			if(thisPoiType==busQuery ){

				if(thisPOI.poiType!=poiParkType){
					googleMapString=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%f,%f&t=m&z=15",thisPOI.coordinate.latitude,thisPOI.coordinate.longitude];
					[[UIApplication sharedApplication]openURL:[NSURL URLWithString:googleMapString]];
				}
				else{
					parkingDetail=[[DescriptionViewController alloc]initWithDefaultStartY];
					parkingDetail.dataStringArray=[NSMutableArray arrayWithArray:[TrafficDataModel getParkingDetailInfo:selectedStationString]];
					parkingDetail.titleString=[NSString stringWithString:AMLocalizedString(@"DetailInfo",nil)];
					[self.navigationController pushViewController:parkingDetail animated:YES];
					[parkingDetail release];
				}
			}else
				[self showStoreInfoView];
			break;
		case 1:
			//路徑規畫
			gmpvc=[GoogleMapRoutePlainViewController new];
			gmpvc.startPOILocation=startPOILocation;
			
			gmpvc.lat=thisPOI.coordinate.latitude;
			gmpvc.lon=thisPOI.coordinate.longitude;
			gmpvc.endStationString=[NSString stringWithString:selectedStationString];
			[self.navigationController pushViewController:gmpvc animated:YES];
			[gmpvc.mapView setRegion:self.mapView.region animated:YES];
			[gmpvc release];
			break;
		default:
			break;
	}
}

/**
 開啟商家詳細資訊
 */
-(void)showStoreInfoView{
	NSString *storeKey;
	for(POI *thisPOI in allStopPoint){
		if([selectedStationString isEqualToString:thisPOI.title]){
			storeKey=[NSString stringWithString:thisPOI.key];
			break;
		}
	}
	MyLifeDescriptionContentView *descriptionView=[[MyLifeDescriptionContentView alloc]initWithStoreKey:storeKey];
	[self.navigationController pushViewController:descriptionView animated:YES];
	[descriptionView release];
}
@end
