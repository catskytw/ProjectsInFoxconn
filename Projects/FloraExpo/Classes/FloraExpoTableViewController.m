//
//  FloraExpoContent.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoTableViewController.h"
#import "FloraExpoCell.h"
#import "Vars.h"
#import "NewsObject.h"
#import "MyLifeSearchResultCell.h"
@implementation FloraExpoTableViewController
@synthesize floraExpoTable;
@synthesize marqueeView;
@synthesize marqueeString;

-(id)initwithTableType:(NSInteger)tableType{
	if((self=[super init])){
		thisTableType=tableType;
		isEndMarquee=YES;
		fec=[[FloraExpoController alloc]initWithType:tableType withKey:nil];
	}
	return self;
}

-(id)initwithTableType:(NSInteger)tableType withKey:(NSString*)key{
	if((self=[super init])){
		thisTableType=tableType;
		isEndMarquee=YES;
		fec=[[FloraExpoController alloc]initWithType:tableType withKey:key];
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	marqueeXposition=320;
	[super viewWillAppear:animated];
	marqueeView.hidden=YES;//先disable 掉
	//marqueeView.hidden=(thisTableType==News)?NO:YES;
	[self.navigationController.navigationBar setHidden:NO];
	[self.navigationController.toolbar setHidden:NO];
	[self.tabBarController.tabBar setHidden:NO];
	[self.tabBarController setSelectedIndex:0];
	floraExpoTable.delegate=self;
	//TODO title必須要從controller來判斷
	[self.navigationItem setTitle:[fec getTitle:thisTableType]];
	//TODO should use singlton here
	/*
	if(thisTableType==News)
		thisTimer=[NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(changeMarqueeStringPosition) userInfo:nil repeats:YES];
	 */
}

-(void)changeMarqueeStringPosition{
	//NSString *text=[fec getMarqueeString];
	NSString *text=@"";
	CGSize size=[text sizeWithFont:[UIFont systemFontOfSize:17.0]];
	marqueeString.text=text;
	marqueeString.frame=CGRectMake(marqueeXposition, marqueeString.frame.origin.y,size.width, marqueeString.frame.size.height);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:6.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	marqueeString.frame=CGRectMake(0-marqueeString.frame.size.width, marqueeString.frame.origin.y,marqueeString.frame.size.width, marqueeString.frame.size.height);
	[UIView commitAnimations];
}
 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[thisTimer invalidate];
}


- (void)dealloc {
	[fec release];
	[super dealloc];
}

//有幾個section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [fec getNumberOfSection:thisTableType];
}
//以下三個method,必須依不同的tableType來做區別
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [fec getNumberOfRow:thisTableType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [fec getTableCell:thisTableType withTableView:tableView withIndexPath:indexPath];
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)newIndexPath{
	UIViewController *nextController;
	NSInteger index=[newIndexPath row];
	MyLifeSearchResultCell *selectedCell;
	UIAlertView *showDetail;
	switch (thisTableType) {
		case FloraExpoContent:
			nextController=[fec getNextViewControllerOnForaExpoContent:index];
			break;
		case News:
			nextController=[fec getNextViewControllerOnNews:((NewsObject*)[fec.dataArray objectAtIndex:index]).newsKey];
			break;
		case AboutFlora:
			nextController=[fec getNextViewControllerOnAboutFlora:index];
			break;
		case HotelList:
			selectedCell=(MyLifeSearchResultCell*)[tableView cellForRowAtIndexPath:newIndexPath];
			NSString *contentString=[NSString stringWithFormat:@"%@\n%@\n%@",
									 selectedCell.name.text,
									 selectedCell.address.text,
									 selectedCell.teletphone.text];
			NSLog(@"%@",contentString);
			showDetail=[[[UIAlertView alloc]initWithTitle:nil message:contentString delegate:nil cancelButtonTitle:AMLocalizedString(@"Cancel",nil) otherButtonTitles:nil]autorelease];
			[showDetail show];
			nextController=nil;
			break;
		default:
			break;
	}
	if(nextController!=nil)
		[self.navigationController pushViewController:nextController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger returnHeight=0;
	switch (thisTableType) {
		case FloraExpoContent:
			returnHeight=cellHeightTypeSmall;
			break;
		case News:
			returnHeight=cellHeightTypeMedium;
			break;
		case AboutFlora:
			returnHeight=cellHeightTypeSmall;
			break;
		case HotelList:
			returnHeight=cellHeightTypeMedium;
			break;
	}
	return returnHeight;
}

@end
