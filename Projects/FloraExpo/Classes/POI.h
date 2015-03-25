//
//  POI.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface POI : NSObject <MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *subTitle;
	NSString *title,*key;
	NSInteger poiType;
	NSString *mainCategoryKey,*subCategoryKey;
}
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSString *title,*key;
@property(nonatomic,retain)NSString *subTitle,*mainCategoryKey,*subCategoryKey;
@property(nonatomic)NSInteger poiType;
-(id)initWithCoords:(CLLocationCoordinate2D)coords withTitle:(NSString*)poiTitle withSubTitle:(NSString*)poiSubTitle;
@end
