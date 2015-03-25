//
//  HishtoryOrderDetailView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "HishtoryOrderDetailView.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "HistoryOrderDetailCell.h"
#import "LocalizationSystem.h"
@implementation HishtoryOrderDetailView
@synthesize  orderNum,orderDetail,totalPrice,disctoun,payment;
-(id)initWithOrderId:(NSString*)orderId{
    if(([self init])){
        _orderId=[[NSString stringWithString:orderId]retain];
    }
    return self;
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
    _query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [_query prepareDic:orderDetail(_orderId)];
    // Do any additional setup after loading the view from its nib.
    [orderNum setTextColor:DefaultOrangeColor];
    [orderNum setText:[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"OrderNum", nil),[_query getValue:@"orderNumber" withIndex:0]]];
    
    NSString *total=[_query getValue:@"total" withIndex:0];
    NSString *d=[_query getValue:@"discount" withIndex:0];
    NSInteger pay=[total intValue]+[d intValue];
    [totalPrice setText:[Tools formatMoneyString: total]];
    [discount setText:[Tools formatMoneyString: d]];
    
    [payment setText:[Tools formatMoneyString:[NSString stringWithFormat:@"%i",pay]]];
}

- (void)viewDidUnload
{
    [_query release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
#pragma mark delegateMehod
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num=[_query getNumberUnderNode:@"items" withKey:@"id" withDepth:1];
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    HistoryOrderDetailCell *cell=(HistoryOrderDetailCell*)[tableView dequeueReusableCellWithIdentifier:@"HistoryOrderDetailCell"];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HistoryOrderDetailCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[HistoryOrderDetailCell class]]){
                cell=(HistoryOrderDetailCell*)currentObject;
                break;
            }
        }
        [cell.productName setText:[_query getValueUnderNode:@"items" withKey:@"productName" withIndex:row]];
        [cell.price setText:[Tools formatMoneyString: [_query getValueUnderNode:@"items" withKey:@"price" withIndex:row]]];
        [cell.count setText:[_query getValueUnderNode:@"items" withKey:@"quantity" withIndex:row]];
        [cell.sum setText:[Tools formatMoneyString: [_query getValueUnderNode:@"items" withKey:@"subTotal" withIndex:row]]];
    }
    return cell;
}
#pragma -
@end
