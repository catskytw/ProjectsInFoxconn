//
//  FirstViewController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/24.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FirstViewController.h"
#import "FcTabBarItem.h"

@implementation FirstViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:@"促銷專區" image:nil tag:1];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_sales.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_sales_i.png"];
	self.tabBarItem=thisBarItem;
	[thisBarItem release];
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
}


- (void)dealloc {
    [super dealloc];
}

@end
