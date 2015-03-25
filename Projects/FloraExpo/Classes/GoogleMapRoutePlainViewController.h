//
//  GoogleMapRoutePlainViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMapBaseViewController.h"
#import "POI.h"
@interface GoogleMapRoutePlainViewController : GoogleMapBaseViewController<UITextFieldDelegate> {
	IBOutlet UITextField *startPointTextField;
	IBOutlet UITextField *endPointTextField;
	NSString *endStationString;
	double lon;
	double lat;
	POI *startPoint;
	POI *targetPoint;
}
@property(nonatomic,retain)UITextField *startPointTextField;
@property(nonatomic,retain)UITextField *endPointTextField;
@property(nonatomic,retain)NSString *endStationString;
@property(nonatomic)double lon,lat;

+(void)StartRoutPlain:(NSString*)destination withThisUINavigationController:(UINavigationController*)thisUINavigationController;
-(void)moveRegionHasAllPoint;
@end
