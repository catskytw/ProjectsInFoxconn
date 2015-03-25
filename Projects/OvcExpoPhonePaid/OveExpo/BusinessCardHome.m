 //
//  BusinessCardHome.m
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCardHome.h"
#import "BusinessCard_MyInfoEditor.h"
#import "BusinessCard_list.h"

#import "NSData+base64.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"

#import "FcResourceUtility.h"

@interface BusinessCardHome(PrivateMethod)
- (void)setCardBoxButton;
@end

@implementation BusinessCardHome
@synthesize qr_CodeImg, seperateImg, label1, editBut;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setRightItem:AMLocalizedString(@"名片盒",nil)];
    }
    return self;
}
-(id)init{
    if((self=[super init])){
        [self setRightItem:AMLocalizedString(@"名片盒",nil)];
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
-(void) prepareData
{
    if (MY_TEST == YES) {
        fullname = @"李大光";
        //UIImage *_image = [TUNinePatchCache imageOfSize:qr_CodeImg.frame.size forNinePatchNamed:@"btn_content"];
        //myBarcodeData = UIImageJPEGRepresentation(_image, 1.0);
    }
    else
    {
        //XXXX
        NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            fullname = [_login nickName];
            
            //getQRCode
            //[query prepareDic:getQRCode(_login.sessionId)];
            NSLog(@"qrcode=%@", getQRCode(_login.sessionId));
            NSURL *_url = [NSURL URLWithString:getQRCode(_login.sessionId)];
            NSData *_data = [NSData dataWithContentsOfURL:_url];
            if (_data != nil) {
                myBarcodeData = _data;
            }
            //convert base64 to NSData.
            /*if ([card.image length] > 0) {
                NSData *content = [NSData dataFromBase64String:card.image];
                [photo_but setImage:[UIImage imageWithData:content] forState:UIControlStateNormal];
            }
            eventData = */
            //returnArray = [tmpArray retain];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
    [self setTitle:AMLocalizedString(@"我的名片",nil)];
    [UITuneLayout setNaviTitle:self];
    //[self setCardBoxButton];
    [self setRightItem:AMLocalizedString(@"名片盒_bt",nil)];
    
    //set QR code
    
    [qr_CodeImg setImage:[UIImage imageWithData:myBarcodeData]];
    
    //separate line
    [seperateImg setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    
    //set sub title
    [label1 setText:[NSString stringWithFormat:@"%@%@", fullname, AMLocalizedString(@"的名片",nil)]];
    
    //set edit button
    [editBut setBackgroundImage:[TUNinePatchCache imageOfSize:editBut.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [editBut setBackgroundImage:[TUNinePatchCache imageOfSize:editBut.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [editBut setTitle:AMLocalizedString(@"編輯我的名片",nil) forState:UIControlStateNormal];
    [editBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editBut setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    //[editBut setFrame:CGRectMake(85, 300, 151, 37)];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [goListBut setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [goListBut setHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Utilties
-(void)rightItemAction:(id)sender
{
    NSLog(@"名片盒...2");
    BusinessCard_list *_cardListCtrl = [[BusinessCard_list alloc]init];
    [_cardListCtrl setBackItem:AMLocalizedString(@"返回",nil)];
    [[self navigationController] pushViewController:_cardListCtrl animated:YES];
    [_cardListCtrl autorelease];
    
    //For self test.
    //[FcResourceUtility updateResources];
}

-(void)setCardBoxButton{
    goListBut = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	goListBut.frame = CGRectMake(245.0, 7.0, 65, 30);
    goListBut.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [goListBut setBackgroundImage:
     [TUNinePatchCache imageOfSize:goListBut.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [goListBut setBackgroundImage:[TUNinePatchCache imageOfSize:goListBut.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    
	[goListBut addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:goListBut];
    [goListBut setTitle:AMLocalizedString(@"名片盒",nil) forState:UIControlStateNormal];
    [goListBut setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}

-(void)editAction:(id)sender{
	
	if(sender == goListBut){
		NSLog(@"名片盒...");
        [goListBut setHidden:YES];
        BusinessCard_list *_cardListCtrl = [[BusinessCard_list alloc]init];
        [_cardListCtrl setBackItem:AMLocalizedString(@"返回",nil)];
        [[self navigationController] pushViewController:_cardListCtrl animated:YES];
        [_cardListCtrl autorelease];
	}
	
}

-(IBAction)editMyBusinessCard:(id)sender
{
    NSLog(@"trigger editMyBusinessCard...");
    /*if (editor == nil) {
        editor = [[BusinessCard_MyInfoEditor alloc]init];
    }*/
    //BusinessCard_MyInfoEditor *_editor = [[[BusinessCard_MyInfoEditor alloc]init]autorelease];
    BusinessCard_MyInfoEditor *_editor = [[BusinessCard_MyInfoEditor alloc]init];
    [_editor setBackItem:AMLocalizedString(@"返回",nil)];
    [_editor setRightItem2:AMLocalizedString(@"完成",nil)];
    [[self navigationController] pushViewController:_editor animated:YES];
    [_editor autorelease];
    
}

-(IBAction)cardList:(id)sender
{
    NSLog(@"trigger cardList...");
}

@end
