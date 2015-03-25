//
//  MyLifeMapSearchView.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapSearchViewController.h"

@interface MyLifeMapSearchView : GoogleMapSearchViewController {

}
-(void)runCenterRegion:(CLLocationCoordinate2D)thisCoordinate;
@end
