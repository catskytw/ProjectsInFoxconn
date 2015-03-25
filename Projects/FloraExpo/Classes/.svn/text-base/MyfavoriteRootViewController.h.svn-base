//
//  MyfavoriteRootViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIButton.h"

@interface MyfavoriteRootViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
	UIScrollView *myScrollView;
	IBOutlet UITableView *myFavoriteTable;
	IBOutlet UILabel *categoryLabel;
	NSMutableArray *dirArray;
	
	NSInteger thisCategoryQueryType;
	CustomUIButton *lastClickButton;
	BOOL isEdit;
}
@property(nonatomic,retain)UIScrollView *myScrollView;
@property(nonatomic,retain)UITableView *myFavoriteTable;
@property(nonatomic,retain)UILabel *categoryLabel;
@property(nonatomic)NSInteger thisCategoryQueryType;
- (id)initWithCategory:(NSInteger)categoryQueryType;
-(void)reloadTableDic:(NSInteger)queryType;
-(void)scrollViewSettingUp:(NSInteger)categoryType;
@end
