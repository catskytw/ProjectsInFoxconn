//
//  FlowerSearchResultViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerSearchResultViewController.h"
#import "AboutFutureModel.h"
#import "LocalizationSystem.h"
#import "NewsCell.h"
#import "FlowerDataObject.h"
#import "FlowerInfoBaseViewController.h"
#import "ToolsFunction.h"
@implementation FlowerSearchResultViewController
@synthesize dataObject;
-(id)initWithFlowerName:(NSString*)flowerName{
	if((self=[super init])){
		dataObject=[[AboutFutureModel getFlowerByName:flowerName]retain];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"FlowerSearchViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	[subTitleLabel setText:AMLocalizedString(@"SearchResult",nil)];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	int num=[dataObject.contentArray count];
	if(num==0){
		[thisContentTable setHidden:YES];
		[noDataLabel setHidden:NO];
		[noDataLabel setText:AMLocalizedString(@"NoData",nil)];
	}
	return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
	//版型與newscell相同,借用.
	NewsCell *thisCell=(NewsCell*)[tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[NewsCell class]]){
				thisCell=(NewsCell*)currentObject;
				break;
			}
		}
		[thisCell setBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green.png"]]autorelease]];
		[thisCell setSelectedBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green_i.png"]]autorelease]];
	}
	FlowerDataObject *thisDataObject=(FlowerDataObject*)[dataObject.contentArray objectAtIndex:rowIndex];
	[thisCell.date setText:thisDataObject.name];
	[thisCell.subject setText:thisDataObject.desc];
	[thisCell.newsId setText:thisDataObject.flowerId];
	return thisCell;	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if([ToolsFunction hasConnected]){
		int rowIndex=[indexPath row];
		FlowerDataObject *thisDataObject=(FlowerDataObject*)[dataObject.contentArray objectAtIndex:rowIndex];
		FlowerInfoBaseViewController *nextController=[[FlowerInfoBaseViewController alloc]initWithFlowerId:thisDataObject.flowerId];
		[parentNavigationController pushViewController:nextController animated:YES];
		[nextController release];
	}
}
-(void)dealloc{
	[dataObject release];
	[super dealloc];
}
-(IBAction)searchFlowerAction:(id)sender{
	if(dataObject!=nil){
		[dataObject release];
		dataObject=nil;
	}
	//重新取得資料
	dataObject=[[AboutFutureModel getFlowerByName:thisSearchTextField.text]retain];
	[thisContentTable reloadData];
}
@end
