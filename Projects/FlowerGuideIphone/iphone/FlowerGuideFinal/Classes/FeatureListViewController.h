//
//  FeatureListViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ContentObject.h"
@interface FeatureListViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>{
	UITableView *contentTable;
	ContentObject *thisDataObject;
}
-(void)tableSetting;
@end
