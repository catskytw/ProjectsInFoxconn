//
//  ListTableViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ListTableViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "ListCheckTableViewCell.h"
#define cellHeight 40
#define check_X 250
#define check_Y 15

@implementation ListTableViewController
@synthesize tableCheckImg;
@synthesize scrollView;
@synthesize tableBackgroundImg;
@synthesize table;
@synthesize naviBarImg;
@synthesize navibarTitle;
@synthesize belowbarImg;
@synthesize cancelBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //[self initDataArray];
    [super viewDidLoad];
    [self setUIDefault];
    // Do any additional setup after loading the view from its nib.
}
-(void) setUIDefault{
    float tableHeight = cellHeight*([dataArray count]);
    CGSize tablesize= CGSizeMake(table.frame.size.width, tableHeight);
    [tableBackgroundImg setImage: [TUNinePatchCache imageOfSize:tablesize forNinePatchNamed:@"editbox"]];
    table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, tableHeight+7);

    tableBackgroundImg.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, tableHeight);
    //NSLog(@"table width %f height %f", table.frame.size.width, table.frame.size.height);
    [cancelBtn setTitle:AMLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];    
    [cancelBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];  
      
    
    CGRect Screenframe =  [[UIScreen mainScreen] applicationFrame];
    
    naviBarImg.frame = CGRectMake(naviBarImg.frame.origin.x, Screenframe.origin.y, naviBarImg.frame.size.width, naviBarImg.frame.size.height);
    [naviBarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_actionbar"]];
    navibarTitle.frame = CGRectMake(navibarTitle.frame.origin.x, Screenframe.origin.y, navibarTitle.frame.size.width, navibarTitle.frame.size.height);
    [navibarTitle setText:AMLocalizedString(@"Login_LoginButton",nil)];
    cancelBtn.frame = CGRectMake(cancelBtn.frame.origin.x, cancelBtn.frame.origin.y+ Screenframe.origin.y, cancelBtn.frame.size.width, cancelBtn.frame.size.height);
    //設定scrollview
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.origin.y+tableHeight)];
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y+Screenframe.origin.y, scrollView.frame.size.width, scrollView.frame.size.height-Screenframe.origin.y)];
    [belowbarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_belowbar"]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    imgLogo.frame = CGRectMake(12, 8, imgLogo.frame.size.width, imgLogo.frame.size.height);
    [belowbarImg addSubview:imgLogo];
    [imgLogo release];
    
}
-(void)initDataArray{
    if(!dataArray)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];
    
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    [dataArray addObject:@"台灣"];
    [dataArray addObject:@"日本"];
    [dataArray addObject:@"中國"];
    [dataArray addObject:@"美國"];
    [dataArray addObject:@"香港"];
    [dataArray addObject:@"英國"];
    [dataArray addObject:@"韓國"];
    [dataArray addObject:@"馬來西亞"];
    [dataArray addObject:@"新加坡"];
    [dataArray addObject:@"法國"];
    //[dataArray addObject:@"德國"];
}
- (void)viewDidUnload
{
    [self setNaviBarImg:nil];
    [self setNavibarTitle:nil];
    [self setBelowbarImg:nil];
    [self setCancelBtn:nil];
    [self setTable:nil];
    [self setTableBackgroundImg:nil];
    [self setScrollView:nil];
    [self setTableCheckImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc {
    [tableBackgroundImg release];
    if (dataArray) {
        [dataArray release];
    }
    [table release];
    [naviBarImg release];
    [navibarTitle release];
    [belowbarImg release];
    [cancelBtn release];
    [scrollView release];
    [tableCheckImg release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [dataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCheckTableViewCell *cell = (ListCheckTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCheckTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListCheckTableViewCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    //cellHeight = cell.frame.size.height;
    cell.textLabel.text =  [dataArray objectAtIndex:indexPath.row];
    UIView *seperateView = [UIView new];
    [seperateView setBackgroundColor:[UIColor grayColor]];
    seperateView.frame = CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 1);
    if (indexPath.row <[dataArray count]) {
        [cell addSubview:seperateView];
    }
    [seperateView release];
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	//NSLog(@"selected %@", [dataArray objectAtIndex:indexPath.row]);
    tableCheckImg.frame = CGRectMake(table.frame.origin.x+check_X, table.frame.origin.y+check_Y+cellHeight*indexPath.row, tableCheckImg.frame.size.width, tableCheckImg.frame.size.height);
  
	tableCheckImg.hidden = NO;
}

@end
