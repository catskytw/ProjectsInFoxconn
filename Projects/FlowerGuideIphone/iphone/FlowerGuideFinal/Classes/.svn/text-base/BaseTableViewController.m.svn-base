//
//  BaseTableViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Vars.h"

@implementation BaseTableViewController
@synthesize thisContentTable;

-(id)init{
	if((self=[super init])){
		thisContentTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 342)];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	thisContentTable.delegate=self;
	thisContentTable.dataSource=self;
	[thisContentTable setBackgroundColor:[UIColor clearColor]];
	[viewPortView addSubview:thisContentTable];
}
-(void)dealloc{
	[thisContentTable release];
	[super dealloc];
}

//must override
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return 0;
}
//mustoverride
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	return nil;
}
//mustoverride
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleMedium;
}
@end
