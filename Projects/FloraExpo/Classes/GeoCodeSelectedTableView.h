//
//  GeoCodeSelectedTableView.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GeoCodeSelectedTableView : UIAlertView <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *geoCodeSelectedTable;
	MKMapView *parentMapView;
	
	NSMutableArray *contentArray;
	UITableView *geoCodeTable;
	
	NSInteger selectedIndex;
}
@property(nonatomic,retain)UITableView *geoCodeSelectedTable;
@property(nonatomic,retain)NSMutableArray *contentArray;
@property(nonatomic,retain)MKMapView *parentMapView;
-(id)initWithGeoCodeArray:(NSArray*)geoCodeArray;
@end
