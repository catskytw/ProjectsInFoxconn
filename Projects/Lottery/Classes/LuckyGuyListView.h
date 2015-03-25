//
//  LuckyGuyListView.h
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"

@interface LuckyGuyListView : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	QueryPattern *currentQuery;
	IBOutlet UITableView *luckyGuyList;
}
@property(nonatomic,retain)QueryPattern *currentQuery;
@property(nonatomic,retain)UITableView *luckyGuyList;
-(IBAction)closeAction:(id)sender;
@end
