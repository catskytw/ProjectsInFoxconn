//
//  FcMasterViewController.h
//  TestProject_coreData
//
//  Created by Liao Chen-chih on 2011/11/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FcDetailViewController;

#import <CoreData/CoreData.h>

@interface FcMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) FcDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
