//
//  Hello_SOAPAppDelegate.m
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Hello_SOAPViewController.h"
#import "OrderDtlObject.h"
#import "WMBTWebService.h"

#define NotificationName @"notification"
@implementation Hello_SOAPViewController

@synthesize greeting, nameInput, webData, soapResults, xmlParser;

-(IBAction)buttonClick:(id)sender
{
    OrderDtlObject *o=[OrderDtlObject new];
    o.prodId=@"2D38C91DA4A74F96834B86B7BC88AE48";
    o.prodPrice=@"5499";
    o.prodQty=@"2";
    WMBTWebService *webService=[[WMBTWebService alloc]initWithNotificationName:NotificationName];
    [webService createAdvance:[NSArray arrayWithObjects:o, nil] withCpy:@"ABEF0FC10A868251016BA008C479159A" withMember:@"57457C2E0AB513B9014807739872A35A"];
}



/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */


// Implement viewDidLoad if you need to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showContent:) name:NotificationName object:nil];
}


-(void)showContent:(NSNotification*)notification{
    NSDictionary *dic=notification.userInfo;
    [greeting setText:(NSString*)[dic valueForKey:@"out"]];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
	[super dealloc];
}
@end
