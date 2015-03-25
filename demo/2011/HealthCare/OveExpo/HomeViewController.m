//
//  HomeViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "FcDrawing.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "HomeButtonDataObject.h"
#import "UITuneLayout.h"

@interface HomeViewController(PrivateMethod)
-(void)tuneButtonsInMainView:(NSArray*)buttonObjects;
-(void)fcViewControllerSetting:(FcViewController*)_target;
@end
@implementation HomeViewController
@synthesize topBarViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _buttons=[[NSMutableArray array] retain];
    
    [topBarViewController setImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 50) forNinePatchNamed:@"img_actionbar"]];
    
    NSArray *buttonObjects=[NSArray arrayWithObjects:
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"distanceCare", nil) withImage:@"ic_uho.png" withTag:0],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"serviceIntro", nil) withImage:@"ic_services.png" withTag:1],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"register", nil) withImage:@"ic_registrator.png" withTag:2],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"cooperators", nil) withImage:@"ic_partners.png" withTag:3],
                            nil];

    [self tuneButtonsInMainView:buttonObjects];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    if (serviceIntroView) {
        [serviceIntroView release];
        serviceIntroView = nil;
    }
    [_buttons release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        return YES;
    return NO;
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =YES;
}
#pragma -
#pragma mark - ActionMethod
-(void)buttonAction:(id)sender{
    UIButton *m_btn=(UIButton*)sender;
    //借用tag來辨認按下哪個按鍵.
    switch (m_btn.tag) {
        case 0: //遠距照護
            distanceCare=[DistanceCareViewController new];
            distanceCare.title=AMLocalizedString(@"distanceCare", nil);
            [self fcViewControllerSetting:distanceCare];
            break;
        case 1: //服務簡介
            if (serviceIntroView ==nil) {
                serviceIntroView  = [ServiceIntroViewController new];
            }
            [self.navigationController pushViewController:serviceIntroView animated:YES];
            break;
        case 2: //線上掛號
            hospitalList=[HospitalList new];
            hospitalList.title=AMLocalizedString(@"register", nil);
            [self fcViewControllerSetting:hospitalList];
            break;
        case 3: //合作機構
            cooperators=[CooperatorCategoryList new];
            cooperators.title=AMLocalizedString(@"cooperators", nil);
            [self fcViewControllerSetting:cooperators];
            break;
        default:
            break;
    }
}
#pragma -
#pragma mark - PrivateMethod
-(void)tuneButtonsInMainView:(NSArray*)buttonObjects{
    NSInteger counter=0;
    
    CGFloat xStart=15.0f;
    CGFloat xSpace=87+xStart;
    CGFloat yStart=60;
    CGFloat ySpace=103+13;
    for (HomeButtonDataObject *thisObject in buttonObjects) {
        NSInteger column=counter%3;
        NSInteger row=floor((double)counter/3.0f);
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=thisObject.tag;
        [_buttons addObject:btn];
        [btn setImage:[UIImage imageNamed:thisObject.imageFileName]  forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(xStart+column*xSpace, yStart+row*ySpace, 87, 103)];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(xStart+column*xSpace, 87+yStart+row*ySpace, 87, 12)];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:DefaultFontName size:12.0f]];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setText:thisObject.title];
        [self.view addSubview:label];
        [label release];
        
        counter++;
    }
}

-(void)fcViewControllerSetting:(FcViewController*)_target{
    [_target setBackItem:AMLocalizedString(@"back", nil)];
    [self.navigationController pushViewController:_target animated:YES];
    self.navigationController.navigationBarHidden=NO;
}
#pragma -
@end