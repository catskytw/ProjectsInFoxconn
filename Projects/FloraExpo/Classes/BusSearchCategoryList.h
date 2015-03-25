//
//  BusSearchCategoryList.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusSearchCategoryList : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
	IBOutlet UITableView *thisTableView;
	NSMutableArray *contentData;
	NSMutableArray *searchArray;
	NSString *lineTypeString;
	NSString *thisPageTitle;
	BOOL isDeparture;
}
@property(nonatomic,retain)NSMutableArray *contentData;
-(id)initWithLineType:(NSString*)lineType withTitle:(NSString*)thisTitle;
-(void)buildSearchArrayFrom:(NSString*)matchString;
@end
