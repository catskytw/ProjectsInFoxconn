//
//  MyLifeMapNavigationView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeMapNavigationView.h"
#import "MyLifeMapSearchView.h"
#import "Vars.h"
@implementation MyLifeMapNavigationView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UITabBarItem *myBarItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"MapSearch",nil) image:[UIImage imageNamed:@"blackbarui_btn_search.png"] tag:3];
		self.tabBarItem=myBarItem;
		[myBarItem release];
		[self.navigationBar setTintColor:DefaultTintNavigationButtonColor];
		MyLifeMapSearchView *myGoogleMapSearch=[[MyLifeMapSearchView alloc]initWithAnnotationClickFlag:YES withStartLocation:NullPOIPosition withType:govermentQuery];
		[self pushViewController:myGoogleMapSearch animated:YES];
		[myGoogleMapSearch release];
    }
    return self;
}
@end
