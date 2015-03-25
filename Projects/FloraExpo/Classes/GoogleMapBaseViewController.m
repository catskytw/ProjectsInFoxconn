//
//  GoogleMapBaseViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "GoogleMapBaseViewController.h"
#import "TrafficDataModel.h"
#import "POI.h"
#import "Vars.h"
#import "SearchBusLineViewController.h"
#import "GeoCodeSelectedTableView.h"
#import "MyLifeModel.h"
@implementation GoogleMapBaseViewController
@synthesize mapView;
@synthesize forwardGeocoder;
@synthesize thisSearchBar;
@synthesize startPOILocation;
@synthesize thisPoiType;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
-(id)initWithAnnotationClickFlag:(BOOL)isClickAnnotation withStartLocation:(CLLocationCoordinate2D)startLocation withType:(NSInteger)thisType{
	if((self=[super init])){
		forwardGeocoder=nil;
		isAnnotationClick=isClickAnnotation;
		startPOILocation=startLocation;
		nowPOI=[POI new];
		thisPoiType=thisType;
		moveFlag=YES;
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"PleaseWait",nil) message:AMLocalizedString(@"SearchPOI",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	}
	return self;
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
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
	[allStopPoint removeAllObjects];
}


- (void)dealloc {
	[alert release];
	[allStopPoint release];
	[locationManager release];
	[nowPOI release];
	if(forwardGeocoder!=nil)
		[forwardGeocoder release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if(startPOILocation.latitude!=0 && startPOILocation.longitude!=0)
		[self reloadPOIData];
}
-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationItem setTitle:AMLocalizedString(@"MapSearch",nil)];
	allStopPoint=[[NSMutableArray alloc]initWithObjects:nil];
	locationManager=[[CLLocationManager alloc]init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	
	mapView.showsUserLocation=YES;
	mapView.scrollEnabled=YES;
	mapView.zoomEnabled=YES;
	
	[locationManager startUpdatingLocation];
	[locationManager stopUpdatingHeading];
#ifdef DEBUG_MODE
	startPOILocation=TaipeiStationPosition;
#endif
	nowPOI.coordinate=startPOILocation;
	nowPOI.title=AMLocalizedString(@"FailureCoordination",nil);
	[self moveToStartPOILocation];
}

-(void)reloadPOIData{
	//[alert show];
	//清空頁面的annotation
	[mapView removeAnnotations:allStopPoint];
	//清空陣列
	[allStopPoint removeAllObjects];
	//取得所有查詢資料
	[self getAllPOIData];	
}	
-(void)moveToStartPOILocation{
	if(startPOILocation.latitude!=NullPOIPosition.latitude && startPOILocation.longitude!=NullPOIPosition.longitude){
		MKCoordinateSpan span=MKCoordinateSpanMake(0.004, 0.004);
		MKCoordinateRegion region=MKCoordinateRegionMake(startPOILocation,span);
		[mapView setRegion:region animated:YES];
	}
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
#ifdef DEBUG_MODE
	rightNowPosition.latitude=TaipeiStationPosition.latitude;
	rightNowPosition.longitude= TaipeiStationPosition.longitude;
#else
	rightNowPosition.latitude=newLocation.coordinate.latitude;
	rightNowPosition.longitude=newLocation.coordinate.longitude;
#endif
	
	startPOILocation=rightNowPosition;
	if(nowPOI!=nil)
		[mapView removeAnnotation:nowPOI];
		
	nowPOI.coordinate=startPOILocation;
	nowPOI.title=AMLocalizedString(@"nowLocation",nil);
	
	[mapView addAnnotation:nowPOI];
	
	if(alert!=nil){
		[alert dismissWithClickedButtonIndex:0 animated:YES];
	}
	if (moveFlag) {
		[self reloadPOIData];
		[self moveToStartPOILocation];
		moveFlag=NO;
	}
}

-(IBAction)moveToRightnowPosition:(id)sender{
	MKCoordinateSpan span=MKCoordinateSpanMake(0.004, 0.004);
	MKCoordinateRegion region=MKCoordinateRegionMake(rightNowPosition,span);
	[mapView setRegion:region animated:YES];
}
-(void)getAllPOIData{
	MapSettingDataObject *thisQueryObject;
	switch (thisPoiType) {
		case noneQuery:break;
		case busQuery:
		case parkingQuery:
#ifdef DEBUG_MODE
			[allStopPoint addObjectsFromArray:[TrafficDataModel getAllPOIData:busQuery withCentral:TaipeiStationPosition]];
#else
			[allStopPoint addObjectsFromArray:[TrafficDataModel getAllPOIData:busQuery withCentral:rightNowPosition]];
#endif
			break;
		default:
			thisQueryObject=[MyLifeModel getMapSetting];
			NSString *subKey=[NSString string];
			int count=0;
			for(NSString *subCategoryKey in thisQueryObject.settingArray){
				if(count==0)
					subKey=[subKey stringByAppendingFormat:@"%@",subCategoryKey];
				else
					subKey=[subKey stringByAppendingFormat:@",%@",subCategoryKey];
				count++;
			}
			subKey=([subKey isEqualToString:@""])?@"none":subKey;
#ifdef DEBUG_MODE
			[allStopPoint addObjectsFromArray:[MyLifeModel getLifeInfoLocationList:thisQueryObject.distance withLocation:TaipeiStationPosition withMainCategory:@"" withSubCategory:subKey]];
#else
			[allStopPoint addObjectsFromArray:[MyLifeModel getLifeInfoLocationList:thisQueryObject.distance withLocation:rightNowPosition withMainCategory:@"" withSubCategory:subKey]];
#endif
			break;
	}
	for(POI *thisPOI in allStopPoint){
		[mapView addAnnotation:thisPOI];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	MKAnnotationView *newAnnotation=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annontation1"];
	if([annotation isKindOfClass:[POI class]]==YES){
		newAnnotation.image=[UIImage imageNamed:[self getAnnotationImageName:annotation]];
		newAnnotation.canShowCallout=YES;
		POI *examPOIAnnotation=(POI*)annotation;
		if(isAnnotationClick && ![examPOIAnnotation.title isEqualToString:AMLocalizedString(@"nowLocation",nil)]){
			UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			newAnnotation.rightCalloutAccessoryView=button;
		}
	}
	return [newAnnotation autorelease];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	selectedStationString=[NSString stringWithString:view.annotation.title];
	UIActionSheet *tmpView=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ForThisPOI",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"SetStartStation",nil) ,AMLocalizedString(@"SetEndStation",nil) ,nil];
	[tmpView showInView:self.parentViewController.tabBarController.view];
	[tmpView release];
}

//在地點的calloutView按鍵事件
//-(void)checkButtonTapped:(id)sender event:(id)event{
//	UIActionSheet *tmpView=[[UIActionSheet alloc]initWithTitle:@"針對此站點" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"設為起站牌",@"設為終站牌",nil];
//	[tmpView showInView:self.view];
//	[tmpView release];
//}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSMutableArray *totalViewControllers=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
	SearchBusLineViewController *preViewController=(SearchBusLineViewController*)[totalViewControllers objectAtIndex:[totalViewControllers count]-2];
	switch (buttonIndex) {
		case 0:
			[preViewController.startStation setText:selectedStationString];
			break;
		case 1:
			[preViewController.endStation setText:selectedStationString];
			break;
		default:
			break;
	}
	[self.navigationController setViewControllers:totalViewControllers];
	[self.navigationController popViewControllerAnimated:YES];
}
-(NSString*)getAnnotationImageName:(id <MKAnnotation>)annotation{
	POI *targetPOI=(POI*)annotation;
	NSString *picName=nil;
	if (targetPOI.poiType==0) {
		NSInteger mainKey=[targetPOI.mainCategoryKey intValue];
		switch (mainKey) {
			default:
				picName=@"lifeinfoui_mapic_other.png";
				break;
			case 100://goverment
				picName=@"lifeinfoui_mapic_government.png";
				break;
			case 300://finance
				picName=@"lifeinfoui_mapic_banking.png";
				break;			
			case 400://education
				picName=@"lifeinfoui_mapic_education.png";
				break;			
			case 500://enterTainment
				picName=@"lifeinfoui_mapic_hobby.png";
				break;			
			case 600://accommodation
				picName=@"lifeinfoui_mapic_food.png";
				break;			
			case 700://transportation
				picName=@"lifeinfoui_mapic_transit.png";
				break;
		}
	}else {
		switch (targetPOI.poiType) {
			case poiBusType:
				picName=@"trafficui_mapic_bus.png";
				break;
			case poiHighSpeedType:
				picName=@"trafficui_mapic_highspeed.png";
				break;
			case poiParkType:
				picName=@"trafficui_mapic_park.png";
				break;
			case poiTrainType:
				picName=@"trafficui_mapic_train.png";
				break;
			case poiTRTCType:
				picName=@"trafficui_mapic_trtc.png";
				break;
			case poiMainPositionType:
				picName=@"trafficui_mapic_position.png";
				break;
		}	
	}
	return picName;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	
	//TODO 跳出搜尋
	if(forwardGeocoder == nil)
	{
		forwardGeocoder = [[BSForwardGeocoder alloc] initWithDelegate:self];
	}
	
	// Forward geocode!
	NSString *text=searchBar.text;
	[forwardGeocoder findLocation:text];
	[searchBar resignFirstResponder];
}

-(void)forwardGeocoderError:(NSString *)errorMessage
{
	UIAlertView *alertLocal = [[UIAlertView alloc] initWithTitle:@"Error!" 
													message:errorMessage
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles: nil];
	[alertLocal show];
	[alertLocal release];
	
}

-(void)forwardGeocoderFoundLocation
{
	if(forwardGeocoder.status == G_GEO_SUCCESS)
	{
		[self.modalViewController.view setBackgroundColor:[UIColor clearColor]];
		GeoCodeSelectedTableView *geoCodeTable=[[GeoCodeSelectedTableView alloc]initWithGeoCodeArray:forwardGeocoder.results];
		geoCodeTable.parentMapView=mapView;
		[geoCodeTable show];
		[geoCodeTable release];
		
		// Dismiss the keyboard
		[thisSearchBar resignFirstResponder];
	}
	else {
		NSString *message = @"";
		
		switch (forwardGeocoder.status) {
			case G_GEO_BAD_KEY:
				message = @"The API key is invalid.";
				break;
				
			case G_GEO_UNKNOWN_ADDRESS:
				message = [NSString stringWithFormat:@"Could not find %@", forwardGeocoder.searchQuery];
				break;
				
			case G_GEO_TOO_MANY_QUERIES:
				message = @"Too many queries has been made for this API key.";
				break;
				
			case G_GEO_SERVER_ERROR:
				message = @"Server error, please try again.";
				break;
				
				
			default:
				break;
		}
		
		UIAlertView *alertLocal = [[UIAlertView alloc] initWithTitle:AMLocalizedString(@"DetailInfo",nil) 
														message:message
													   delegate:nil 
											  cancelButtonTitle:AMLocalizedString(@"Complete",nil)  
											  otherButtonTitles: nil];
		[alertLocal show];
		[alertLocal release];
	}
}
@end
