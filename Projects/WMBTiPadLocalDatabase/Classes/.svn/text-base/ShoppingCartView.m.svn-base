//
//  ShoppingCartView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ShoppingCartView.h"
#import "FcTabBarItem.h"
#import "NinePatch.h"
#import "SignInObject.h"
#import "LocalizationSystem.h"
#import "OrderListPopViewCell.h"
#import "Orders.h"
#import "WMBTWebService.h"
#import "OrderDtlObject.h"
#import "Tools.h"
#import "Configure.h"
#import "StoreNamePickerViewController.h"

#define AFTER_ORDERS_SEND @"AFTER_ORDERS_SEND"
#define TestMemberId 1
@interface ShoppingCartView(PrivateMethod)
-(void)enterEditMode;
-(void)leaveEditMode;
-(void)refreshNumOnTabbar;
-(void)caculateTotalNumPrice;
-(void)afterOrderSend:(NSNotification*)notification;

@end

@implementation ShoppingCartView
@synthesize orderBtn,deleteBtn,storeNameBtn,continuebuyBtn,titlebackground,titleBarBackground,qtyLabel,productNameLabel,naviBarLabel,unitPrice,subTotalLabel,totalLabel,storeLabel;
@synthesize description,totalPrice,totalNum;
@synthesize contentTable;
@synthesize storeName;
-(void)evenlopSuit{
    //設定nine-patch
    [orderBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [orderBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    [continueBuyBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [continueBuyBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    [titleBarBackground setImage:[UIImage imageNamed:@"content_ui_title_bar.png"]];

    [description setText:[NSString stringWithFormat:@"%@%@",[SignInObject share].name,AMLocalizedString(@"Description1", nil)]];
    [deleteBtn setBackgroundImage:[TUNinePatchCache imageOfSize:deleteBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundImage:[TUNinePatchCache imageOfSize:deleteBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    [storeName setText:[SignInObject share].storeName];
    
    qtyLabel.text = AMLocalizedString(@"ShoppingCart_Quantity", nil);
    productNameLabel.text = AMLocalizedString(@"ShoppingCart_ProductName", nil);
    naviBarLabel.text = AMLocalizedString(@"ShoppingCart_Title", nil);
    unitPrice.text = AMLocalizedString(@"ShoppingCart_UnitPrice", nil);
    subTotalLabel.text = AMLocalizedString(@"ShoppingCart_SubTotal", nil); 
    totalLabel.text = AMLocalizedString(@"ShoppingCart_Total", nil);
    storeLabel.text = AMLocalizedString(@"ShoppingCart_Store", nil);
    
    storeName.enabled=NO;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:@"購物車" image:nil tag:2];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_cart.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_cart_i.png"];
	self.tabBarItem=thisBarItem;
    self.tabBarController.selectedIndex=3;
	[thisBarItem release];
    
    _storeNameViewController=[StoreNamePickerViewController new];
    _storeNamePickerPopover=[[UIPopoverController alloc]initWithContentViewController:_storeNameViewController];
    _storeNamePickerPopover.popoverContentSize=_storeNameViewController.view.frame.size;
    [self evenlopSuit];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterOrderSend:) name:AFTER_ORDERS_SEND object:nil];
}
-(IBAction)showPopover:(id)sender{
    UIButton *thisBtn=(UIButton*)sender;
    //[_storeNamePickerPopover presentPopoverFromRect:CGRectMake(thisBtn.frame.origin.x,thisBtn.frame.origin.y+45,thisBtn.frame.size.width,thisBtn.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AFTER_ORDERS_SEND object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)afterOrderSend:(NSNotification*)notification{
    [Tools delWaitCursor];
    NSArray *rDic=(NSArray*)notification.userInfo;
    if([(NSString*)[rDic valueForKey:@"out"] isEqualToString:@"0"]){
        //成功
        [[Orders share]removeAllOrders];
        [contentTable reloadData];
        self.tabBarController.selectedIndex=TabBarIndex_ProductList;
        [self refreshNumOnTabbar];
        UIViewController *topViewController=(UIViewController*)[[UIApplication sharedApplication] delegate];
         [Tools FcMessageWindows:AMLocalizedString(@"OrderSuccessString", nil) withParentView:topViewController.tabBarController.view];
    }else{
        //失敗
         [Tools FcMessageWindows:AMLocalizedString(@"OrderFailure", nil) withParentView:self.view];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"orders num:%i",[[Orders share]getOrdersNum]);
    return [[Orders share]getOrdersNum];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        OrderListPopViewCell *selectedCell=(OrderListPopViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        [[Orders share]removeOrder:selectedCell.productId.text];
        [contentTable reloadData];
        [self refreshNumOnTabbar];
        [self caculateTotalNumPrice];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"OrderListPopViewCell";
    OrderListPopViewCell *cell =(OrderListPopViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"OrderListPopViewCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[OrderListPopViewCell class]]){
                cell=(OrderListPopViewCell*)currentObject;
            }
        }
    }    
    OrderItem *thisOrderItem=[[Orders share]getOrders:[indexPath row]];
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    [cell.productId setText:thisOrderItem.productId];
    [cell.productName setText:thisOrderItem.productName];
    [cell.num setText:[NSString stringWithFormat:@"%i",thisOrderItem.number]];
    cell.num.tag=[indexPath row]; // 借用cell.num.tag來紀錄這是第幾筆
    cell.num.delegate=self;
    [cell.price setText:[Tools formatMoneyString:[NSString stringWithFormat:@"%i",thisOrderItem.price]]];
    [cell.totalPrice setText:[Tools formatMoneyString: [NSString stringWithFormat:@"%i",thisOrderItem.number*thisOrderItem.price]]];
    return cell;
}
- (void)viewWillAppear:(BOOL)animated{
    [contentTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [self refreshNumOnTabbar];
    [self caculateTotalNumPrice];
    [description setText:[NSString stringWithFormat:@"%@%@",[SignInObject share].name,AMLocalizedString(@"Description1", nil)]];
}
-(IBAction)continueShopping:(id)sender{
    NSLog(@"last Type:%i",LASTVIEWPAGETYPE);
    [self.tabBarController setSelectedIndex:LASTVIEWPAGETYPE];
}
-(IBAction)sendOrders:(id)sender{
    if([SignInObject share].isMember){
        [Tools addWaitCursor];
        [[Orders share]flushOrders:AFTER_ORDERS_SEND];
    }
    else{
        [Tools FcMessageWindows:AMLocalizedString(@"EmployeeCantBuy", nil) withParentView:self.view];
    }
}
-(IBAction)deleteAction:(id)sender{
    UIButton *thisBtn=(UIButton*)sender;
    if(isEditable==NO){
        isEditable=YES;
        [thisBtn setTitle:AMLocalizedString(@"OrderDeleteComplete", nil) forState:UIControlStateNormal];
        [self enterEditMode];
    }else{
        isEditable=NO;
        [thisBtn setTitle:AMLocalizedString(@"OrderDelete", nil) forState:UIControlStateNormal];
        [self leaveEditMode];
    }
}

-(void)caculateTotalNumPrice{
    NSInteger _totalNum=0;
    NSInteger _totalPrice=0;
    
    NSInteger totalNumOrders=[[Orders share]getOrdersNum];
    for (NSInteger i=0; i<totalNumOrders; i++) {
        OrderItem *thisOrder=[[Orders share]getOrders:i];
        _totalNum+=thisOrder.number;
        _totalPrice+=(thisOrder.number*thisOrder.price);
    }
    [totalNum setText:[NSString stringWithFormat:@"%i",_totalNum]];
    [totalPrice setText:[Tools formatMoneyString:[NSString stringWithFormat:@"%i",_totalPrice]]];
}
-(void)refreshNumOnTabbar{
    self.tabBarItem.badgeValue=([[Orders share]getOrdersNum]>0)?[NSString stringWithFormat:@"%i",[[Orders share]getOrdersNum]]:nil;
}
-(void)enterEditMode{
    [contentTable setEditing:YES animated:YES];
    //[contentTable beginUpdates];
}

-(void)leaveEditMode{
    //[contentTable endUpdates];
    [contentTable setEditing:NO animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
    NSNumber *num=[formatter numberFromString:textField.text];
    [formatter autorelease];
    if (num==nil) {
        [Tools FcMessageWindows:AMLocalizedString(@"illegalNum", nil) withParentView:self.view];
        return YES;
    }else if([num integerValue]<1){
        [Tools FcMessageWindows:AMLocalizedString(@"lessZero", nil) withParentView:self.view];
        return YES;
    }else
         [textField resignFirstResponder];
    
    NSInteger index=textField.tag;
    OrderItem *selectedOrder=[[Orders share] getOrders:index];
    
    OrderItem *thisOrder=[OrderItem new];
    thisOrder.productId=selectedOrder.productId;
    thisOrder.productName=selectedOrder.productName;
    thisOrder.number=[textField.text intValue];
    thisOrder.price=selectedOrder.price;
    [[Orders share] replaceOrder:thisOrder withIndex:index];
    [thisOrder autorelease];
    
    [contentTable reloadData];
    [self caculateTotalNumPrice];
    return YES;
}
@end
int LASTVIEWPAGETYPE;