//
//  OrderDetailViewController.m
//  WMBT
//
//  Created by link on 2011/6/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "Tools.h"
#import "OrderDetailTableCell.h"
#import "OrderDetailDataObject.h"
@implementation OrderDetailViewController
@synthesize storeLabel;
@synthesize totalNameLabel;
@synthesize discountNameLabel;
@synthesize accountableNameLabel;
@synthesize totalLabel;
@synthesize discountLabel;
@synthesize accountableLabel;
@synthesize orderDetailTable;
@synthesize orderId,orderNumber;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        orderArray = [[NSMutableArray arrayWithObjects:nil]retain];
        cellHeight = 60;
    }
    return self;
}

- (void)dealloc
{
    [storeLabel release];
    [totalNameLabel release];
    [discountNameLabel release];
    [accountableNameLabel release];
    [totalLabel release];
    [discountLabel release];
    [accountableLabel release];
    [orderDetailTable release];
    [orderArray release];
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
    [self setDefaultUI];
    [self loadData];
}


- (void)viewDidUnload
{
    [self setStoreLabel:nil];
    [self setTotalNameLabel:nil];
    [self setDiscountNameLabel:nil];
    [self setAccountableNameLabel:nil];
    [self setTotalLabel:nil];
    [self setDiscountLabel:nil];
    [self setAccountableLabel:nil];
    [self setOrderDetailTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setDefaultUI{
    totalNameLabel.text = AMLocalizedString(@"OrderDetail_Total",nil);
    discountNameLabel.text =AMLocalizedString(@"OrderDetail_Discount",nil);
    accountableNameLabel.text =AMLocalizedString(@"OrderDetail_Accountable",nil);
    self.title = [[NSString alloc] initWithFormat:@"%@ %@",AMLocalizedString(@"OrderDetail_Title",nil), orderNumber];
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getOrderDetailCell:tableView andIndexPath:indexPath];	
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    return cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orderArray count];
}
-(UITableViewCell *)getOrderDetailCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
	
    OrderDetailTableCell *cell = (OrderDetailTableCell*)[tableView dequeueReusableCellWithIdentifier:@"OrderDetailTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    cellHeight = cell.frame.size.height;
    //NSLog(@"key :%@", [[OrderDetailTableCell allKeys] objectAtIndex:indexPath.row]);
    OrderDetailDataObject *cellDO = [[orderArray objectAtIndex:indexPath.row] retain];
    [cell setInfoDO:cellDO];
    [cellDO release];
	return cell;
}
-(void)loadData{
    
#ifdef TEST_ORDERDETAIL_MODE    
    OrderDetailDataObject *do1= [OrderDetailDataObject new];
    do1.orderName=@"Apple MacBook Air 多功能輕薄筆記型電腦";
    do1.orderColor=@"(黑)x1";
    float fprice =19888.0;
    do1.orderPrice = [Tools getMoneyStringF32:fprice];
    [orderArray addObject:do1];
    
    OrderDetailDataObject *do2= [OrderDetailDataObject new];
    do2.orderName=@"Apple MacBook Air 多功能輕薄筆記型電腦";
    do2.orderColor=@"(黑)x1";
    float fprice1 =19888.0;
    do2.orderPrice = [Tools getMoneyStringF32:fprice1];
    [orderArray addObject:do2];
    
    OrderDetailDataObject *do3= [OrderDetailDataObject new];
    do3.orderName=@"Apple MacBook Air 多功能輕薄筆記型電腦";
    do3.orderColor=@"(白)x1";
    float fprice2 =19888.0;
    do3.orderPrice = [Tools getMoneyStringF32:fprice2];
    [orderArray addObject:do3];
    
    OrderDetailDataObject *do4= [OrderDetailDataObject new];
    do4.orderName=@"Apple MacBook Air 多功能輕薄筆記型電腦";
    do4.orderColor=@"(白)x4";
    float fprice3 =19888.0;
    do4.orderPrice = [Tools getMoneyStringF32:fprice3];
    [orderArray addObject:do4];
    
    float fTotal =fprice+fprice1+fprice2+fprice3;
    totalLabel.text = [Tools getMoneyStringF32:fTotal];
    
    float fdiscount = 1000.0;
    discountLabel.text = [Tools getMoneyStringF32:fdiscount];
    
    float fAccount = fTotal -fdiscount;
    accountableLabel.text = [Tools getMoneyStringF32:fAccount]; 
    
    storeLabel.textColor = [UIColor colorWithRed:(float)134/255.0f green:(float)84/255.0f blue:(float)34/255.0f alpha:1];
    
    storeLabel.text = @"上海長寧店";
#endif
    QueryPattern *orderQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
   
	[orderQuery prepareDic:orderInfoQuery(orderId)];

    @try {
        float fdiscount = [[orderQuery getValueUnderNode:@"orderInfo" withKey:@"discount" withIndex:0] floatValue];
        discountLabel.text = [Tools getMoneyStringF32:fdiscount];
        
        float fAccount = [[orderQuery getValueUnderNode:@"orderInfo" withKey:@"total" withIndex:0] floatValue];
        accountableLabel.text = [Tools getMoneyStringF32:fAccount]; 
        
        float ftotal = fdiscount +fAccount;
        totalLabel.text = [Tools getMoneyStringF32:ftotal]; 
        
        storeLabel.textColor = [UIColor colorWithRed:(float)134/255.0f green:(float)84/255.0f blue:(float)34/255.0f alpha:1];
        
        storeLabel.text =[orderQuery getValueUnderNode:@"orderInfo" withKey:@"storeName" withIndex:0];
        int itemsCnt = [orderQuery getNumberUnderNode:@"items" withKey:@"id"];
        for (int i=0; i<itemsCnt; i++) {
            OrderDetailDataObject *orderDo= [OrderDetailDataObject new];
            orderDo.name=[orderQuery getValue:@"productName" withIndex:i];
            orderDo.quantity=[orderQuery getValue:@"quantity" withIndex:i]; 
            
            orderDo.price = [orderQuery getValue:@"price" withIndex:i];
            orderDo.itemId =[orderQuery getValueUnderNode:@"orderInfo" withKey:@"id" withIndex:i withDepth:1];
            orderDo.subTotal = [orderQuery getValue:@"subTotal" withIndex:i];
            [orderArray addObject:orderDo];
        }

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [orderQuery release];
    }
    
    	

}
@end
