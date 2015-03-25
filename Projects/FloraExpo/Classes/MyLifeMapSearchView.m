//
//  MyLifeMapSearchView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeMapSearchView.h"
#import "MyLifeMapSettingView.h"
@implementation MyLifeMapSearchView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"GoogleMapSearchViewController" bundle:nibBundleOrNil]) {
		
    }
    return self;
}
-(void)settingAction:(id)sender{
	MyLifeMapSettingView *searchView=[MyLifeMapSettingView new];
	[self.navigationController pushViewController:searchView animated:YES];
	[searchView release];
}
-(void)runCenterRegion:(CLLocationCoordinate2D)thisCoordinate{
	startPOILocation=thisCoordinate;
}
@end
