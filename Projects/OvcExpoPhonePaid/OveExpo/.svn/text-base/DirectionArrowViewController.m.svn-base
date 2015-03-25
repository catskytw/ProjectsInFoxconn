//
//  DirectionArrowViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DirectionArrowViewController.h"
#import "DirectionArrowCaculator.h"
#import "Coordination.h"
#import "MapFeature.h"
#import "MapPoint.h"
#import "UserInfoButton.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "NinePatch.h"
#import "AStar.h"
@interface DirectionArrowViewController(PrivateMethod)
-(void)slidePickerView;
-(void)findFacility;
-(NSString*)getFacilityName:(NSInteger)bitmapId;
@end
@implementation DirectionArrowViewController
@synthesize mainView,selectTargetView;
@synthesize selectTitleImageView,cancelSelectBtn,completeSelectBtn,pointPicker,_preMapViewController,personView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndex=0;
    pickerData=[[NSMutableArray array]retain];
    allowArrowTouch=YES;
    isOpenSelectView=NO;
    [selectTargetView setFrame:CGRectMake(0, 460, selectTargetView.frame.size.width, selectTargetView.frame.size.height)];
    [self.view addSubview:selectTargetView];
    [self.cancelSelectBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelSelectBtn.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [self.cancelSelectBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelSelectBtn.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    [self.completeSelectBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelSelectBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    [self.completeSelectBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelSelectBtn.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
    [self.completeSelectBtn setTitle:AMLocalizedString(@"submit", nil) forState:UIControlStateNormal];
    [self.cancelSelectBtn setTitle:AMLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [selectTitleImageView setImage:[TUNinePatchCache imageOfSize:selectTitleImageView.frame.size forNinePatchNamed:@"img_actionbar"]];
    personView.frame=fixBlurryRect(personView.frame);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [pickerData release];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[arrowContentArray release];
    [super dealloc];
}

-(void)drawDirectionArrow:(CGRect)rangRect withStandingPosition:(CGPoint)standPoint{
	//label貼在箭頭時,向下調整值
	//加入各個不同方向之key,object,由正北,每45度為一類
	DirectionArrowCaculator *caculator=[[DirectionArrowCaculator alloc]initWithRadius:110];
	arrowContentArray=[[caculator searchFeaturePointInArea:rangRect withStandingPoint:standPoint]retain];
	
	NSArray *allKeys=[arrowContentArray allKeys];
	
	for(NSString *key in allKeys){
		NSMutableArray *facilityForThisKey=[arrowContentArray valueForKey:key];
		UserInfoButton *arrowSprite=[UserInfoButton buttonWithType:UIButtonTypeCustom];
		
		if([facilityForThisKey count]>0)
			([facilityForThisKey count]>1)?[arrowSprite setBackgroundImage:[UIImage imageNamed:@"arrow_multi.png"] forState:UIControlStateNormal]:[arrowSprite setBackgroundImage:[UIImage imageNamed:@"arrow_single.png"] forState:UIControlStateNormal];
		else
			continue;
        
        UILabel *thisArrowLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 137, 128)]autorelease];
        [thisArrowLabel setTextAlignment:UITextAlignmentCenter];
        [thisArrowLabel setTextColor:[UIColor whiteColor]];
        [thisArrowLabel setBackgroundColor:[UIColor clearColor]];
        [thisArrowLabel setFont:[UIFont fontWithName:DefaultFontName size:19]];
        [thisArrowLabel setNumberOfLines:4];
		if([facilityForThisKey count]==1){
			//該物件資料
			MapFeature *thisFeature=(MapFeature*)[facilityForThisKey objectAtIndex:0];
			MapPoint *thisFeatureStyleObject=(MapPoint*)thisFeature.styleObject;
            [thisArrowLabel setText:[self getFacilityName:thisFeatureStyleObject.bmpId]];			
		}else if([facilityForThisKey count]>1)
            [thisArrowLabel setText:@"多\n种\n设\n施"];

		arrowSprite.userinfo=[NSMutableArray arrayWithArray:facilityForThisKey];

		Coordination *thisLocation=(Coordination*)[caculator.directionArrowPoint objectAtIndex:[key intValue]];

		[arrowSprite setFrame:CGRectMake(160+thisLocation.x, 231+thisLocation.y, 137, 128)];
		[arrowSprite setCenter:CGPointMake(160+thisLocation.x, 231+thisLocation.y)];
		arrowSprite.transform=CGAffineTransformMakeRotation([key intValue]*(M_PI/4));
		[arrowSprite addTarget:self action:@selector(pressArrow:) forControlEvents:UIControlEventTouchUpInside];

        [arrowSprite addSubview:thisArrowLabel];
		[mainView addSubview:arrowSprite];
	}
	[caculator release];
}
-(IBAction)closeThisView:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}

-(IBAction)pressArrow:(id)sender{
    selectedIndex=0;
    UserInfoButton *_userInfoBtn=(UserInfoButton*)sender;
    NSMutableArray* userInfo=(NSMutableArray*)_userInfoBtn.userinfo;
    NSMutableString *idString=[NSMutableString string];
    int count=0;
    for (MapFeature *feature in userInfo) {
        if(count==0)
            [idString appendFormat:@"%d",feature.featureId];
        else
            [idString appendFormat:@",%d",feature.featureId];
        count++;
    }
    MapDAO *mapdao=[MapDAO new];
    [pickerData removeAllObjects];
    [pickerData addObjectsFromArray:[mapdao getFacilityLocationByIds:idString]];
    
    if([userInfo count]>1){
        [pointPicker reloadAllComponents];
        [self slidePickerView];
        
    }else{
        [self findFacility];
    }
    [mapdao release];
}

#pragma mark - DelegateMethod
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    LocationInfoObject *thisObject=[pickerData objectAtIndex:row];
    return thisObject.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedIndex=row;
}
#pragma --

#pragma mark - Action
-(IBAction)cancelAction:(id)sender{
    [self slidePickerView];
}
-(IBAction)completeAction:(id)sender{
    [self slidePickerView];
    [self findFacility];
}
-(void)findFacility{
    LocationInfoObject *thisObject=(LocationInfoObject*)[pickerData objectAtIndex:selectedIndex];
    [[FeatureCtrlCollections current] loadMapData:[thisObject.mapId intValue]];
    [_preMapViewController settingFloor:[thisObject.mapId intValue]];
    [_preMapViewController showExhibitorInfo:thisObject.locationId isFacility:YES];
    [self closeThisView:nil];
}
#pragma --

#pragma makr - PrivateMethod
-(void)slidePickerView{
    const int yVar=(isOpenSelectView)?260:-260;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [selectTargetView setFrame:CGRectMake(selectTargetView.frame.origin.x, selectTargetView.frame.origin.y+yVar, selectTargetView.frame.size.width, selectTargetView.frame.size.height)];
    [UIView commitAnimations];
    
    isOpenSelectView=!isOpenSelectView;
}

-(NSString*)getFacilityName:(NSInteger)bitmapId{
    NSString *r=@"";
    switch (bitmapId) {
        case 1:
            r=@"电\n梯";
            break;
        case 2:
            r=@"卫\n生\n间";
            break;
        case 3:
            r=@"洗\n手\n间";
            break;
        case 4:
            r=@"就\n餐\n区";
            break;
        case 5:
            r=@"交\n通\n廊";
            break;
        case 6:
            r=@"休\n息\n区";
            break;
        case 7:
            r=@"媒\n体\n中\n心";
            break;
        case 8:
            r=@"商\n务\n洽\n谈";
            break;
        case 9:
            r=@"商\n务\n中\n心";
            break;
        case 10:
            r=@"推\n介\n会";
            break;
        case 11:
            r=@"男\n洗\n手\n间";
            break;
        case 12:
            r=@"女\n洗\n手\n间";
            break;
        case 13:
            r=@"出\n入\n口";
            break;
        case 14:
            r=@"手\n扶\n电\n梯";
            break;
        case 15:
            r=@"接\n待\n室";
            break;
        case 16:
            r=@"门\n厅";
            break;
        case 17:
            r=@"会\n议\n室";
            break;
        case 18:
            r=@"公\n司\n超\n市";
            break;
        case 19:
            r=@"光\n谷\n展\n厅";
            break;
        case 20:
            r=@"服\n务\n处";
            break;
        case 21:
            r=@"观\n光\n电\n梯";
            break;
        case 22:
            r=@"参\n观\n登\n录";
            break;
        default:
            r=@"其\n他\n设\n施";
            break;
    }
    return r;
}
#pragma --

@end
