//
//  SearchBusLineViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchBusLineViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITextField *startStation;
	IBOutlet UITextField *endStation;
	IBOutlet UITableView *searchTable;
	NSMutableArray *contentArray;
}
@property(nonatomic,retain)UITextField *startStation;
@property(nonatomic,retain)UITextField *endStation;
@property(nonatomic,retain)UITableView *searchTable;
-(IBAction)exchangeStation:(id)sender;
-(IBAction)mapViewClick:(id)sender;
@end
