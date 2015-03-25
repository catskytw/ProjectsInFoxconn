//
//  FcNavigationViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcNavigationViewController.h"
#import "FcOverlayViewController.h"
#import "QRCodeReader.h"
#import "MapViewController.h"
#import "FcConfig.h"
#import "DirectionArrowViewController.h"
#import "AStar.h"
#import "UITuneLayout.h"
#import "QRCodeSingletonObject.h"
#import "ExhibitorInfoViewController.h"
#import "LocationInfoObject.h"
#import "LocalizationSystem.h"
#import "BusinessCard_box.h"
#import "TmpViewController.h"
#import "NoCameraViewController.h"
@interface FcNavigationViewController(PrivateMethod)
-(void)showArrowLayer:(NSString*)_uuid;
-(void)showExhibitorDetail:(NSString*)_uuid;
-(void)restartQRCodeScanning;
-(void)runNextViewController:(NSInteger)functionType withUUID:(NSString*)_uuid;
-(void)meetingCheckIn:(NSString*)_uuid;
-(void)nameCardScan:(NSString*)_uuid;
-(void)getNowPointPositionWithUUID:(NSString*)_uuid;
@end
@implementation FcNavigationViewController
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
        FcOverlayViewController *overlay=[FcOverlayViewController new];
        [widController.overlayView addSubview:overlay.view];
        [widController.navigationItem setTitle:@"QRCode"];
        QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *_readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
        [qrcodeReader release];
        widController.readers = _readers;
        [_readers release];
        [self pushViewController:widController animated:YES];
        [UITuneLayout setNaviTitle:widController];
        [widController release];
    }else{
        NoCameraViewController *_tmpController=[NoCameraViewController new];
        _tmpController.title=AMLocalizedString(@"NoCamera", nil);
        [UITuneLayout setNaviTitle:_tmpController];
        [self pushViewController:_tmpController animated:YES];
        [_tmpController release];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)_result{
    NSArray *sepStrings=[_result componentsSeparatedByString:@":"];
    NSLog(@"%@,%@",[sepStrings objectAtIndex:0],[sepStrings objectAtIndex:1]);
    @try {
        if([QRCodeSingletonObject current].functionType==-1){
            [QRCodeSingletonObject current].functionType=[[sepStrings objectAtIndex:0] intValue];
        }
        if ([[sepStrings objectAtIndex:0] intValue]==4 && [QRCodeSingletonObject current].functionType!=4) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"Not Allow function", nil) message:AMLocalizedString(@"Not Allow function", nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"close", nil) otherButtonTitles:nil];
            [alert show];
            return;
        }
        [self runNextViewController:[QRCodeSingletonObject current].functionType withUUID:[sepStrings objectAtIndex:1]];
    }
    @catch (NSException *exception) {
        NSLog(@"parsing qrcode string error");
        if([QRCodeSingletonObject current].functionType==5){
            [self.tabBarController setSelectedIndex:0];
        }else
        {
            [self restartQRCodeScanning];
        }
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"login_err_alert_title", nil) message:AMLocalizedString(@"qrcode_error", nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"close", nil) otherButtonTitles:nil];
        [alert show];
    }
    @finally {
        [QRCodeSingletonObject current].functionType=-1;
    }
}


- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
    NSLog(@"cancel decoder");
}

#pragma mark - PrivateMethod
-(void)restartQRCodeScanning{
    //ugly
    TmpViewController *_tmpController=[TmpViewController new];
    [self pushViewController:_tmpController animated:NO];
    [_tmpController release];
}

-(void)runNextViewController:(NSInteger)functionType withUUID:(NSString*)_uuid{
    /**
     1.//附近設施
     2.//會議報到
     3.//廠商資訊
     4.//名片掃描
     5.//目前位置
     */
    switch (functionType) {
        case 1:
            [self showArrowLayer:_uuid];
            break;
            /*
        case 2:
            [self meetingCheckIn:_uuid];
            break;
             */
        case 3:
            [self showExhibitorDetail:_uuid];
            break;
        case 4:
            [self nameCardScan:_uuid];
            break;
        case 5:
            [self getNowPointPositionWithUUID:_uuid];
            break;
        default:
            [self restartQRCodeScanning];
            break;
    }
}

//顯示附近設施
-(void)showArrowLayer:(NSString*)_uuid{
    MapDAO *mapdao=[MapDAO new];
    LocationInfoObject *locationInfo=[mapdao fetchLocationFromUUID:_uuid];
    [LocationInfoObject nowPosition].name=[NSString stringWithString:locationInfo.name];
    [LocationInfoObject nowPosition].mapId=[NSString stringWithString:locationInfo.mapId];
    [LocationInfoObject nowPosition].locationId=[NSString stringWithString:locationInfo.locationId];
    
    MapViewController *newMapView=[MapViewController current];
    [newMapView settingFloor:[locationInfo.mapId intValue]];
    
    FeatureCtrlCollections *featureCtrl=[FeatureCtrlCollections current];
    [featureCtrl loadMapData:[locationInfo.mapId intValue]];
    NSString *locationId=locationInfo.locationId;
    CGFloat width=featureCtrl.locationIdxCtrl.cellColumn*featureCtrl.locationIdxCtrl.cellWidth;
    CGFloat height=featureCtrl.locationIdxCtrl.cellRow*featureCtrl.locationIdxCtrl.cellHeight;
    CGFloat startX=featureCtrl.locationIdxCtrl.startX;
    CGFloat startY=featureCtrl.locationIdxCtrl.startY;
    MapFeature *basePoint=[[FeatureCtrlCollections current].pointDataCtrl getFeatureObject:[locationId intValue] withFeatureType:FeatureTypePoint];
    
    CGPoint _basePoint=[[basePoint.points objectAtIndex:0] CGPointValue];
    DirectionArrowViewController *arrowView=[DirectionArrowViewController new];
    arrowView._preMapViewController=newMapView;
    arrowView.view.center=CGPointMake(arrowView.view.center.x, arrowView.view.center.y+20);
    [self.tabBarController.view addSubview:arrowView.view];
    [newMapView setBackItem:@"QRCode"];
    [self pushViewController:newMapView animated:YES];
    [arrowView drawDirectionArrow:CGRectMake(startX, startY, width, height) withStandingPosition:_basePoint];
    [mapdao release];
}

//廠商資訊
-(void)showExhibitorDetail:(NSString*)_uuid{
    MapDAO *mapdao=[MapDAO new];
    NSString *_exhibitorId=[mapdao getExhibitorIdFromUUID:_uuid];
    [mapdao release];
    ExhibitorInfoViewController *infoView = [ExhibitorInfoViewController new];
    [infoView setBackItem:@"QRCode"];
    infoView.exhibitorId = _exhibitorId;
    [self pushViewController:[infoView autorelease] animated:YES];
}

//會議報到
-(void)meetingCheckIn:(NSString*)_uuid{
    BOOL checkInSuccess=YES;
    NSString *resultString=(checkInSuccess)?AMLocalizedString(@"checkInSuccess", nil):AMLocalizedString(@"checkInFailed", nil);
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"checkInResult", nil) message:resultString delegate:self cancelButtonTitle:nil otherButtonTitles:AMLocalizedString(@"close", nil),nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self restartQRCodeScanning];
}

//名片掃瞄
-(void)nameCardScan:(NSString*)_uuid{
    NSString *r=[[QRCodeSingletonObject current] addFriendNameCard:_uuid];
    if([r isEqualToString:@"exist"]){
        UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"revert_err_title", nil) message:@"addNameCardFailure" delegate:self cancelButtonTitle:nil  otherButtonTitles:AMLocalizedString(@"close", nil),nil] autorelease];
        [alert show];
        return;
    }
    BusinessCard_box *businessCardBox=[[BusinessCard_box alloc] initWithCardId:r];
    [businessCardBox setBackItem:@"QRCode"];
    [self pushViewController:businessCardBox animated:YES];
    [businessCardBox release];
}

//取得目前位置
-(void)getNowPointPositionWithUUID:(NSString*)_uuid{
    MapDAO *mapdao=[MapDAO new];
    LocationInfoObject *pointInfo=[mapdao fetchLocationFromUUID:_uuid];
    NSLog(@"%@,%@,%@,%@",pointInfo.name,pointInfo.locationId,pointInfo.mapId,pointInfo.pointId);
    [LocationInfoObject nowPosition].name= pointInfo.name;
    [LocationInfoObject nowPosition].locationId= pointInfo.locationId;
    [LocationInfoObject nowPosition].mapId= pointInfo.mapId;
    [LocationInfoObject nowPosition].pointId= pointInfo.pointId;
    [[NSNotificationCenter defaultCenter] postNotificationName:MAKE_ROUTEING object:nil];
    [self.tabBarController setSelectedIndex:0];
    [mapdao release];
}
#pragma -
@end
