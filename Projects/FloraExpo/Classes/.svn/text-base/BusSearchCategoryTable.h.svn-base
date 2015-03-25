//
//  BusSearchTable.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusSearchCategoryTable : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
	IBOutlet UITableView *thisTableView;
	NSMutableArray *contentData;
	NSMutableArray *searchArray;
	NSInteger thisCellHeight;
}
@property(nonatomic,retain)UITableView *thisTableView;
-(void)buildSearchArrayFrom:(NSString*)matchString;
@end
