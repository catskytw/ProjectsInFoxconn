//
//  ParkingAreaList.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParkingAreaList : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
	IBOutlet UISearchBar *parkingSearchBar;
	IBOutlet UITableView *parkingTableView;
	
	NSMutableArray *contentArray;
	NSMutableArray *searchArray;
}
@property(nonatomic,retain) UISearchBar *parkingSearchBar;
@property(nonatomic,retain) UITableView *parkingTableView;
-(void)buildSearchArrayFrom:(NSString*)matchString;
@end
