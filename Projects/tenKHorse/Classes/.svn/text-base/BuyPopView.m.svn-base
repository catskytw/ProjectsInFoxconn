//
//  BuyPopView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/24.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "BuyPopView.h"
#import "Tools.h"
#import "SignInObject.h"
#import "LocalizationSystem.h"
#import "LoginView.h"
#import "Configure.h"
#import "Orders.h"
#import "OrderItem.h"
@interface BuyPopView (PrivateMethod)
-(void)evenlopSuit;
-(void)loadData;
@end

@implementation BuyPopView
@synthesize quantityLabel;
@synthesize nameLabel,shoppingLabel,shoppingPostLabel,num,contentView;

-(id)initWithProductId:(NSString*)pId withProductName:(NSString*)pName withProductPrice:(NSInteger)pPrice withParentView:(UIView*)parentUIView{
    if((self=[super init])){
        productId=[[NSString stringWithString:pId]retain];
        productName=[[NSString stringWithString:pName]retain];
        productPrice=pPrice;
        parentview=parentUIView;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(succssLogin:) name:SuccessLogin object:self];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelLogin:) name:FailureLogin object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SuccessLogin object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:FailureLogin object:self];
    [productName release];
    [productId release];
    [quantityLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma makr - PrivateMethod
-(void)loadData{
    
}
-(void)evenlopSuit{
    NSString *name=[SignInObject share]->name;
    [nameLabel setText:[NSString stringWithFormat:@"%@%@",name,AMLocalizedString(@"NamePostfix", nil)]];
    //tune the layout
    /*
    CGSize shoppingStringSize=[Tools estimateStringSize:productName withFontSize:16.0f];
    [shoppingLabel setText:productName];
    [shoppingLabel setFrame:CGRectMake(shoppingLabel.frame.origin.x, shoppingLabel.frame.origin.y, shoppingStringSize.width, shoppingStringSize.height)];
    [shoppingPostLabel setFrame:CGRectMake(shoppingLabel.frame.origin.x + shoppingLabel.frame.size.width, shoppingPostLabel.frame.origin.y, shoppingPostLabel.frame.size.width, shoppingPostLabel.frame.size.height)];
     */
    contentView.backgroundColor=[UIColor clearColor];
    contentView.opaque=NO;
    [contentView loadHTMLString:
     [NSString stringWithFormat:@"<body style=\"background-color:transparent\"><center>%@<font color=\"#8B4513\">%@</font>%@</center>",AMLocalizedString(@"preString", nil),productName,AMLocalizedString(@"postString", nil)] baseURL:nil];
    quantityLabel.text =AMLocalizedString(@"BuyPop_Quantity", nil);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if([textField.text intValue]<=0) return YES;
    
    BOOL isAdded=NO;
    NSInteger totalOrdersNum=[[Orders share] getOrdersNum];
                   
    for(int i=0;i<totalOrdersNum;i++){
        OrderItem *_myItem=(OrderItem*)[[Orders share]getOrders:i];
        if([_myItem.productId isEqualToString:productId]){
            _myItem.number+=[textField.text intValue];
            isAdded=YES;
            break;
        }
    }
    
    if(!isAdded){
        OrderItem *thisOrder=[OrderItem new];
        thisOrder.productId=productId;
        thisOrder.productName=productName;
        thisOrder.number=[textField.text intValue];
        thisOrder.price=productPrice;
        [[Orders share]addOrder:thisOrder];
        [thisOrder autorelease];
    }
    UIViewController *share=(UIViewController*)[[UIApplication sharedApplication] delegate];
    [share.tabBarController setSelectedIndex:3];
    closePopWindow();
    return YES;
}

-(IBAction)cancelBuy:(id)sender{
    [self.view removeFromSuperview];
    [self release];
}
#pragma -
#pragma mark NotificationMethod
-(void)succssLogin:(NSNotification*)notification{
    [parentview addSubview:self.view];
    [nameLabel setText:[SignInObject share].name];
}
-(void)cancelLogin:(NSNotification*)notification{
    [self.view removeFromSuperview];
    [self release];
}
#pragma -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self evenlopSuit];
    num.delegate=self;
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
#pragma -
@end
