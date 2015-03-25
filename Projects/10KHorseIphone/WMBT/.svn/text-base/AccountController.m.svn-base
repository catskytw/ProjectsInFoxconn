//
//  AccountController.m
//  WMBT
//
//  Created by link on 2011/6/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AccountController.h"
#import "Configure.h"
#import "QueryPattern.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "OrderListTableCell.h"
#import "OrderListCellDataObject.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "Tools.h"
#import "ModifyPasswordController.h"
#import "OrderDetailViewController.h"
#import "CustomTintExtension.h"
#define userInfoCount 18
@implementation AccountController
@synthesize acccountSubButtonView;
@synthesize modifyPwdButton;
@synthesize logoutButton;
@synthesize accountSegment;
@synthesize accountTable;
@synthesize segmentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        userInfoDo = [UserInfoDataObject new];
        userInfoArray = [[NSMutableArray arrayWithObjects:nil]retain];
        orderListArray = [[NSMutableArray arrayWithObjects:nil]retain];
        orderListCellHeight =70;
    }
    return self;
}

- (void)dealloc
{
    [accountSegment release];
    [accountTable release];
    if(userInfoDo)
    {
        [userInfoDo release];
        userInfoDo = nil;
    }
    [userInfoArray release];
    [orderListArray release];
    [modifyPwdButton release];
    [logoutButton release];
    [acccountSubButtonView release];
    [segmentView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadUserInfo];
    [self setUIDefault];
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [self loadUserInfo];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([Tools isPopToRoot])
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [Tools setPopToRoot:NO];
    }
}
- (void)viewDidUnload
{
    [self setAccountSegment:nil];
    [self setAccountTable:nil];
    [self setModifyPwdButton:nil];
    [self setLogoutButton:nil];
    [self setAcccountSubButtonView:nil];
    [self setSegmentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([accountSegment selectedSegmentIndex]==0) {
        return [userInfoArray count];
    }else{
        return [orderListArray count];
    }
        
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([accountSegment selectedSegmentIndex]==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfo"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserInfo"] autorelease];
        }
        cell.textLabel.text = [userInfoArray objectAtIndex:indexPath.row];
        return cell;
    } else{
        return [self getOrderListViewCell:tableView andIndexPath:indexPath];
    }
	
}
-(UITableViewCell *)getOrderListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
	OrderListTableCell *cell = (OrderListTableCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderListTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OrderListTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];

	}
    orderListCellHeight = cell.frame.size.height;
    OrderListCellDataObject *cellDo =(OrderListCellDataObject*)[orderListArray objectAtIndex:indexPath.row];
    [cell setInfoDO:cellDo];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}
#pragma mark -
#pragma mark Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([accountSegment selectedSegmentIndex]==0) {
        return 52;
    } else{
        return orderListCellHeight;
    }
}
#pragma mark -
#pragma mark load data
- (void)loadUserInfo{
	
	QueryPattern *userInfoQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDao= [LoginDataObject sharedInstance];
    if([loginDao.memberType isEqualToString:TYPE_MEMBER]){
        [userInfoQuery prepareDic:getMemberInfoQuery(loginDao.sessionId)];
    }else{
        [userInfoQuery prepareDic:getEmployeeInfoQuery(loginDao.sessionId)];
    }
    @try {
        if([Tools checkQureyResponse:[userInfoQuery getValue:@"response" withIndex:0]]){
            if ([userInfoQuery getNumberForKey:@"name"]>0) {
                userInfoDo.name=[userInfoQuery getValue:@"name" withIndex:0];
                userInfoDo.workIncome=[userInfoQuery getValue:@"workIncome" withIndex:0];
                userInfoDo.birthday=[userInfoQuery getValue:@"birthday" withIndex:0];
                userInfoDo.sex=[userInfoQuery getValue:@"sex" withIndex:0];
                userInfoDo.phone=[userInfoQuery getValue:@"phone" withIndex:0];
                userInfoDo.storeName=[userInfoQuery getValue:@"storeName" withIndex:0];
                userInfoDo.cityName=[userInfoQuery getValue:@"cityName" withIndex:0];
                userInfoDo.sectionName=[userInfoQuery getValue:@"sectionName" withIndex:0];
                userInfoDo.postCode=[userInfoQuery getValue:@"postCode" withIndex:0];
                userInfoDo.provinceName=[userInfoQuery getValue:@"provinceName" withIndex:0];
                userInfoDo.code=[userInfoQuery getValue:@"code" withIndex:0];
                userInfoDo.workJob=[userInfoQuery getValue:@"workJob" withIndex:0];
                userInfoDo.marryStatus=[userInfoQuery getValue:@"marryStatus" withIndex:0];
                userInfoDo.habit=[userInfoQuery getValue:@"habit" withIndex:0];
                userInfoDo.address=[userInfoQuery getValue:@"address" withIndex:0];
                userInfoDo.email=[userInfoQuery getValue:@"email" withIndex:0];
                userInfoDo.name=[userInfoQuery getValue:@"name" withIndex:0];
                userInfoDo.storeId=[userInfoQuery getValue:@"storeId" withIndex:0];
                userInfoDo.mobile=[userInfoQuery getValue:@"mobile" withIndex:0];
                
                NSString *strName = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Name", nil),userInfoDo.name]; 
                [userInfoArray addObject:strName];
                NSString *strworkIncome = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_workIncome", nil),userInfoDo.workIncome]; 
                [userInfoArray addObject:strworkIncome];
                NSString *strBirthday = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_birthday", nil),userInfoDo.birthday]; 
                [userInfoArray addObject:strBirthday];
                
                NSString *strSex = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Sex", nil),userInfoDo.sex]; 
                [userInfoArray addObject:strSex];
                NSString *strPhone = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Phone", nil),userInfoDo.phone]; 
                [userInfoArray addObject:strPhone];
                NSString *strStoreName = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_StoreName", nil),userInfoDo.storeName]; 
                [userInfoArray addObject:strStoreName];
                
                NSString *strCityName = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_CityName", nil),userInfoDo.cityName]; 
                [userInfoArray addObject:strCityName];
                NSString *strSectionName= [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_sectionName", nil),userInfoDo.sectionName]; 
                [userInfoArray addObject:strSectionName];
                NSString *strPostCode = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_postCode", nil),userInfoDo.postCode]; 
                [userInfoArray addObject:strPostCode];
                
                NSString *strProvinceName = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_ProvinceName", nil),userInfoDo.provinceName]; 
                [userInfoArray addObject:strProvinceName];
                //NSString *strCode = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Code", nil),userInfoDo.code]; 
                //[userInfoArray addObject:strCode];
                NSString *strWorkJob = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_WorkJob", nil),userInfoDo.workJob]; 
                [userInfoArray addObject:strWorkJob];
                
                NSString *strMarryStatus= [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_MarryStatus", nil),userInfoDo.marryStatus]; 
                [userInfoArray addObject:strMarryStatus];
                NSString *strHabit= [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Habit", nil),userInfoDo.habit]; 
                [userInfoArray addObject:strHabit];
                NSString *strAddress = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Address", nil),userInfoDo.address]; 
                [userInfoArray addObject:strAddress];
                
                NSString *strEmail = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Email", nil),userInfoDo.email]; 
                [userInfoArray addObject:strEmail];
                //NSString *strStoreId= [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_StoreId", nil),userInfoDo.storeId]; 
                //[userInfoArray addObject:strStoreId];
                NSString *strMobile = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"userInfo_Mobile", nil),userInfoDo.mobile]; 
                [userInfoArray addObject:strMobile];
            }
        }	

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [userInfoQuery release];
    }
	    

}
- (void)loadShoppingList{
    QueryPattern *orderListQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDao= [LoginDataObject sharedInstance];
	[orderListQuery prepareDic:orderListQuery(loginDao.sessionId)];
    @try {
        if ([orderListQuery getNumberForKey:@"id"]>0) {
            for (int i=0; i<[orderListQuery getNumberForKey:@"id"]; i++) {
                //for (int j=0; j<10; j++) { int i=0; 
                OrderListCellDataObject *cellDo = [OrderListCellDataObject new];
                cellDo.orderId =[orderListQuery getValue:@"id" withIndex:i];
                cellDo.orderDate=[orderListQuery getValue:@"orderDate" withIndex:i];
                cellDo.orderDiscount=[orderListQuery getValue:@"discount" withIndex:i];
                cellDo.orderAmount=[orderListQuery getValue:@"total" withIndex:i];
                cellDo.orderNumber=[orderListQuery getValue:@"orderNumber" withIndex:i];
                cellDo.orderStatus=[orderListQuery getValue:@"status" withIndex:i];
                cellDo.orderStore = [orderListQuery getValue:@"storeName" withIndex:i];
                [orderListArray addObject:cellDo];
                [cellDo release];
            }
        }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [orderListQuery release];
    }
        
}
-(void) setUIDefault{
    //self.title = AMLocalizedString(@"account_title", nil);
    self.navigationItem.title = AMLocalizedString(@"account_title", nil);
    [accountSegment setTitle:AMLocalizedString(@"account_userInfo",nil) forSegmentAtIndex:0];
    [accountSegment setTitle:AMLocalizedString(@"account_shopping",nil) forSegmentAtIndex:1];
    [modifyPwdButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [modifyPwdButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];
    [logoutButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(152,45) forNinePatchNamed:@"contentui_btn_commons_push_i"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:AMLocalizedString(@"logout_button",nil) forState:UIControlStateNormal];
    [modifyPwdButton setTitle:AMLocalizedString(@"modifypwd_title",nil) forState:UIControlStateNormal];
    [accountSegment setTag:1 forSegmentAtIndex:0];
    [accountSegment setTag:2 forSegmentAtIndex:1];
    
    [accountSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:1];
    [accountSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:2];
    
    //[accountSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:2];
    [segmentView setBackgroundColor:[UIColor colorWithRed:175/255.0f green:186/255.0f blue:194/255.0f alpha:1]];
}
- (IBAction)segmemtValueChange:(id)sender {
    
    if ([(UISegmentedControl*)sender selectedSegmentIndex]==0) {
        if ([userInfoArray count]==0) {
            [self loadUserInfo];
        }
        acccountSubButtonView.hidden = NO;
        CGRect tvframe = [accountTable frame];
        [accountTable setFrame:CGRectMake(tvframe.origin.x, tvframe.origin.y, tvframe.size.width, tvframe.size.height -50)];
        [accountSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:1];
        [accountSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:2];
        
        //[accountSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:2];
        //[accountSegment setTextColor: [UIColor colorWithRed:10/255.f green:203/255.f blue:226/255.f alpha:1] forTag:2];

    }else
    {
        if ([orderListArray count]==0) {
        [self loadShoppingList];
        }
        acccountSubButtonView.hidden = YES;
        CGRect tvbounds = [accountTable frame];
        //[accountTable setBounds:CGRectMake(tvbounds.origin.x, tvbounds.origin.y+25, tvbounds.size.width, tvbounds.size.height +50)];
        NSLog(@"origin y:%f",tvbounds.origin.y);
        [accountTable setFrame:CGRectMake(tvbounds.origin.x, tvbounds.origin.y, tvbounds.size.width, tvbounds.size.height +50)];
        [accountSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:1];
        [accountSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:2];
        //[accountSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:1];
    }        
    [accountTable reloadData];
}

- (IBAction)logout:(id)sender {
    [(LoginDataObject *)[LoginDataObject sharedInstance] logout];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showLogin" object:nil];
}
- (IBAction)modifyPwd:(id)sender {
    ModifyPasswordController *modifypwdController = [[ModifyPasswordController alloc] init] ;
    [self.navigationController pushViewController:modifypwdController animated:YES];
    [modifypwdController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"didSelectRowAtIndexPath indexPath :%d",indexPath.row);
    if ([accountSegment selectedSegmentIndex]==1)
    {
        OrderDetailViewController *orderDetailController = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
        OrderListCellDataObject *cellDo = (OrderListCellDataObject*)[orderListArray  objectAtIndex:indexPath.row];
        orderDetailController.orderId=cellDo.orderId;
        orderDetailController.orderNumber=cellDo.orderNumber;
        [self.navigationController pushViewController:orderDetailController animated:YES];
        [orderDetailController release];
    }
}
@end
