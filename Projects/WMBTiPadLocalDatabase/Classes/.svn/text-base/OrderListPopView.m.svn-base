//
//  OrderListPopView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/24.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "OrderListPopView.h"
#import "TUNinePatchCache.h"
#import "SignInObject.h"
#import "LocalizationSystem.h"
@interface OrderListPopView(PrivateMethod)
-(void)evenlopSuit;
-(void)loadData;
@end

@implementation OrderListPopView
@synthesize productName;
@synthesize quantityLabel;
@synthesize unitPriceLabel;
@synthesize subTotalLabel;
@synthesize totalQtyLabel;
@synthesize totalAmtLabel;
@synthesize discountLabel;
@synthesize accountableLabel;
@synthesize productNum,totalPrice,discount,payment;
@synthesize orderBtn,continueBuyBtn;
@synthesize contentTable;
@synthesize description;
@synthesize titlebackground;
#pragma mark PrivateMethod
-(void)evenlopSuit{
    //設定nine-patch
    [orderBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [orderBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    [continueBuyBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [continueBuyBtn setBackgroundImage:[TUNinePatchCache imageOfSize:orderBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    [description setText:[NSString stringWithFormat:@"%@%@",[SignInObject share].name,AMLocalizedString(@"Description1", nil)]];
    [titlebackground setImage:[TUNinePatchCache imageOfSize:titlebackground.frame.size forNinePatchNamed:@"table"]];
    productName.text = AMLocalizedString(@"OrderList_PrdouctName", nil);
    quantityLabel.text = AMLocalizedString(@"OrderList_Quantity", nil);
    unitPriceLabel.text = AMLocalizedString(@"OrderList_UnitPrice", nil);
    subTotalLabel.text = AMLocalizedString(@"OrderList_SubTotal", nil);
    totalQtyLabel.text = AMLocalizedString(@"OrderList_TotalQty", nil);
    totalAmtLabel.text = AMLocalizedString(@"OrderList_totalAmt", nil);
    discountLabel.text = AMLocalizedString(@"OrderList_Discount", nil);
    accountableLabel.text = AMLocalizedString(@"OrderList_Accountable", nil);
}
-(void)loadData{
    //TODO load Order Data
}
#pragma -
#pragma mark ActionMethod
-(IBAction)continueBuying:(id)sender{
    [self.view removeFromSuperview];
}
-(IBAction)orderAction:(id)sender{
    [self.view removeFromSuperview];
}
#pragma -
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
}

- (void)viewDidUnload
{
        [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
