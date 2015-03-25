//
//  MRTDescriptionViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MRTDescriptionViewController.h"
#import "MRTInfoStationCellObject.h"
#import "TrafficDataModel.h"
#import "Vars.h"
#import "MRTStationObject.h"
@implementation MRTDescriptionViewController
-(id)initWithKey:(NSString*)key{
	if((self=[super init])){
		isLeave=YES;
		queryKey=[[NSString stringWithString:key]retain];
		thisBusDescription=[[TrafficDataModel getMRTStationInfoObject:key isLeave:isLeave]retain];
	}
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:@"BusDescriptionViewController" bundle:nibBundleOrNil]) {
	}
	return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	//決定右側之按鍵內容
	[actionButton setImage:[UIImage imageNamed:@"trafficui_ic_information.png"] forState:UIControlStateNormal];
	[actionButton setImage:[UIImage imageNamed:@"trafficui_ic_information_i.png"] forState:UIControlStateSelected];

	UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"TRTCMap",nil) style:UIBarButtonItemStylePlain target:self action:@selector(enterMRTMap:)];
	[self.navigationItem setRightBarButtonItem:rightButton animated:NO];
	[rightButton release];
	
	[self setDescriptionValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MRTInfoStationCellObject *thisCell=(MRTInfoStationCellObject*)[tableView dequeueReusableCellWithIdentifier:@"BusInfoStationCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MRTInfoStation" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MRTInfoStationCellObject class]]){
				thisCell=(MRTInfoStationCellObject*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	int myIndex=[indexPath row];
	MRTStationObject *station=(MRTStationObject*)[thisBusDescription.stationInfoArray objectAtIndex:myIndex];
	[thisCell.stationName setText:station.stationName];
	[thisCell.lineIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",station.stationLinePic]]];
	[thisCell.linePass setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",station.stationPassPic]]];
	
	[thisCell.aTrans setHidden:!station.isATrans];
	[thisCell.tTrans setHidden:!station.isTTrans];
	[thisCell.bTrans setHidden:!station.isBTrans];
	[thisCell.hTrans setHidden:!station.isHTrans];
	return thisCell;
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{	
//	GoogleMapBaseViewController *gmbvc;
//	BusInfoStationCell *thisCell;
//	BusSearchCategoryList *busLines;
//	GoogleMapRoutePlainViewController *routePlanView;
//	switch (buttonIndex) {
//			//加入我的最愛
//		case 0:
//			thisCell=(BusInfoStationCell*)[thisContentTable cellForRowAtIndexPath:selectedIndexPath];
//			MyFavoriteDirectoryPickerActionSheet *pickAction=[[MyFavoriteDirectoryPickerActionSheet alloc]initWithTitle:@"請選擇" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"完成" otherButtonTitles:nil];
//			pickAction.delegate=pickAction;
//			pickAction.busLine=[NSString stringWithFormat:@"去程: %@",busLineName.text];
//			pickAction.stationName=[NSString stringWithString:thisCell.stationName.text];
//			pickAction.busLineType=thisBusDescription.busLineType;
//			MyFavoriteDirectoryPickerView *pickerView=
//			[[MyFavoriteDirectoryPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withFavoriteType:poiBusType];
//			pickAction.selectedPicker=pickerView;
//			pickerView.showsSelectionIndicator=YES;
//			
//			[pickAction addSubview:pickerView];
//			[pickAction showInView:self.view];
//			[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
//			[pickerView release];
//			[pickAction release];
//			break;
//			//瀏覽地圖
//		case 1:
//			gmbvc=[[GoogleMapBaseViewController alloc]initWithAnnotationClickFlag:NO withStartLocation:TaipeiStationPosition];
//			[self.navigationController pushViewController:gmbvc animated:YES];
//			[gmbvc release];
//			break;
//			//站點行經公車
//		case 2:
//			busLines=[BusSearchCategoryList new];
//			[self.navigationController pushViewController:busLines animated:YES];
//			[busLines release];
//			break;
//			//路線規畫
//		case 3:
//			thisCell=(BusInfoStationCell*)[thisContentTable cellForRowAtIndexPath:selectedIndexPath];
//			routePlanView=[GoogleMapRoutePlainViewController new];
//			routePlanView.startPOILocation=MarketPosition;
//			routePlanView.endStationString=[NSString stringWithString:thisCell.stationName.text];
//			[self.navigationController pushViewController:routePlanView animated:YES];
//			[routePlanView release];
//			break;
//		default:
//			break;
//	}
//	//TODO 依不同的動作做出不同的反應
//	[actionSheet release];
//}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
	[actionSheet release];
}

-(void)showRightBarButtonItem:(BOOL)isShow{
	if(!isShow){
		self.navigationItem.rightBarButtonItem=nil;
	}
}
-(void)setDescriptionValue{
	[self.navigationItem setTitle:thisBusDescription.busLineName];
	[busLineName setText:thisBusDescription.busLineName];
	[busScheduleString setText:thisBusDescription.busLineScheduleString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	/*
	selectedIndexPath=[[indexPath copy]retain];
	UIActionSheet *menu=[[UIActionSheet alloc]
						 initWithTitle:@"針對此筆資料" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"加入我的最愛" otherButtonTitles:@"瀏覽地圖",@"站點行經公車一覽",@"開始路線規畫",nil];
	[menu showInView:self.view];
	 */
}

-(IBAction)changeDeparture:(id)sender{
	UISegmentedControl *thisSeg=(UISegmentedControl*)sender;
	isLeave=(thisSeg.selectedSegmentIndex==0)?YES:NO;
	[thisBusDescription release];
	thisBusDescription=[[TrafficDataModel getMRTStationInfoObject:queryKey isLeave:isLeave]retain];
	[self setDescriptionValue];
	[thisContentTable reloadData];
}

-(IBAction)clickActionButton:(id)sender{
	UIAlertView *thisAlert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"IconInfo",nil) 
													 message:AMLocalizedString(@"IconDesc",nil)  delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[thisAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[alertView release];
}

@end
