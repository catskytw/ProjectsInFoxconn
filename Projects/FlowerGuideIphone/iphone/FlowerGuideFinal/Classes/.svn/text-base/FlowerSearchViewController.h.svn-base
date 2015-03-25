//
//  FlowerSearchViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FlowerSearchViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *thisContentTable;
	IBOutlet UITextField *thisSearchTextField;
	IBOutlet UIButton *searchBtn;
	
	IBOutlet UIImageView *titleIcon;
	IBOutlet UILabel *subTitleLabel,*noDataLabel;;
	NSArray *dataArray;
	
	UINavigationController *parentNavigationController;
	UIButton *disableKeyBoardBtn;
}
@property(nonatomic,retain)UITableView *thisContentTable;
@property(nonatomic,retain)UITextField *thisSearchTextField;
@property(nonatomic,retain)UIButton *searchBtn;
@property(nonatomic,retain)UIImageView *titleIcon;
@property(nonatomic,retain)UILabel *subTitleLabel,*noDataLabel;
@property(nonatomic,retain)UINavigationController *parentNavigationController;
-(IBAction)searchFlowerAction:(id)sender;
-(id)initWithAreaList;
@end
