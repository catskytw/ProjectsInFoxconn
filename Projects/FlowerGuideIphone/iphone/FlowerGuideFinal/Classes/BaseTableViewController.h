//
//  BaseTableViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource> {
	UITableView *thisContentTable;
}
@property(nonatomic,retain)UITableView *thisContentTable;
@end
