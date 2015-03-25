//
//  AboutFutureMainPageView.m
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutFutureMainPageView.h"
#import "LocalizationSystem.h"
#import "AboutFutureMainPageCell.h"
#import "Vars.h"
#import "NewsViewController.h"
#import "FeatureListViewController.h"
#import "ExhibitionIntroViewController.h"
#import "AboutFutureModel.h"
#import "CommonContentDescriptionView.h"
#import "ToolsFunction.h"
@implementation AboutFutureMainPageView
@synthesize optionString,thisContentTable;
-(id)init{
	/**
	 "News"="最新消息";
	 "Future"="展館風貌";
	 "ExhibitIntro"="展區介紹";
	 "Ticket"="票價資訊";
	 "VisitNotice"="參觀須知";
	 "ContactInfo"="聯絡資訊";
	 */
	if((self=[super init])){
		optionString=[[NSArray arrayWithObjects:
					  AMLocalizedString(@"News",nil),
					  AMLocalizedString(@"Future",nil),
					  AMLocalizedString(@"ExhibitIntro",nil),
					  AMLocalizedString(@"Ticket",nil),
					  AMLocalizedString(@"VisitNotice",nil),
					  AMLocalizedString(@"ContactInfo",nil),
					  nil]retain];
		
		thisContentTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 343)];
	}
	return self;
}
- (void)dealloc {
	[thisContentTable release];
	[optionString release];
    [super dealloc];
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	[titleLabel setText:AMLocalizedString(@"AboutFuture",nil)];
	[leftBtn setHidden:NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[thisContentTable setBackgroundColor:[UIColor clearColor]];
	thisContentTable.delegate=self;
	thisContentTable.dataSource=self;
	[viewPortView addSubview:thisContentTable];
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [optionString count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
	AboutFutureMainPageCell *thisCell=(AboutFutureMainPageCell*)[tableView dequeueReusableCellWithIdentifier:@"AboutFutureMainPageCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"AboutFutureMainPageCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[AboutFutureMainPageCell class]]){
				thisCell=(AboutFutureMainPageCell*)currentObject;
				break;
			}
		}
		[thisCell setBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green.png"]]autorelease]];
		[thisCell setSelectedBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green_i.png"]]autorelease]];
	}
	int indicator=rowIndex%2;
	[thisCell.contentLabel setText:(NSString*)[optionString objectAtIndex:rowIndex]];
	[thisCell.contentImageView setImage:(indicator==0)?[UIImage imageNamed:@"contentui_icon_menu_blue.png"]:[UIImage imageNamed:@"contentui_icon_menu_orange.png"]];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleMedium;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(![ToolsFunction hasConnected]) return;
	int selectedIndex=[indexPath row];
	NewsViewController *newsViewController;
	FeatureListViewController *featureListViewController;
	ExhibitionIntroViewController *exhibitionIntroViewController;
	CommonContentDescriptionView *nextCommonViewController;
	switch (selectedIndex) {
		//最新消息
		case 0:
			newsViewController=[NewsViewController new];
			[self.navigationController pushViewController:newsViewController animated:YES];
			[newsViewController release];
			break;
		//展館風貌
		case 1:
			featureListViewController=[FeatureListViewController new];
			[self.navigationController pushViewController:featureListViewController animated:YES];
			[featureListViewController release];
			break;
		//展區介紹
		case 2:
			exhibitionIntroViewController=[[ExhibitionIntroViewController alloc]initwithAreaKey:@""];
			[self.navigationController pushViewController:exhibitionIntroViewController animated:YES];
			[exhibitionIntroViewController release];
			break;
		//票價資訊
		case 3:
			nextCommonViewController=[[CommonContentDescriptionView alloc]initWithDataObject:[AboutFutureModel getTicketInfo]];
			[self.navigationController pushViewController:nextCommonViewController animated:YES];
			[nextCommonViewController release];
			break;
		//參觀須知
		case 4:
			nextCommonViewController=[[CommonContentDescriptionView alloc]initWithDataObject:[AboutFutureModel getVisitNotice]];
			[self.navigationController pushViewController:nextCommonViewController animated:YES];
			[nextCommonViewController release];
			break;
		//聯絡資訊
		case 5:
			nextCommonViewController=[[CommonContentDescriptionView alloc]initWithDataObject:[AboutFutureModel getContactInfo ]];
			[self.navigationController pushViewController:nextCommonViewController animated:YES];
			[nextCommonViewController release];
			break;
		default:
			break;
	}
}

@end
