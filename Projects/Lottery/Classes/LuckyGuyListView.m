    //
//  LuckyGuyListView.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "LuckyGuyListView.h"
#import "LotteryCell.h"

@implementation LuckyGuyListView
@synthesize currentQuery;
@synthesize luckyGuyList;
#pragma mark LifeCycle
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark -


#pragma mark DelegateAction
-(IBAction)closeAction:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 48.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger total=[currentQuery getNumberUnderNode:@"ticketList" withKey:@"name"]+1;
	return total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"lotteryLuckyGuy";
    LotteryCell *cell =(LotteryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"LotteryCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[LotteryCell class]]){
				cell=(LotteryCell*)currentObject;
				if([indexPath row]==0)
					continue;
				else{
					[cell.order setTextColor:[UIColor blackColor]];
					[cell.ticketNumber setTextColor:[UIColor blackColor]];
					[cell.jobNumber setTextColor:[UIColor blackColor]];
					[cell.name setTextColor:[UIColor blackColor]];
					[cell.organization setTextColor:[UIColor blackColor]];
					[cell.comment setTextColor:[UIColor blackColor]];
				}
				break;
			}
		}
    }   
	if([indexPath row]!=0){
		[cell.order setText:[NSString stringWithFormat:@"%02d",[indexPath row]]];
		[currentQuery valueBinding:cell.ticketNumber withKey:@"ticketNumber" withIndexArray:[indexPath row]-1];
		[currentQuery valueBinding:cell.name withKey:@"name" withIndexArray:[indexPath row]-1];
		[currentQuery valueBinding:cell.jobNumber withKey:@"jobNumber" withIndexArray:[indexPath row]-1];
		[currentQuery valueBinding:cell.organization withKey:@"organization" withIndexArray:[indexPath row]-1];
		[cell.comment setText:@""];
	}
	//最後一次
	if ([indexPath row]>=[currentQuery getNumberUnderNode:@"ticketList" withKey:@"name"]) {
		CGFloat totalHeight=([currentQuery getNumberUnderNode:@"ticketList" withKey:@"name"]+1)*48;
		CGFloat y=398-(totalHeight/2);
		y=(y<145)?145:y;
		int height=(luckyGuyList.frame.size.height>totalHeight)?totalHeight:luckyGuyList.frame.size.height;
		luckyGuyList.frame=CGRectMake(luckyGuyList.frame.origin.x, y, luckyGuyList.frame.size.width, height);
	}
    return cell;
}

#pragma mark -
@end
