//
//  ParkingInfoList.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParkingInfoList : UIViewController <UIActionSheetDelegate,UISearchBarDelegate>{
	IBOutlet UITableView *thisTableView;
	IBOutlet UISearchBar *thisSearchBar;
	
	NSMutableArray *contentArray;
	NSMutableArray *searchArray;
	NSIndexPath *selectedIndex;
}
@property(nonatomic,retain)UITableView *thisTableView;
@property(nonatomic,retain)UISearchBar *thisSearchBar;
-(id)initwithParkingName:(NSString*)parkName;
-(void)buildSearchArrayFrom:(NSString*)matchString;
@end
