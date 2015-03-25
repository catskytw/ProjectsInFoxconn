//
//  MyLifeInformationViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyLifeInformationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *myLifeInformationTable;
	
	NSArray *contentArray;
}
@property(nonatomic,retain)UITableView *myLifeInformationTable;
@end
