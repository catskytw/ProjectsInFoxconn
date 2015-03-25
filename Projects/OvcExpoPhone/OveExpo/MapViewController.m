//
//  MapViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UIViewClearSubViews.h"
#import "RecentScheduleCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AStar.h"
#import "CompanySummaryPopup.h"
#import "Tools.h"
#import "FcUIBarButtonItem.h"
#import "UITuneLayout.h"
#import "MapDAO.h"
#import "ScheduleObject.h"
#import "ExhibitorListFromMap_viewController.h"
#import "PointInfoObject.h"
#import "FcConfig.h"
#import "LocationInfoObject.h"
static MapViewController *singletonMapViewController=nil;
@interface MapViewController(PrivateMethod)
-(void)drawPOIBtn;
-(LocationInfoObject*)getExhibitorInfo:(NSInteger)locationId;
-(void)customBackNavigationBar;
-(IBAction)mapBtnAction:(id)sender;
-(void)changeGuideLine:(id)sender;
-(void)pickerSetting;
-(void)drawStartAndTargetIcon:(NSInteger)_targetPosition withNowPosition:(NSInteger)_nowPosition;
-(void)mapMoveToPoinst:(CGPoint)centerPoint;
-(void)clearCompanyPopWindows:(NSNotification*)noti;
-(void)showConfirmPlaceWindow:(NSNotification*)noti;
-(void)clearConfirmPlaceWindow:(NSNotification*)noti;
-(void)makeRouting:(NSNotification*)noti;
-(void)refreshPointsInLocation:(NSNotification*)noti;
@end
@implementation MapViewController
@synthesize mapImageView;
@synthesize _scrollView;
@synthesize _mapMinBtn,_mapPlusBtn;
@synthesize _scaleLabel,_recentSchedule;
@synthesize _contentView;
@synthesize _openIndicator;
@synthesize nowPosition,targetPosition;
@synthesize _schedulesTable,_routeTxt;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
+(MapViewController*)current{
    if(singletonMapViewController==nil){
        singletonMapViewController=[MapViewController new];
        singletonMapViewController._routeTxt=nil;
        //取得地圖起始點
        MapDAO *mapdao=[MapDAO new];
        [mapdao settingInitNowPosition];
        [mapdao release];
    }
    return singletonMapViewController;
}
+(void)releaseSingleton{
    if(singletonMapViewController!=nil){
        [singletonMapViewController release];
        singletonMapViewController=nil;
    }
}
-(void)dealloc{
    if(shortestPathArray!=nil)
        [shortestPathArray release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=[UITuneLayout floorName:[FeatureCtrlCollections current].whichFloor];
    [UITuneLayout setNaviTitle:self];
    [self drawMap];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    pop=nil;
    placePop=nil;
    bigBtn=nil;
    exhibitorList=nil;
    pickerSelectedIndex=0;
    targetView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_start.png"]];
    nowView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_destination.png"]];
    mapDao=[MapDAO new];
    _schedules=[[mapDao getLast3Schedules]retain];
    nowPosition=0; // 起始值
    targetPosition=0;
    isScheduleOpen=NO;
    scaleRate=0.6f;
    thisMapDrawer=nil;
    allBtns=[[NSMutableArray array] retain];
    pointsInLocation=[[NSMutableArray array]retain];
    featureCtrl=[FeatureCtrlCollections current];
    MapIdxCtrl *regionIdxCtrl=featureCtrl.regionIdxCtrl;
    CGFloat width=regionIdxCtrl.cellColumn*regionIdxCtrl.cellWidth;
    CGFloat height=regionIdxCtrl.cellHeight*regionIdxCtrl.cellRow;
    eagleMapWorldRect=CGRectMake(regionIdxCtrl.startX, regionIdxCtrl.startY, regionIdxCtrl.cellColumn*regionIdxCtrl.cellWidth, regionIdxCtrl.cellHeight*regionIdxCtrl.cellRow);
    [self mapMoveToPoinst:ccp(width/2,height/2)];
    [self pickerSetting];
    [_recentSchedule setText:AMLocalizedString(@"recentSchedule", nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCompanyPopWindows:) name:CLEAR_COMPANY_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showConfirmPlaceWindow:) name:SHOW_PLACE_CONFIRM_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearConfirmPlaceWindow:) name:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeRouting:) name:MAKE_ROUTEING object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPointsInLocation:) name:REFRESH_POINTS_IN_LOCATION object:nil];
}

- (void)viewDidUnload
{
    if(_routeTxt!=nil){
        [_routeTxt release];
        _routeTxt=nil;
    }
    [allBtns release];
    [targetView release];
    [nowView release];
    [pointsInLocation release];
    [_schedules release];
    [mapDao release];
    [fcPicker release];
    [exhibitorList release];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CLEAR_COMPANY_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SHOW_PLACE_CONFIRM_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MAKE_ROUTEING object:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - MapDrawing
-(void)drawPOIBtn{
    MapDAO *_newDAO=[MapDAO new];
    if(exhibitorList!=nil){
        [exhibitorList release];
        exhibitorList=nil;
    }
    exhibitorList=[_newDAO getAllLocationList:[FeatureCtrlCollections current].whichFloor];
    NSLog(@"exhibitorList count %d",[exhibitorList count]);
    for (UIButton *_clearBtn in allBtns) {
        [_clearBtn removeFromSuperview];
    }
    [allBtns removeAllObjects];
    [thisMapDrawer.pointArray sortUsingDescriptors:[MiscTool getOneDeascSortDescriptor:@"yValue"]];
    for (MapFeature *_thisFeature in thisMapDrawer.pointArray) {
        CGPoint point=[(NSValue*)[_thisFeature.points objectAtIndex:0] CGPointValue];
        MapPoint *pointStyle=(MapPoint*)_thisFeature.styleObject;
        UIButton *_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setFrame:CGRectMake(0, 0, 32, 32)];
        if(pointStyle.bmpId==0){ //廠商名稱
#ifndef DRAW_ALL_POINT
            if (scaleRate<0.4f) //cathy
                continue;
#else 
            
#endif
            //UIControlStateReserved 為featureId,亦為locationId
            //UIControlStatNormal為廠商名稱
#ifndef DRAW_ALL_POINT
            LocationInfoObject *obj=[self getExhibitorInfo:_thisFeature.featureId];
            [_btn setTitle:[NSString stringWithFormat:@"%i",_thisFeature.featureId] forState:UIControlStateReserved];
            [_btn setTitle:obj.name forState:UIControlStateNormal];
            [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btn setBackgroundColor:[UIColor clearColor]];
            [_btn setFrame:CGRectMake(0, 0, 60*scaleRate, 60*scaleRate)];
            [_btn.titleLabel setNumberOfLines:0];
            [_btn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:11.0f]];
            _btn.layer.anchorPoint=CGPointMake(0.5, 0.5);
#else
            [_btn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:10]];
            [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [_btn setTitle:[NSString stringWithFormat:@"[%d]",_thisFeature.featureId] forState:UIControlStateNormal];
#endif
        }
        else if(pointStyle.bmpId==9999){
            [_btn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:10]];
            [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn setTitle:[NSString stringWithFormat:@"[%d]",_thisFeature.featureId] forState:UIControlStateNormal];
        }
        else if(pointStyle.bmpId!=9999){//設施
#ifndef DRAW_ALL_POINT
            [_btn setBackgroundImage:[UIImage imageNamed:[mapDao getLocationIconName:pointStyle.bmpId]] forState:UIControlStateNormal];
            [_btn setFrame:CGRectMake(0, 0, 32, 32)];
            _btn.layer.anchorPoint=CGPointMake(0.5, 1);
            [_btn setTitle:[NSString stringWithFormat:@"%i",_thisFeature.featureId] forState:UIControlStateReserved];
#else
            [_btn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:10]];
            [_btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            [_btn setTitle:[NSString stringWithFormat:@"[%d]",_thisFeature.featureId] forState:UIControlStateNormal];
#endif
        }
        _btn.tag=pointStyle.bmpId;
        _btn.center=CGPointMake(point.x*scaleRate, point.y*scaleRate);
        _btn.frame=fixBlurryRect(_btn.frame);
        [_btn addTarget:self action:@selector(mapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_btn];
        [allBtns addObject:_btn];
    }
    [_newDAO release];
}

-(void)showExhibitorInfo:(NSString*)locationId isFacility:(BOOL)isFacility{
    UIButton *thisBtn=nil;
    for(UIButton *_tmpBtn in allBtns){
        if([[_tmpBtn titleForState:UIControlStateReserved] isEqualToString:locationId]){
            thisBtn=_tmpBtn;
        }
    }
    if (thisBtn==nil) return; //找不到相同的locationId
    bigBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [bigBtn setFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    [bigBtn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bigBtn];
    
    CGPoint btnPoint=(thisBtn).frame.origin;

    NSString *m_featureId=[NSString stringWithFormat:@"%@",[thisBtn titleForState:UIControlStateReserved]];
    pop=[[CompanySummaryPopup alloc] initWithMapId:[NSString stringWithFormat:@"%d", [FeatureCtrlCollections current].whichFloor] withLocationId:m_featureId isFacility:isFacility];

    pop.parentViewController=self;
    [pop.view.layer setAnchorPoint:CGPointMake(0.5, 1)];
    pop.view.center=btnPoint;
    [pop.view setFrame:fixBlurryRect(pop.view.frame)];
    [_scrollView addSubview:pop.view];
    [_scrollView bringSubviewToFront:pop.view];
        pop._detailInfo.hidden=(thisBtn.tag!=0)?YES:NO; //thisBtn.tag是bitmapId
    CGPoint popWindowCenter=ccp(btnPoint.x, btnPoint.y-(CGFloat)178.0f/2.0f);
    [self mapMoveToPoinst:popWindowCenter];
}
-(void)mapMoveToPoinst:(CGPoint)centerPoint{
    CGRect viewRect=CGRectMake(centerPoint.x-(CGFloat)_scrollView.frame.size.width/2.0f, centerPoint.y-(CGFloat)_scrollView.frame.size.height/2.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView scrollRectToVisible:viewRect animated:YES];
}
-(IBAction)mapBtnAction:(id)sender{
    UIButton *pressBtn=(UIButton*)sender;
    pickerSelectedIndex=0;
    [self showExhibitorInfo:[pressBtn titleForState:UIControlStateReserved] isFacility:(pressBtn.tag==0)?NO:YES];
}

-(IBAction)clearBtn:(id)sender{
    [bigBtn removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_COMPANY_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
}
-(void)drawMap{
    [UITuneLayout addWaitCursor];
    viewPortViewWidth=round(eagleMapWorldRect.size.width*scaleRate);
    viewPortViewHeight=round(eagleMapWorldRect.size.height*scaleRate);
    if (thisMapDrawer!=nil) {
        [thisMapDrawer release];
        thisMapDrawer=nil;
    }
    thisMapDrawer=[[MapDrawer alloc]initWithWorldRect:eagleMapWorldRect with3D:NO withMonitorWidth:viewPortViewWidth withMonitorHeight:viewPortViewHeight withFeatureCollection:featureCtrl withShortestPathArray:shortestPathArray];
    thisMapDrawer.isDrawTree=YES;
#ifndef DRAW_ALL_POINT
    thisMapDrawer.isDrawRoute=NO;
#else
    thisMapDrawer.isDrawRoute=YES;
#endif
    thisMapDrawer.isDrawShortestPath=YES;
#ifndef DRAW_ALL_POINT
    thisMapDrawer.isDrawContentPoint=NO;
#else
    thisMapDrawer.isDrawContentPoint=YES;
#endif
    [thisMapDrawer redraw];
    [mapImageView setFrame:CGRectMake(0, 0, viewPortViewWidth, viewPortViewHeight)];
	[mapImageView setImage:[UIImage imageWithCGImage:thisMapDrawer.mapImageRef]];
    
    [_scrollView setContentSize:CGSizeMake(viewPortViewWidth, viewPortViewHeight)];
    [self drawPOIBtn];
    [UITuneLayout delWaitCursor];
}
-(void)caculateShortestPath:(NSInteger)startPoint withEndPoint:(NSInteger)endPoint{
    nowPosition=startPoint;
    targetPosition=endPoint;
    NSLog(@"%@",_routeTxt);
    AStar *_astart=[[AStar alloc] initWithStartpoint:[NSString stringWithFormat:@"%i",startPoint] withEndpoint:[NSString stringWithFormat:@"%i",endPoint] withRouteFileName:_routeTxt]; //TODO decide which route should be used.
    if(shortestPathArray!=nil){
        [shortestPathArray release];
        shortestPathArray=nil;
    }
    shortestPathArray=[[NSMutableArray arrayWithArray: [_astart runAstar] ]retain];
    [_astart release];
}
-(IBAction)mapPlusAction:(id)sender{
    if(scaleRate>=1) return;
    else
        scaleRate=(scaleRate+0.05)>1?1:(scaleRate+0.05);
    [self drawMap];
    [self drawStartAndTargetIcon:targetPosition withNowPosition:nowPosition];
    [_scaleLabel setText:[NSString stringWithFormat:@"%i%%",(int)(round(scaleRate*100.0f))]];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_COMPANY_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
}
-(IBAction)mapMinAction:(id)sender{
    if(scaleRate<=0.2f) return;
    else
        scaleRate=(scaleRate-0.05f)<0.2f?0.2f:(scaleRate-0.05f);
    [self drawMap];
    [self drawStartAndTargetIcon:targetPosition withNowPosition:nowPosition];
    [_scaleLabel setText:[NSString stringWithFormat:@"%i%%",(int)(round(scaleRate*100.0f))]];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_COMPANY_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
}
-(IBAction)slideSchedule:(id)sender{
    const int yVar=(isScheduleOpen)?152:-152;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [_contentView setFrame:CGRectMake(_contentView.frame.origin.x, _contentView.frame.origin.y+yVar, _contentView.frame.size.width, _contentView.frame.size.height)];
    [UIView commitAnimations];
    
    [_openIndicator setImage:[UIImage imageNamed:(isScheduleOpen)?@"bg_popup_open.png":@"bg_popup_close.png"]];
    isScheduleOpen=!isScheduleOpen;
}
#pragma --
#pragma mark - DelegateMethod 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_schedules count]; //固定總是三筆
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentScheduleCell *cell = (RecentScheduleCell*)[tableView dequeueReusableCellWithIdentifier:@"RecentScheduleCell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecentScheduleCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
	}
    ScheduleObject *thisSchedule;
    @try {
        thisSchedule=[_schedules objectAtIndex:[indexPath row]];
        [cell._startTime setText:thisSchedule.startTime];
        [cell._endTime setText:thisSchedule.endTime];
        [cell._scheduleTitle setText:thisSchedule.title];
        [cell._guideBtn setTitle:thisSchedule.locationPoint forState:UIControlStateReserved];//使用該button之UIControlStateReserved之title來紀錄locationPoint
        cell.tag=[thisSchedule.mapId intValue];
        [cell._guideBtn addTarget:self action:@selector(changeGuideLine:) forControlEvents:UIControlEventTouchUpInside];
        [cell._guideBtn setTitle:AMLocalizedString(@"guide", nil) forState:UIControlStateNormal];
    }
    @catch (NSException *exception) {
    }

    [cell._guideBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cell._guideBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [cell._guideBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cell._guideBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [cell._seperatorImage setImage:[TUNinePatchCache imageOfSize:cell._seperatorImage.frame.size forNinePatchNamed:@"bg_popup_schedule_line"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)changeGuideLine:(id)sender{
    //TEST DATA
    UIButton *btn=(UIButton*)sender;
    NSString *locationPoint=[btn titleForState:UIControlStateReserved];
    NSInteger mapId=btn.tag;
    [[FeatureCtrlCollections current] loadMapData:mapId];
    [self settingFloor:mapId];
    
    self.title=[UITuneLayout floorName:[FeatureCtrlCollections current].whichFloor];
    [UITuneLayout setNaviTitle:self];
    [self drawMap];
    [self showExhibitorInfo:locationPoint isFacility:NO];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PointInfoObject *thisObject=[pointsInLocation objectAtIndex:row];
    return thisObject.pointName;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pointsInLocation count];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if([pointsInLocation count]<=0) return;
    pickerSelectedIndex=row;

}
- (void) pickerSubmit{
    if([pointsInLocation count]==0){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"login_err_alert_title", nil) message:AMLocalizedString(@"pointError", nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"close", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if(pickerSelectedIndex>=[pointsInLocation count])
        pickerSelectedIndex=[pointsInLocation count]-1;
    PointInfoObject *thisObject=[pointsInLocation objectAtIndex:pickerSelectedIndex];
    NSLog(@"thisPointId %d",thisObject.pointId);
    [LocationInfoObject targetPosition].pointId=[NSString stringWithFormat:@"%d",thisObject.pointId];
    targetPosition=thisObject.pointId;
    [[NSNotificationCenter defaultCenter]postNotificationName:SHOW_PLACE_CONFIRM_WINDOW object:nil];
}
#pragma --
#pragma mark - PrivateMethod
-(LocationInfoObject*)getExhibitorInfo:(NSInteger)locationId{
    LocationInfoObject *r=nil;
    for(LocationInfoObject *thisObject in exhibitorList){
        if ([thisObject.locationId isEqualToString:[NSString stringWithFormat:@"%d",locationId]]) {
            r=thisObject;
            break;
        }
    }
    return r;
}
-(void)pickerSetting{
    fcPicker  = [FcPickerController new];
    fcPicker.delegate = self;
    fcPicker.pickerdelegate = self;
    [self.view addSubview:fcPicker.view];
    fcPicker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif, fcPicker.view.frame.size.width, fcPicker.view.frame.size.height);
}
-(void)rightItemAction:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_COMPANY_WINDOW object:nil];
    ExhibitorListFromMap_viewController *listViewController=[[ExhibitorListFromMap_viewController alloc] initWithNibName:@"ExhibitorListViewController" bundle:nil];
    [listViewController setBackItem:self.title];
    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController release];
}
-(void)settingFloor:(NSInteger)floorType{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    
    switch (floorType) {
        case A_2F:
            _routeTxt=[[NSString stringWithFormat:@"%@/%@",documentDir,@"A_2F_V_route.txt"] retain];
            break;
        case A_3F:
            _routeTxt=[[NSString stringWithFormat:@"%@/%@",documentDir,@"A_3F_V_route.txt"] retain];
            break;
        case B_1F:
            _routeTxt=[[NSString stringWithFormat:@"%@/%@",documentDir,@"B_1F_V_route.txt"]retain];
            break;
        case B_2F:
            _routeTxt=[[NSString stringWithFormat:@"%@/%@",documentDir,@"B_2F_V_route.txt"] retain];
            break;
    }
    NSLog(@"%@",_routeTxt);
}

-(void)clearCompanyPopWindows:(NSNotification*)noti{
    if(pop!=nil){
        [pop.view removeFromSuperview];
        [pop release];
        pop=nil;
    }
    
    if(bigBtn!=nil){
        [bigBtn removeFromSuperview];
        [bigBtn release];
        bigBtn=nil;
    }
}

-(void)showConfirmPlaceWindow:(NSNotification*)noti{
    placePop=[PlaceConfirmPopWindow new];
    
    placePop.view.center=self.view.center;
    [placePop.view setFrame:fixBlurryRect(placePop.view.frame)];
    [self.view addSubview:placePop.view];
    
    bigBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [bigBtn setFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    [bigBtn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bigBtn];
    

}
-(void)clearConfirmPlaceWindow:(NSNotification*)noti{
    if(placePop!=nil){
        [placePop.view removeFromSuperview];
        [placePop release];
        placePop=nil;
    }
}
-(void)refreshPointsInLocation:(NSNotification*)noti{
    [pointsInLocation removeAllObjects];
    NSDictionary *dic=noti.userInfo;
    NSArray *pointFromNoti=(NSArray*)[dic valueForKey:@"pointsInNoti"];
    [pointsInLocation addObjectsFromArray:pointFromNoti];
    
    [fcPicker.picker reloadAllComponents];
    [fcPicker slideUp:YES];
}
-(void)makeRouting:(NSNotification*)noti{
    [self cleanShortestPathItem];
    BOOL isDifferentFloor=NO;
    if([[LocationInfoObject nowPosition].mapId intValue]!=[FeatureCtrlCollections current].whichFloor){
        //不同圖層
        MapDAO *mapdao=[MapDAO new];
        [mapdao getExitByFromAndToMapId:[[LocationInfoObject nowPosition].mapId  intValue] withToMapId:[FeatureCtrlCollections current].whichFloor];
        isDifferentFloor=YES;
        [mapdao release];
        
        NSInteger floor=[[LocationInfoObject nowPosition].mapId intValue];
        [[FeatureCtrlCollections current] loadMapData:[[LocationInfoObject nowPosition].mapId intValue]];
        [self settingFloor:floor];
        self.title=[UITuneLayout floorName:floor];
        [UITuneLayout setNaviTitle:self];
    }
    NSInteger _tmpNowPosition=[[LocationInfoObject nowPosition].pointId intValue];
    targetPosition=[[LocationInfoObject targetPosition].pointId intValue];
    nowPosition=_tmpNowPosition;
    [self caculateShortestPath:targetPosition withEndPoint:_tmpNowPosition];
    [self drawMap];
    [self drawStartAndTargetIcon:targetPosition withNowPosition:nowPosition];
    if(isDifferentFloor){
        NSString *message=[NSString stringWithFormat:AMLocalizedString(@"differentFloor_long", nil),[LocationInfoObject nowPosition].name,[LocationInfoObject targetPosition].name];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"message", nil) message:message delegate:nil cancelButtonTitle:AMLocalizedString(@"close", nil) otherButtonTitles: nil];
        ((UILabel*)[[alert subviews] objectAtIndex:1]).textAlignment = UITextAlignmentLeft;
        [alert show];
    }
}

-(void)drawStartAndTargetIcon:(NSInteger)_targetPosition withNowPosition:(NSInteger)_nowPosition{

    MapFeature *targetFeature=[[FeatureCtrlCollections current].pointDataCtrl getFeatureObject:_targetPosition withFeatureType:FeatureTypePoint];
    MapFeature *nowPositionFeature=[[FeatureCtrlCollections current].pointDataCtrl getFeatureObject:_nowPosition withFeatureType:FeatureTypePoint];
    CGPoint targetPoint=[[targetFeature.points objectAtIndex:0] CGPointValue];

    CGPoint nowPoint=[[nowPositionFeature.points objectAtIndex:0] CGPointValue];

    targetView.layer.anchorPoint=ccp(0.5,1);
    nowView.layer.anchorPoint=ccp(0.5,1);
    targetView.center=ccp(targetPoint.x*scaleRate,targetPoint.y*scaleRate);
    nowView.center=ccp(nowPoint.x*scaleRate,nowPoint.y*scaleRate);
    targetView.frame=fixBlurryRect(targetView.frame);
    nowView.frame=fixBlurryRect(nowView.frame);
    
    if([allBtns count]>0){
        UIButton *lastBtn=[allBtns objectAtIndex:[allBtns count]-1];
        [_scrollView insertSubview:targetView aboveSubview:lastBtn];
        [_scrollView insertSubview:nowView aboveSubview:lastBtn];
    }else{
        [_scrollView addSubview:nowView];
        [_scrollView addSubview:targetView];
    }
    [self mapMoveToPoinst:nowView.center];
}

-(void)cleanShortestPathItem{
    [shortestPathArray removeAllObjects];
    [targetView removeFromSuperview];
    [nowView removeFromSuperview];
    nowPosition=0;
    targetPosition=0;
}
#pragma --
@end
