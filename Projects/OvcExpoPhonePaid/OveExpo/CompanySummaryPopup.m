//
//  CompanySummaryPopup.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CompanySummaryPopup.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "LoginDataObject.h"
#import "ExhibitorInfoViewController.h"
#import "PointInfoObject.h"
@interface CompanySummaryPopup(PrivateMethod)
-(void)valueBinding;
@end
@implementation CompanySummaryPopup
@synthesize _logo,_companyName,_companyAbstract,_detailInfo,_guideRoute,parentViewController;
-(id)initWithMapId:(NSString*)mapId withLocationId:(NSString*)locationId isFacility:(BOOL)isFacility{
    if((self=[super init])){
        _mapId=[mapId retain];
        _locationId=[locationId retain];
        _isFacility=isFacility;
    }
    return self;
}
-(void)dealloc{
    [_mapId release];
    [_locationId release];
    [super dealloc];
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
    [super viewDidLoad];
    
    [_detailInfo setBackgroundImage:[TUNinePatchCache imageOfSize:_detailInfo.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [_detailInfo setBackgroundImage:[TUNinePatchCache imageOfSize:_detailInfo.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [_detailInfo setTitle:AMLocalizedString(@"detailInfo", nil) forState:UIControlStateNormal];
    [_detailInfo addTarget:self action:@selector(showDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
    [_guideRoute setBackgroundImage:[TUNinePatchCache imageOfSize:_detailInfo.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [_guideRoute setBackgroundImage:[TUNinePatchCache imageOfSize:_detailInfo.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [_guideRoute setTitle:AMLocalizedString(@"guideRoute", nil) forState:UIControlStateNormal];
    [self valueBinding];
}

- (void)viewDidUnload
{
    [points release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)valueBinding{
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    //[qp prepareDic:(_isFacility)?getFacilityLocationByIds([LoginDataObject sharedInstance].sessionId, _locationId):getLocationById([LoginDataObject sharedInstance].sessionId, _mapId, _locationId)];
    [qp prepareDic:getLocationById([LoginDataObject sharedInstance].sessionId, _mapId, _locationId)];
#ifdef TESTDATA
    [LocationInfoObject targetPosition].pointId=_locationId;
#endif
    [_companyName setText:(NSString*)[qp getValueUnderNode:@"location" withKey:@"name" withIndex:0 withDepth:1]];
    [qp valueBinding:_companyAbstract withKey:@"notes" withIndexArray:0];

    [_detailInfo setTitle:[qp getValue:@"exhibitorId" withIndex:0] forState:UIControlStateReserved];

    points=[[NSMutableArray array] retain];

    NSArray *pointList=[qp getObjectUnderNode:@"pointList" withIndex:0];
    QueryPattern *_tmpQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    for (NSDictionary *dic in pointList) {
        [_tmpQuery prepareDicWithDictionary:dic];
        PointInfoObject *newObject=[[PointInfoObject new] autorelease];
        newObject.pointName=[NSString stringWithString:[_tmpQuery getValue:@"name" withIndex:0]];
        newObject.pointId=[[_tmpQuery getValue:@"pointId" withIndex:0] intValue];
        [points addObject:newObject];
    }
    [_tmpQuery release];
    [qp release];
}
-(IBAction)showRouting:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:CLEAR_COMPANY_WINDOW object:nil];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:points forKey:@"pointsInNoti"];
    [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_POINTS_IN_LOCATION object:nil userInfo:dic];
}
-(IBAction)showDetailInfo:(id)sender{
    UIButton *btn=(UIButton*)sender;
    ExhibitorInfoViewController *infoView = [ExhibitorInfoViewController new];
    [infoView setBackItem:self.parentViewController.title];
    infoView.exhibitorId = [btn titleForState:UIControlStateReserved];
    [self.view removeFromSuperview];
    [self.parentViewController.navigationController pushViewController:[infoView autorelease] animated:YES];
}
@end
