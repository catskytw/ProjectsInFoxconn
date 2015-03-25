//
//  SecondViewController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/24.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "MemberViewController.h"
#import "FcTabBarItem.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "SignInObject.h"
#import "TUNinePatchCache.h"
#import "LoginView.h"
#import "FcPopWindows.h"
#import "QueryPattern.h"
#import "NinePatch.h"
#import "HistoryOrderListCell.h"
#import "Tools.h"
#import "ChangePasswordViewController.h"
#import "HishtoryOrderDetailView.h"
@interface MemberViewController(PrivateMethod)
//跳出登入畫面
-(void)popLogin;
//填入使用者資料
-(void)fillMemberData;
-(void)loginSuccess:(NSNotification*)notification;
@end

@implementation MemberViewController
@synthesize orderIdLabel;
@synthesize storeLabel;
@synthesize totalLabel;
@synthesize discountLabel;
@synthesize orderDate;
@synthesize statusLabel;
@synthesize titleLabel,titleBackground,background;
@synthesize dataString1,dataString2,dataString3,dataString4,dataString5,dataString6,dataString7,dataString8,dataString9,dataString10,dataString11,dataString12,dataString13;
@synthesize section1Label,section2Label;
@synthesize section2Label1,section2Label2,section2Label3,section2Label4;
@synthesize table,tableTitleBackground;
@synthesize logoutBtn,activeBtn,changePwdBtn;
#pragma mark PrivateMethod
-(void)evenlopSuit{
    [titleBackground setImage:[UIImage imageNamed:@"content_ui_title_bar.png"]];
    [titleLabel setText:AMLocalizedString(@"MemberTitle", nil)];
    [tableTitleBackground setImage:[TUNinePatchCache imageOfSize:CGSizeMake(tableTitleBackground.frame.size.width, tableTitleBackground.frame.size.height) forNinePatchNamed:@"table"]];
    [logoutBtn setBackgroundImage:[TUNinePatchCache imageOfSize:logoutBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [logoutBtn setBackgroundImage:[TUNinePatchCache imageOfSize:logoutBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    
    [activeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:activeBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [activeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:activeBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    
    [changePwdBtn setBackgroundImage:[TUNinePatchCache imageOfSize:changePwdBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [changePwdBtn setBackgroundImage:[TUNinePatchCache imageOfSize:changePwdBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    orderDate.text= AMLocalizedString(@"Member_OrderDate", nil);
    statusLabel.text= AMLocalizedString(@"Member_Status", nil);
    discountLabel.text= AMLocalizedString(@"Member_Discount", nil);
    totalLabel.text= AMLocalizedString(@"Member_Total", nil);
    storeLabel.text= AMLocalizedString(@"Member_Store", nil);
    orderIdLabel.text= AMLocalizedString(@"Member_OrderId", nil);
    [self fillMemberData];
}
-(IBAction)logoutAction:(id)sender{
    if([SignInObject share].isLogin==YES){
        //送出logout API
        QueryPattern *query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
        [query prepareDic:logout()];
        [query release];
        
        [SignInObject SignInRelease];
        [logoutBtn setTitle:AMLocalizedString(@"login", nil) forState:UIControlStateNormal];
        [self fillMemberData];
        [self popLogin];
    }
}
-(IBAction)activeAction:(id)sender{
}
-(IBAction)changePwdAction:(id)sender{
    ChangePasswordViewController *nextController=[ChangePasswordViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController autorelease];
}

-(void)popLogin{
    LoginView *_m=[[LoginView alloc]initWithSuccessNotificationKey:SuccessLogin withFailedNotificationKey:nil withObserver:self];
    popWin=[[FcPopWindows alloc]initWithInnerFrame:_m.view.frame.size withPosition:CGPointMake(175,215) withContentViewController:_m withCloseBtnString:nil isAllowedClose:NO];
    [popWin show:self.view];
    [_m autorelease];
}

-(void)loginSuccess:(NSNotification*)notification{
    [popWin close];
    [self fillMemberData];
    [logoutBtn setTitle:AMLocalizedString(@"logout", nil) forState:UIControlStateNormal];
}
//TODO
-(void)fillMemberData{
    [dataString1 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix1", nil),[SignInObject share].code]];
    [dataString2 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix2", nil),[SignInObject share].name]];
    [dataString3 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix3", nil),[SignInObject share].sex]];
    [dataString4 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix4", nil),[SignInObject share].birthday]];
    [dataString5 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix5", nil),[SignInObject share].phone]];
    [dataString6 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix6", nil),[SignInObject share].mobile]];
    [dataString7 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix7", nil),[SignInObject share].address]];
    [dataString8 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix8", nil),[SignInObject share].email]];
    [dataString9 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix9", nil),[SignInObject share].workIncome]];
    [dataString10 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix10", nil),[SignInObject share].workJob]];
    [dataString11 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix11", nil),[SignInObject share].marryStatus]];
    [dataString12 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix12", nil),[SignInObject share].habit]];
    [dataString13 setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"dataStringPrefix13", nil),[SignInObject share].storeName]];
}
#pragma -
#pragma mark DelegateMethod(Not allowed modify)

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:AMLocalizedString(@"MemberTitle", nil) image:nil tag:2];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_member.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_member_i.png"];
	self.navigationController.tabBarItem=thisBarItem;
	[thisBarItem release];
    self.navigationController.tabBarController.selectedIndex=2;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:SuccessLogin object:self];
    //跳出登入視窗畫面
    if([SignInObject share].isLogin==NO){
        [self popLogin];
    }
    [self evenlopSuit];
    
    //history order
    historyOrderQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [historyOrderQuery prepareDic:orderList()];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
        // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [historyOrderQuery release];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SuccessLogin object:self];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryOrderListCell *thisCell=(HistoryOrderListCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    HishtoryOrderDetailView *contentView=[[HishtoryOrderDetailView alloc] initWithOrderId:thisCell.hiddenOrderId.text];
    CGFloat x=(CGFloat)(768-contentView.view.frame.size.width)/2;
    FcPopWindows *pop=[[FcPopWindows alloc] initWithInnerFrame:contentView.view.frame.size withPosition:CGPointMake(x, 200) withContentViewController:contentView withCloseBtnString:nil isAllowedClose:YES];
    [pop show:self.view];
    [contentView release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [historyOrderQuery getNumberForKey:@"storeName"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    HistoryOrderListCell *cell=(HistoryOrderListCell*)[tableView dequeueReusableCellWithIdentifier:@"HistoryOrderList"];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HistoryOrderListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[HistoryOrderListCell class]]){
                cell=(HistoryOrderListCell*)currentObject;
                break;
            }
        }
    }
    cell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:cell.frame.size forNinePatchNamed:@"choose_bg2"]]autorelease];
    [cell.orderNumber setText:[historyOrderQuery getValue:@"orderNumber" withIndex:row]];
    [cell.hiddenOrderId setText:[historyOrderQuery getValue:@"id" withIndex:row]];
    [cell.orderDate setText:[historyOrderQuery getValue:@"orderDate" withIndex:row]];
    [cell.discount setText: [Tools formatMoneyString:[historyOrderQuery getValue:@"discount" withIndex:row]]];
    [cell.total setText:[Tools formatMoneyString:[historyOrderQuery getValue:@"total" withIndex:row]]];
    [cell.status setText:[historyOrderQuery getValue:@"status" withIndex:row]];
    [cell.storeName setText:[historyOrderQuery getValue:@"storeName" withIndex:row]];
    return cell;
}

- (void)dealloc {
    [super dealloc];
}
#pragma -
@end
