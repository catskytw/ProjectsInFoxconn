//
//  GoogleMapBaseViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BSForwardGeocoder.h"
#import "POI.h"
@interface GoogleMapBaseViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate,UIActionSheetDelegate,BSForwardGeocoderDelegate,UIAlertViewDelegate>{
	IBOutlet MKMapView *mapView;
	IBOutlet UISearchBar *thisSearchBar;
	CLLocationManager *locationManager;
	CLLocationCoordinate2D rightNowPosition,startPOILocation;
	UIAlertView *alert;
	NSMutableArray *allStopPoint;
	NSString *selectedStationString;
	
	BSForwardGeocoder *forwardGeocoder;
	
	//是否可讓annotation click
	BOOL isAnnotationClick;
	NSInteger thisPoiType;
	BOOL moveFlag;
	POI *nowPOI;
}
@property(nonatomic,retain)MKMapView *mapView;
@property(nonatomic,retain)BSForwardGeocoder *forwardGeocoder;
@property(nonatomic,retain)UISearchBar *thisSearchBar;
@property(nonatomic)CLLocationCoordinate2D startPOILocation;
@property(nonatomic)NSInteger thisPoiType;
-(void)getAllPOIData;
-(IBAction)moveToRightnowPosition:(id)sender;
-(id)initWithAnnotationClickFlag:(BOOL)isClickAnnotation withStartLocation:(CLLocationCoordinate2D)startLocation withType:(NSInteger)thisType;
-(NSString*)getAnnotationImageName:(id<MKAnnotation>)annotation;
-(void)moveToStartPOILocation;
-(void)reloadPOIData;
@end
