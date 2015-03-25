//
//  FloraExpoController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoController.h"
#import "FloraExpoCell.h"
#import "FloraExpoModel.h"
#import "NewsTableViewCell.h"
#import "NewsTableView.h"
#import "DescriptionViewController.h"
#import "ExhibitionTableView.h"
#import "FlowerInfoByExhibitionView.h"
#import "Vars.h"
#import "NewsObject.h"
#import "CommonItem.h"
#import "MyLifeSearchResultCell.h"
#import "HotelObject.h"

@implementation FloraExpoController
@synthesize dataArray;

-(id)initWithType:(NSInteger)tableType withKey:(NSString*)key{
	if((self=[super init])){
		switch (tableType) {
			case FloraExpoContent:
				dataArray=[[FloraExpoModel getFloraExpoContentItemsTitle]retain];
				break;
			//最新消息
			case News:
				dataArray=[[FloraExpoModel getExpoLatestNewList]retain];
				break;
			case AboutFlora:
				dataArray=[[FloraExpoModel totalAboutFloratitles]retain];
				break;
			case HotelList:
				dataArray=[[FloraExpoModel getExpoHotelListWithKey:key]retain];
				break;
		}
	}
	return self;
}
-(void)dealloc{
	[dataArray release];
	[super dealloc];
}
-(NSString*)getTitle:(NSInteger)tableType{
	NSString *returnString;
	switch (tableType) {
		case FloraExpoContent:
			returnString=AMLocalizedString(@"2010FloraExpo",nil);
			break;
		case News:
			returnString=AMLocalizedString(@"News",nil);
			break;
		case AboutFlora:
			returnString=AMLocalizedString(@"AboutFlora",nil);
			break;
		default:
			returnString=nil;
			break;
	}
	return returnString;
}
-(NSInteger)getNumberOfSection:(NSInteger)tableType{
	return 1;
}
-(NSInteger)getNumberOfRow:(NSInteger)tableType{
	return [dataArray count];
}

-(UITableViewCell*)getTableCell:(NSInteger)tableType withTableView:(UITableView*)tableView withIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *thisCell;
	NSInteger thisIndex=[indexPath row];
	FloraExpoModel *floraExpoModal=[[FloraExpoModel alloc]init];
	switch (tableType) {
		case FloraExpoContent:
			thisCell=(FloraExpoCell*)[tableView dequeueReusableCellWithIdentifier:@"FloraExpoCell"];
			if(thisCell==nil){
				NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FloraExpoCell" owner:nil options:nil];
				for(id currentObject in  nib){
					if([currentObject isKindOfClass:[FloraExpoCell class]]){
						thisCell=(FloraExpoCell*)currentObject;
						break;
					}
				}
			}
			[((FloraExpoCell*)thisCell).stringLabel setText:[floraExpoModal getFloraExpoContentTitle:thisIndex]];
			[((FloraExpoCell*)thisCell).icon setImage:[UIImage imageNamed:[floraExpoModal getFloraExpoContentPicName:thisIndex]]];
			break;
		case News:
			thisCell=(NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FloraExpoCell"];
			if(thisCell==nil){
				NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil];
				for(id currentObject in  nib){
					if([currentObject isKindOfClass:[NewsTableViewCell class]]){
						thisCell=(NewsTableViewCell*)currentObject;
						break;
					}
				}
			}
			NewsObject *thisObject=(NewsObject*)[dataArray objectAtIndex:[indexPath row]];
			[((NewsTableViewCell*)thisCell).dateString setText:thisObject.dateString];
			[((NewsTableViewCell*)thisCell).contentString setText:thisObject.newsTitle];
			break;
		case AboutFlora:
			thisCell=(NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FloraExpoCell"];
			if(thisCell==nil){
				NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FloraExpoCell" owner:nil options:nil];
				for(id currentObject in  nib){
					if([currentObject isKindOfClass:[FloraExpoCell class]]){
						thisCell=(FloraExpoCell*)currentObject;
						break;
					}
				}
			}
			[((FloraExpoCell*)thisCell).stringLabel setText:[FloraExpoModel getFloraAboutFloraTitle:thisIndex]];
			[((FloraExpoCell*)thisCell).icon setImage:[UIImage imageNamed:[FloraExpoModel getFloraAboutFloraPicName:thisIndex]]];
			break;
		case HotelList:
			thisCell=(MyLifeSearchResultCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLifeSearchResultCell"];
			if(thisCell==nil){
				NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyLifeSearchResultCell" owner:nil options:nil];
				for(id currentObject in  nib){
					if([currentObject isKindOfClass:[MyLifeSearchResultCell class]]){
						thisCell=(MyLifeSearchResultCell*)currentObject;
						break;
					}
				}
			}
			HotelObject *thisHotelObject=(HotelObject*)[dataArray objectAtIndex:[indexPath row]];
			//[((FloraExpoCell*)thisCell).stringLabel setText:[FloraExpoModel getFloraAboutFloraTitle:thisIndex]];
			[((MyLifeSearchResultCell*)thisCell).name setText:thisHotelObject.hotelName];
			[((MyLifeSearchResultCell*)thisCell).teletphone setText:thisHotelObject.hotelTel];
			[((MyLifeSearchResultCell*)thisCell).address setText:thisHotelObject.hotelAddress];
			break;
		default:
			break;
	}
	thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	[floraExpoModal release];
	return thisCell;
}

-(UIViewController*)getNextViewControllerOnForaExpoContent:(NSInteger)index{
	UIViewController *nextViewController=nil;
	switch (index) {
			//最新消息
		case 0:
			nextViewController=[[FloraExpoTableViewController alloc]initwithTableType:News];
			break;
		case 1://關於花博
			nextViewController=[[FloraExpoTableViewController alloc]initwithTableType:AboutFlora];
			break;
		case 2://展館資訊
			nextViewController=[[ExhibitionTableView alloc]initWithType:Exhibition];
			break;
		case 3://花卉資訊
			nextViewController=[[FlowerInfoByExhibitionView alloc]init];
			break;
		default:
			break;
	}
	return (nil==nextViewController)?nil:[nextViewController autorelease];
}

-(NewsDetailInfoViewController*)getNextViewControllerOnNews:(NSString*)key{
	NewsDetailInfoViewController *nextViewController=[[NewsDetailInfoViewController alloc]initWithDataObject:[FloraExpoModel getExpoNewsInfo:key]];
	return [nextViewController autorelease];
}
-(UIViewController*)getNextViewControllerOnAboutFlora:(NSInteger)index{
	UIViewController *nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
	DescriptionPageDataObject *nextViewDataObject=nil;
	switch (index) {
			//花博源由
		case 0:
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoOriginDesc];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
			//參觀時間
		case 1:
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoVisittimeDesc];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
		case 2://參觀須知
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoVisitNotice];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
		case 3://票價資訊
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoTicketInfo];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
		case 4://聯絡資訊
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoContact];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
		case 5://接駁車資訊
			nextViewController=[[DescriptionViewController alloc]initWithDefaultStartY];
			nextViewDataObject=[FloraExpoModel getExpoTrafficInfo];
			((DescriptionViewController*)nextViewController).titleString=[NSString stringWithString: nextViewDataObject.title];
			((DescriptionViewController*)nextViewController).dataStringArray=[NSArray arrayWithArray:nextViewDataObject.contentArray];
			break;
		case 6://特約旅館
			nextViewController=[[ExhibitionTableView alloc]initWithType:HotelArea];
			break;
	}
	return (nil==nextViewController)?nil:[nextViewController autorelease];
}

@end
