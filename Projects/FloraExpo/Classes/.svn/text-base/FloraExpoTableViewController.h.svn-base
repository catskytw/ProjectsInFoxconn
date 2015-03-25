//
//  FloraExpoContent.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloraExpoModel.h"
#import "FloraExpoController.h"

@interface FloraExpoTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *floraExpoTable;
	IBOutlet UIView *marqueeView;
	IBOutlet UILabel *marqueeString;
	FloraExpoController *fec;
	NSInteger thisTableType;
	
	int marqueeXposition;
	NSTimer *thisTimer;
	BOOL isEndMarquee;
}
@property(nonatomic,retain)UITableView*floraExpoTable;
@property(nonatomic,retain)UIView *marqueeView;
@property(nonatomic,retain)UILabel *marqueeString;
-(id)initwithTableType:(NSInteger)tableType;
-(id)initwithTableType:(NSInteger)tableType withKey:(NSString*)key;
-(void)changeMarqueeStringPosition;
@end
