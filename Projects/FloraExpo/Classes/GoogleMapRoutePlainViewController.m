//
//  GoogleMapRoutePlainViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapRoutePlainViewController.h"
#import "Vars.h"
#import "Tools.h"
#import <MapKit/MapKit.h>
@implementation GoogleMapRoutePlainViewController
@synthesize startPointTextField;
@synthesize endPointTextField;
@synthesize endStationString;
@synthesize lon,lat;

+(void)StartRoutPlain:(NSString*)destination withThisUINavigationController:(UINavigationController*)thisUINavigationController{
	GoogleMapRoutePlainViewController *routePlanView=[GoogleMapRoutePlainViewController new];
	routePlanView.startPOILocation=NullPOIPosition;
	routePlanView.endStationString=[NSString stringWithString:destination];
	[thisUINavigationController pushViewController:routePlanView animated:YES];
	[routePlanView release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		endStationString=nil;
		startPoint=nil;
		targetPoint=nil;
		thisPoiType=noneQuery;
		nowPOI=[POI new];
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"PleaseWait",nil) message:AMLocalizedString(@"SearchPOI",nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    }
    return self;
}
- (void)dealloc {
	if(startPoint!=nil)
		[startPoint release];
	if(targetPoint!=nil)
		[targetPoint release];
    [super dealloc];
}
-(void)viewDidLoad{
	[super viewDidLoad];
	mapView.delegate=nil;
	if(endStationString!=nil)
		[endPointTextField setText:endStationString];
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(routePlainAction:)];
	[self.navigationItem setRightBarButtonItem:searchButton animated:NO];
	[searchButton release];
	
	if(startPOILocation.latitude!=0 && startPOILocation.longitude!=0){
		startPoint=[POI new];
		startPoint.coordinate=startPOILocation;
		startPoint.title=AMLocalizedString(@"nowLocation",nil);
		
		targetPoint=[POI new];
		CLLocationCoordinate2D tmpPoint;
		tmpPoint.latitude=lat;
		tmpPoint.longitude=lon;
		targetPoint.coordinate=tmpPoint;
		targetPoint.title=AMLocalizedString(@"targetLocation",nil);
		[mapView addAnnotation:startPoint];
		[mapView addAnnotation:targetPoint];
		[self moveRegionHasAllPoint];
	}	
}

-(void)moveRegionHasAllPoint{
	
	CLLocationCoordinate2D southWest = targetPoint.coordinate;
	CLLocationCoordinate2D northEast = startPoint.coordinate;
	
	CLLocation *locLog = [[CLLocation alloc] initWithLatitude:southWest.latitude longitude:southWest.longitude];
	CLLocation *locLog1=[[CLLocation alloc] initWithLatitude:southWest.latitude longitude:northEast.longitude];
	CLLocation *locLat = [[CLLocation alloc] initWithLatitude:northEast.latitude longitude:northEast.longitude];
	CLLocation *locLat1 = [[CLLocation alloc] initWithLatitude:southWest.latitude longitude:northEast.longitude];

	// This is a diag distance (if you wanted tighter you could do NE-NW or NE-SE)
	CLLocationDistance meterLog = [locLog distanceFromLocation:locLog1];
	CLLocationDistance meterLat = [locLat distanceFromLocation:locLat1];
	MKCoordinateSpan span=MKCoordinateSpanMake(meterLat / 90000, meterLog / 90000);
	CLLocationCoordinate2D centerCoordinate=CLLocationCoordinate2DMake((southWest.latitude + northEast.latitude) / 2.0f, (southWest.longitude + northEast.longitude) / 2.0f);
	MKCoordinateRegion region=MKCoordinateRegionMake(centerCoordinate, span);
	[mapView setRegion:region animated:YES];
	
	[locLog release];
	[locLog1 release];
	[locLat release];
	[locLat1 release];
}
-(void)moveToStartPOILocation{
	/*
	if(startPOILocation.latitude!=NullPOIPosition.latitude && startPOILocation.longitude!=NullPOIPosition.longitude){
		
		CGFloat latDelta=ABS(startPoint.coordinate.latitude-targetPoint.coordinate.latitude);
		MKCoordinateSpan span=MKCoordinateSpanMake(0.004, 0.004);
		MKCoordinateRegion region=MKCoordinateRegionMake(startPOILocation,span);
		
		[mapView setRegion:region animated:YES];
	}
	 */
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationItem setTitle:AMLocalizedString(@"RoutePlan",nil)];
}

//search button action
-(void)routePlainAction:(id)sender{
	NSString *startString;
	NSString *righNowString=[NSString stringWithFormat:@"%1.6f,%1.6f",rightNowPosition.latitude,rightNowPosition.longitude];
	if([startPointTextField.text isEqualToString:@""])
		startString=[NSString stringWithString:righNowString];
	else
		startString=[NSString stringWithString:startPointTextField.text];
	NSString *targetString=[NSString stringWithFormat:@"%1.6f,%1.6f",lat,lon];
	NSString *googleMapString=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&saddr=%@&daddr=%@&t=m&z=15",righNowString,startString,targetString];
	NSLog(googleMapString);
	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:googleMapString]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}
@end
