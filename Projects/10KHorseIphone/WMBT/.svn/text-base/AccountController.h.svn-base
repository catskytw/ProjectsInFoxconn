//
//  AccountController.h
//  WMBT
//
//  Created by link on 2011/6/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDataObject.h"

@interface AccountController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    UISegmentedControl *accountSegment;
    UITableView *accountTable;
    UIView *segmentView;
    UserInfoDataObject *userInfoDo;
    NSMutableArray *userInfoArray;
    NSMutableArray *orderListArray;
    CGFloat orderListCellHeight;
    UIButton *modifyPwdButton;
    UIButton *logoutButton;
    UIView *acccountSubButtonView;
}
@property (nonatomic, retain) IBOutlet UIView *acccountSubButtonView;
@property (nonatomic, retain) IBOutlet UIButton *modifyPwdButton;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;
- (IBAction)modifyPwd:(id)sender;
@property (nonatomic, retain) IBOutlet UISegmentedControl *accountSegment;
@property (nonatomic, retain) IBOutlet UITableView *accountTable;
@property (nonatomic, retain) IBOutlet UIView *segmentView;
- (IBAction)segmemtValueChange:(id)sender;
- (IBAction)logout:(id)sender;
- (void)loadShoppingList;
-(void) setUIDefault;
- (void)loadUserInfo;
-(UITableViewCell *)getOrderListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
@end
