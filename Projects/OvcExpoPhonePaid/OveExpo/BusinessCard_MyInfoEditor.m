//
//  BusinessCard_MyInfoEditor.m
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard_MyInfoEditor.h"
#import "BusinessCard_Cell2.h"
#import "FcPickerController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSData+base64.h"
#import "SBJsonWriter.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "FcDrawing.h"

@interface BusinessCard_MyInfoEditor(PrivateMethod)
- (void) prepareData;
- (BOOL) _getCardInfo:(NSString *)result;
- (void) setBackButton;
- (void) setCardBoxButton;
- (void) maintainCellColor:(NSInteger)newIndex;
-(void) _updatePhoto;
@end

@implementation BusinessCard_MyInfoEditor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithCardId:(NSString *)_cardId
{
    cardId = _cardId;
    return [self initWithNibName:nil bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
    [super dealloc];
    [detailTable release];
    [card release];
    [card_table_map release];
    [field_row_map release];
    [card_fields_name release];
    [card_fields_value release];
}

#pragma mark - View lifecycle
-(void) initCountry{
    //countryArray = [NSMutableArray new];
    if (MY_TEST == YES) {
        countryDic = [NSMutableDictionary new];
        [countryDic setValue:@"台灣" forKey:@"台灣"];
        [countryDic setValue:@"日本" forKey:@"日本"];
        [countryDic setValue:@"中國" forKey:@"中國"];
        [countryDic setValue:@"美國" forKey:@"美國"];
        [countryDic setValue:@"香港" forKey:@"香港"];
        [countryDic setValue:@"英國" forKey:@"英國"];
        [countryDic setValue:@"韓國" forKey:@"韓國"];
        [countryDic setValue:@"馬來西亞" forKey:@"馬來西亞"];
        [countryDic setValue:@"新加坡" forKey:@"新加坡"];
        [countryDic setValue:@"法國" forKey:@"法國"];
        [countryDic setValue:@"日本" forKey:@"日本"];
        [countryDic setValue:@"中國" forKey:@"中國"];
    }
    else
    {
        countryDic = [NSMutableDictionary new];
        QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        
        [accountQuery prepareDic:getCountryList];
        
        @try {
            if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                int number = [accountQuery getNumberForKey:@"id"];
                for (int i=0; i< number  ; i++) {
                    [countryDic setObject:[accountQuery getValue:@"id" withIndex:i] forKey:[accountQuery getValue:@"name" withIndex:i]];
                    NSLog(@"id=%@, name=%@", [accountQuery getValue:@"id" withIndex:i], [accountQuery getValue:@"name" withIndex:i]);
                }
            }else{
                
                
            }
            
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
            [accountQuery release];
        }
    }
    
    
    /*[countryArray addObject:@"台灣"];
     [countryArray addObject:@"日本"];
     [countryArray addObject:@"中國"];
     [countryArray addObject:@"美國"];
     [countryArray addObject:@"香港"];
     [countryArray addObject:@"英國"];
     [countryArray addObject:@"韓國"];
     [countryArray addObject:@"馬來西亞"];
     [countryArray addObject:@"新加坡"];
     [countryArray addObject:@"法國"];
     [countryArray addObject:@"台灣"];
     [countryArray addObject:@"日本"];
     [countryArray addObject:@"中國"];*/
    
    
}

-(void) prepareData
{
    card_table_map = [[NSMutableDictionary alloc]init];
    field_row_map = [[NSMutableDictionary alloc]init];
    card_fields_name = [[NSMutableArray alloc]init];
    card_fields_value = [[NSMutableArray alloc]init];
    card = [[BusinessCard alloc]init];
    
    if (MY_TEST == YES) {
        //UIImage *_image = [TUNinePatchCache imageOfSize:photo_but.frame.size forNinePatchNamed:@"btn_content"];
        //card.image = UIImageJPEGRepresentation(_image, 1.0);
        card.fullName = @"胡智宇";
        card.firstName = @"智宇";
        card.lastName = @"胡";
        card.company = @"鴻海";
        card.title = @"高級勞工";
        card.company_addr = @"欄位資料";
        card.department = @"欄位資料";
        card.phone_num = @"欄位資料";
        card.fax_num = @"欄位資料";
        card.email = @"欄位資料";
        card.url = @"欄位資料";
        
        //init card fields.
        /*for (int i=0; i<12; i++) {
         [card_fields_name addObject:[NSString stringWithFormat:@"欄位%d",i]];
         [card_fields_value addObject:[NSString stringWithFormat:@"資料%d",i]];
         }*/
    }
    else
    {
        //XXXX
        NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            NSString *_queryStr = getMyBusinessCard(_login.sessionId);
            _queryStr = [_queryStr stringByAppendingFormat:@"&rnd=%i",arc4random()];
            [query prepareDic:_queryStr];
            //NSArray* dateList=(NSArray*)[query getObjectUnderNode:@"dateList" withIndex:0];
            
            card.firstName = @"";
            card.lastName = @"";
            card.image = nil;
            card.company = @"";
            card.company_addr = @"";
            card.phone_num = @"";
            card.fax_num = @"";
            card.title = @"";
            card.department = @"";
            card.email = @"";
            card.mobilePhone_num = @"";
            card.url = @"";
            
            NSString *eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"id" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.cardId = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"firstName" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.firstName = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"lastName" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.lastName  = eventData;
            }
            
            
            /*eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"qrCode" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.image = [NSData dataFromBase64String:eventData];
            }*/
            
            //getValueFromNodeString
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"id" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].id"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.companyId = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"name" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].name"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.company  = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"countryId" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].countryId"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.countryId  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"countryName" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].countryId"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.countryName  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"province" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].countryId"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.province  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"city" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].countryId"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.city  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"phone" withIndex:0];
            //eventData=(NSString*)[query getValueFromNodeString:@"businessCard[0].company[0].phone"];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.phone_num  = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"fax" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.fax_num  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"address" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.company_addr  = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"jobTitle" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.title = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"department" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.department = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"mail" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.email = eventData;
            }
            
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"mobile" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.mobilePhone_num = eventData;
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"businessCard" withKey:@"photo" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                //card.photo_url ＝[NSString  stringWithFormat:@"%@%@", URLPREFIX, eventData];
                NSLog(@"photo eventData=%@", eventData);
                card.photo_url = [URLPREFIX stringByAppendingFormat:eventData];
                NSLog(@"photo_url=%@", card.photo_url);
                NSURL *_url = [NSURL URLWithString:card.photo_url];
                NSData *_data = [NSData dataWithContentsOfURL:_url];
                if (_data != nil) {
                    card.image = _data;
                }
            }
            
            eventData=(NSString*)[query getValueUnderNode:@"company" withKey:@"website" withIndex:0];
            if (eventData != nil && ![eventData isEqualToString:@"-"] && ![eventData isEqualToString:@"null"]) {
                card.url = eventData;
            }
            card.fullName = [card.firstName stringByAppendingFormat:card.lastName];
            
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
    }
    
    [self initCountry];
    //NSData *content = UIImageJPEGRepresentation(card.image, 1.0);
    //NSData *content = card.image;
    [card_fields_name addObject:AMLocalizedString(@"姓",nil)];
    [card_fields_name addObject:AMLocalizedString(@"名",nil)];
    [card_fields_name addObject:AMLocalizedString(@"公司名稱",nil)];
    [card_fields_name addObject:AMLocalizedString(@"部門",nil)];
    [card_fields_name addObject:AMLocalizedString(@"職業/職位",nil)];
    [card_fields_name addObject:AMLocalizedString(@"國家",nil)];
    [card_fields_name addObject:AMLocalizedString(@"省份",nil)];
    [card_fields_name addObject:AMLocalizedString(@"城市",nil)];
    [card_fields_name addObject:AMLocalizedString(@"公司地址",nil)];
    [card_fields_name addObject:AMLocalizedString(@"電話",nil)];
    [card_fields_name addObject:AMLocalizedString(@"傳真",nil)];
    [card_fields_name addObject:AMLocalizedString(@"電郵",nil)];
    [card_fields_name addObject:AMLocalizedString(@"手機",nil)];
    [card_fields_name addObject:AMLocalizedString(@"網址",nil)];
    
    
    [card_table_map setValue:card.lastName forKey:AMLocalizedString(@"姓",nil)];
    [card_table_map setValue:card.firstName forKey:AMLocalizedString(@"名",nil)];
    [card_table_map setValue:card.company forKey:AMLocalizedString(@"公司名稱",nil)];
    [card_table_map setValue:card.department forKey:AMLocalizedString(@"部門",nil)];
    [card_table_map setValue:card.title forKey:AMLocalizedString(@"職業/職位",nil)];
    [card_table_map setValue:card.countryName forKey:AMLocalizedString(@"國家",nil)];
    [card_table_map setValue:card.province forKey:AMLocalizedString(@"省份",nil)];
    [card_table_map setValue:card.city forKey:AMLocalizedString(@"城市",nil)];
    [card_table_map setValue:card.company_addr forKey:AMLocalizedString(@"公司地址",nil)];
    [card_table_map setValue:card.phone_num forKey:AMLocalizedString(@"電話",nil)];
    [card_table_map setValue:card.fax_num forKey:AMLocalizedString(@"傳真",nil)];
    [card_table_map setValue:card.email forKey:AMLocalizedString(@"電郵",nil)];
    [card_table_map setValue:card.mobilePhone_num forKey:AMLocalizedString(@"手機",nil)];
    [card_table_map setValue:card.url forKey:AMLocalizedString(@"網址",nil)];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:AMLocalizedString(@"編輯我的名片",nil)];
    [UITuneLayout setNaviTitle:self];
    [[self navigationItem] setHidesBackButton:YES];
    
    // Do any additional setup after loading the view from its nib.
    [self prepareData];
    
    //計算出最長title的字串長度, 用來作輸入框的對齊
    for (int i=0; i<[card_fields_name count]; i++) {
        NSString *_field = [card_fields_name objectAtIndex:i];
        CGSize tmpSize = [_field sizeWithFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
        if (tmpSize.width > titleMaxSize.width) {
            titleMaxSize = tmpSize;
        }
    }
    //[separate1_img setImage:[TUNinePatchCache imageOfSize:separate1_img.frame.size forNinePatchNamed:@"group_table"]];
    [detailTable setFrame:CGRectMake(detailTable.frame.origin.x, detailTable.frame.origin.y, detailTable.frame.size.width, detailTable.rowHeight*[card_fields_name count])];
    [baseScroll setContentSize:CGSizeMake(self.view.frame.size.width, detailTable.frame.origin.y + detailTable.frame.size.height+250)];
    //[baseScroll setContentSize:CGSizeMake(self.view.frame.size.width, detailTable.frame.origin.y + detailTable.frame.size.height)];
    detailTable.backgroundView = [[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:detailTable.frame.size forNinePatchNamed:@"group_table"]]autorelease];
    
    //設定大頭貼
    /*photo_img = [[UIImageView alloc]init];
    [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
    [photo_but.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [photo_but.titleLabel setTextAlignment:UITextAlignmentCenter];
    [photo_but setTitle:@"新增\n照片" forState:UIControlStateNormal];
    [photo_but addSubview:photo_img];
    if ([card.image length] > 0) {
        UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
        UIImage *img_pic = [UIImage imageWithData:card.image];
        [photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
        
    }*/
    //設定大頭貼2 : 依等比例縮小
    [self _updatePhoto];
    /*photo_img = [[UIImageView alloc]init];
    [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
    [photo_but.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [photo_but.titleLabel setTextAlignment:UITextAlignmentCenter];
    [photo_but setTitle:@"新增\n照片" forState:UIControlStateNormal];
    [photo_but addSubview:photo_img];
    if ([card.image length] > 0) {
        UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
        UIImage *img_pic = [UIImage imageWithData:card.image];
        NSInteger image_w = [img_pic size].width;
        NSInteger image_h = [img_pic size].height;
        NSInteger max_length=0;
        if (image_w > image_h) {
            max_length = image_w;
        }
        else
        {
            max_length = image_h;
        }
        CGFloat scale= photo_but.frame.size.width/max_length;
        //[photo_img setFrame:CGRectMake(0, 0, image_w*scale, image_h*scale)];
        [photo_img setFrame:CGRectMake((photo_but.frame.size.width-image_w*scale)/2, (photo_but.frame.size.height-image_h*scale)/2, image_w*scale, image_h*scale)];
        photo_img.frame=fixBlurryRect(photo_img.frame);
        if (image_w>53 && image_h>53) {
            [photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
        }
        else
        {
            [photo_img setImage:[UIImage imageWithData:card.image]];
        }
        
    }
    [photo_img autorelease];*/
    
    //Setup picker
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    [submitBtn setBackgroundImage:[TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
    [titleImg setImage:[TUNinePatchCache imageOfSize:titleImg.frame.size forNinePatchNamed:@"img_actionbar"]];
    //pickerBaseView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin ;
    [pickerBaseView setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [card_table_map removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    //[[self navigationItem] setHidesBackButton:YES];
    //[self setBackButton];
    //[self setCardBoxButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [backButton removeFromSuperview];
    [backButton release];
    [okBut removeFromSuperview];
    [okBut release];
    
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 resignFirstResponder];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void) _updatePhoto
{
    [photo_img removeFromSuperview];
    photo_img = [[UIImageView alloc]init];
    [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
    [photo_but.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [photo_but.titleLabel setTextAlignment:UITextAlignmentCenter];
    [photo_but setTitle:[NSString stringWithFormat:@"%@\n%@",AMLocalizedString(@"新增",nil),AMLocalizedString(@"照片",nil)] forState:UIControlStateNormal];
    [photo_but addSubview:photo_img];
    if ([card.image length] > 0) {
        UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
        UIImage *img_pic = [UIImage imageWithData:card.image];
        NSInteger image_w = [img_pic size].width;
        NSInteger image_h = [img_pic size].height;
        if (image_w > photo_but.frame.size.width) {
            image_w = photo_but.frame.size.width;
        }
        if (image_h > photo_but.frame.size.height) {
            image_h = photo_but.frame.size.height;
        }
        [photo_img setFrame:CGRectMake((photo_but.frame.size.width-image_w)/2, (photo_but.frame.size.height-image_h)/2, image_w, image_h)];
        photo_img.frame=fixBlurryRect(photo_img.frame);
        if (image_w>53 && image_h>53) {
            [photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
        }
        else
        {
            [photo_img setImage:[UIImage imageWithData:card.image]];
        }
        
    }
    [photo_img autorelease];
}
-(NSString *) prepareUserJsonForBusinessCardEditor
{
    NSMutableDictionary *json_user = [[[NSMutableDictionary alloc] init]autorelease];
    /*if (card.image != nil) {
        NSString *_photo = [card.image base64EncodedString];
        [json_user setValue:_photo forKey:@"image"];
    }*/
    
    [json_user setValue:card.cardId forKey:@"id"];
    [json_user setValue:card.nickName forKey:@"nickname"];
    [json_user setValue:card.firstName forKey:@"firstName"];
    [json_user setValue:card.lastName forKey:@"lastName"];
    [json_user setValue:card.sex forKey:@"sex"];
    [json_user setValue:card.title forKey:@"jobTitle"];
    [json_user setValue:card.department forKey:@"department"];
    [json_user setValue:card.mobilePhone_num forKey:@"mobile"];
    [json_user setValue:card.email forKey:@"mail"];
    
    SBJsonWriter *parser = [[SBJsonWriter alloc] init];
    NSString * json_Str = [parser stringWithObject:json_user];
    NSLog(@"Reach : json = %@", json_Str);
    return json_Str;
}

-(NSString *) prepareCompanyJsonForBusinessCardEditor
{
    NSMutableDictionary *json_company = [[[NSMutableDictionary alloc] init]autorelease];
    NSLog(@"country id=%@, countryName=%@", [countryDic valueForKey:card.countryName], card.countryName);
    [json_company setValue:card.companyId forKey:@"id"];
    [json_company setValue:card.company forKey:@"name"];
    NSMutableDictionary *json_country = [[[NSMutableDictionary alloc] init]autorelease];
    [json_country setValue:[countryDic valueForKey:card.countryName] forKey:@"id"];
    [json_company setValue:json_country forKey:@"country"];
    [json_company setValue:card.province forKey:@"province"];
    [json_company setValue:card.city forKey:@"city"];
    [json_company setValue:card.zip forKey:@"zip"];
    [json_company setValue:card.company_addr forKey:@"address"];
    [json_company setValue:card.phone_num forKey:@"phone"];
    [json_company setValue:card.fax_num forKey:@"fax"];
    [json_company setValue:card.url forKey:@"website"];
    
    SBJsonWriter *parser = [[SBJsonWriter alloc] init];
    NSString * json_Str = [parser stringWithObject:json_company];
    NSLog(@"Reach : json = %@", json_Str);
    return json_Str;
}

-(void)setCardBoxButton{
    okBut = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	okBut.frame = CGRectMake(260.0, 7.0, 50, 30);
    okBut.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [okBut setBackgroundImage:
     [TUNinePatchCache imageOfSize:okBut.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    [okBut setBackgroundImage:[TUNinePatchCache imageOfSize:okBut.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
    
	[okBut addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:okBut];
    [okBut setTitle:AMLocalizedString(@"完成",nil) forState:UIControlStateNormal];
    [okBut setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}

-(void)rightItemAction:(id)sender
{
    NSLog(@"編輯完成...2");
    //XXXX : sent the edit content to server.
    card.firstName = [card_table_map valueForKey:AMLocalizedString(@"名",nil)];
    card.lastName = [card_table_map valueForKey:AMLocalizedString(@"姓",nil)];
    card.company = [card_table_map valueForKey:AMLocalizedString(@"公司名稱",nil)];
    card.department = [card_table_map valueForKey:AMLocalizedString(@"部門",nil)];
    card.title = [card_table_map valueForKey:AMLocalizedString(@"職業/職位",nil)];
    card.countryName = [card_table_map valueForKey:AMLocalizedString(@"國家",nil)];
    card.countryId = [countryDic valueForKey:card.countryName];
    NSLog(@"update : countryName=%@, countryId=%@", card.countryName, card.countryId);
    card.province = [card_table_map valueForKey:AMLocalizedString(@"省份",nil)];
    card.city = [card_table_map valueForKey:AMLocalizedString(@"城市",nil)];
    card.company_addr = [card_table_map valueForKey:AMLocalizedString(@"公司地址",nil)];
    card.phone_num = [card_table_map valueForKey:AMLocalizedString(@"電話",nil)];
    card.fax_num = [card_table_map valueForKey:AMLocalizedString(@"傳真",nil)];
    card.email = [card_table_map valueForKey:AMLocalizedString(@"電郵",nil)];
    card.mobilePhone_num = [card_table_map valueForKey:AMLocalizedString(@"手機",nil)];
    card.url = [card_table_map valueForKey:AMLocalizedString(@"網址",nil)];
    
    NSString *_json_user_str = [self prepareUserJsonForBusinessCardEditor];
    NSString *_json_company_str = [self prepareCompanyJsonForBusinessCardEditor];
    if (MY_TEST == NO) {
        @try {
            //QueryPattern *query=[QueryPattern new];
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            [query prepareDic:addBusinessCard(_login.sessionId, [_json_user_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [_json_company_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
            //[query prepareDic:addBusinessCard(@"1234", [_json_user_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [_json_company_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
            /*@try {
                if (([[query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                    UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"名片修改",nil) message:AMLocalizedString(@"成功",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
                    [_alert show];
                    [_alert release];
                    
                }else{
                    NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
                    UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"名片修改",nil) message:AMLocalizedString(@"失敗",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
                    [_alert show];
                    [_alert release];
                }
                
            }
            @catch (NSException * e) {
                //NPLogException(e);
            }
            @finally {
            }*/
            
            [query release];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
            
        }
    }
}

-(void)editAction:(id)sender{
	
	if(sender == okBut){
		NSLog(@"編輯完成...");
        //XXXX : sent the edit content to server.
        card.firstName = [card_table_map valueForKey:AMLocalizedString(@"姓",nil)];
        card.lastName = [card_table_map valueForKey:AMLocalizedString(@"名",nil)];
        card.company = [card_table_map valueForKey:AMLocalizedString(@"公司名稱",nil)];
        card.title = [card_table_map valueForKey:AMLocalizedString(@"職業/職位",nil)];
        card.countryId = [card_table_map valueForKey:AMLocalizedString(@"國家",nil)];
        card.province = [card_table_map valueForKey:AMLocalizedString(@"省份",nil)];
        card.city = [card_table_map valueForKey:AMLocalizedString(@"城市",nil)];
        card.company_addr = [card_table_map valueForKey:AMLocalizedString(@"公司地址",nil)];
        card.phone_num = [card_table_map valueForKey:AMLocalizedString(@"電話",nil)];
        card.fax_num = [card_table_map valueForKey:AMLocalizedString(@"傳真",nil)];
        card.email = [card_table_map valueForKey:AMLocalizedString(@"電郵",nil)];
        card.mobilePhone_num = [card_table_map valueForKey:AMLocalizedString(@"手機",nil)];
        card.url = [card_table_map valueForKey:AMLocalizedString(@"網址",nil)];
        
        NSString *_json_user_str = [self prepareUserJsonForBusinessCardEditor];
        NSString *_json_company_str = [self prepareCompanyJsonForBusinessCardEditor];
        if (MY_TEST == NO) {
            @try {
                QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
                LoginDataObject *_login = [LoginDataObject sharedInstance];
                //[accountQuery prepareDic:[json_Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                //[query prepareDic:addBusinessCard(_login.sessionId, _json_user_str, _json_company_str)];
                [query prepareDic:addBusinessCard(_login.sessionId, [_json_user_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [_json_company_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
                @try {
                    /*if (([[query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"名片修改",nil) message:AMLocalizedString(@"成功",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
                        [_alert show];
                        [_alert release];
                        
                    }else{
                        NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
                        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"名片修改",nil) message:AMLocalizedString(@"失敗",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
                        [_alert show];
                        [_alert release];
                    }*/
                    
                }
                @catch (NSException * e) {
                    //NPLogException(e);
                }
                @finally {
                    [query release];
                    
                }
            }
            @catch (NSException * e) {
                //NPLogException(e);
            }
            @finally {
                
            }
        }
	}
	
}

-(void)setBackButton{
    backButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	backButton.frame = CGRectMake(10.0, 7.0, 65, 30);
    backButton.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backButton];
    
    //[backButton setTitle:AMLocalizedString(@"date",nil) forState:UIControlStateNormal];
    [backButton setTitle:AMLocalizedString(@"返回",nil) forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}

-(void)backAction:(id)sender{
	
	if(sender == backButton){
        //[backButton removeFromSuperview];
        //[backButton release];
		[self.navigationController popViewControllerAnimated:YES];	
        //[self release];
	}
	
}

-(void)sendFileByPost:(NSString *)toURL{
    NSString *postString = nil;
    NSString *headerString = nil;
    NSRange range = [toURL rangeOfString:@"?"];
    if (range.length != 0)
    {
        headerString = [toURL substringToIndex:range.location];
        postString = [toURL substringFromIndex:(range.location + range.length)];
    }
    else
    {
        NSLog(@"Warrning : request need charactor '?'...");
        return;
    }
        
    //NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    //NSLog(@"postLength=%d, range size=%d", [postData length], (range.length + range.location));
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:headerString]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"Mobile Safari 1.1.3 (iPhone; U; CPU like Mac OS X; en)" forHTTPHeaderField:@"User-Agent"];
    
    [request setHTTPBody:postData]; //加上 post 的資料
    NSData *_toURL_data = [toURL dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //if ([_toURL_data writeToFile:@"/Users/foxconn/project/temp/log.txt" atomically:YES] == NO) {
    //    NSLog(@"sendFileByPost(Error)...");
    //}
    connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//didSendBodyData
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{   //發生錯誤
    UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"大頭照修改有誤",nil) message:[error description] delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
    [_alert show];
    [_alert release];
    [connect release];
    NSLog(@"發生錯誤 %@",[error description]);
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    NSInteger status = (NSInteger)[(NSHTTPURLResponse *)aResponse statusCode];
    NSLog(@"%d", status);
}

-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{   //收到封包，將收到的資料塞進緩衝中並修改進度條
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //把新增的圖檔放到大頭照的位置
    if ([upload_photo length]==0) {
        [connect release];
        return;
    }
    card.image = upload_photo;
    [self _updatePhoto];
    /*[photo_img removeFromSuperview];
    photo_img = [[UIImageView alloc]init];
    
    UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
    UIImage *img_pic = [UIImage imageWithData:card.image];
    
    NSInteger image_w = [img_pic size].width;
    NSInteger image_h = [img_pic size].height;
    NSInteger max_length=0;
    if (image_w > image_h) {
        max_length = image_w;
    }
    else
    {
        max_length = image_h;
    }
    CGFloat scale= photo_but.frame.size.width/max_length;
    [photo_img setFrame:CGRectMake((photo_but.frame.size.width-image_w*scale)/2, (photo_but.frame.size.height-image_h*scale)/2, image_w*scale, image_h*scale)];
    //[photo_img setFrame:CGRectMake((photo_but.frame.size.width-image_w)/2, (photo_but.frame.size.height-image_h)/2, image_w, image_h)];
    photo_img.frame=fixBlurryRect(photo_img.frame);
    //Check if need to do mask.
    if (image_w>53 && image_h>53) {
        [photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
    }
    else
    {
        [photo_img setImage:[UIImage imageWithData:upload_photo]];
    }
    
    [photo_but addSubview:photo_img];
    [photo_img autorelease];*/
    [upload_photo autorelease];
    //將緩衝區的資料轉成字串
    [connect release];
}

/*- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
    
    if (totalBytesExpectedToWrite == totalBytesWritten) {
        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:@"大頭照修改" message:@"成功" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
        [_alert show];
        [_alert release];
        photo_img = [[UIImageView alloc]init];
        [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
        [photo_but addSubview:photo_img];
        card.image = upload_photo;
        if ([card.image length] > 0) {
            UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
            UIImage *img_pic = [UIImage imageWithData:card.image];
            
            //[photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
            [photo_img setImage:[UIImage imageWithData:card.image]];
        }
        [photo_img autorelease];
    }
    else
    {
        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:@"大頭照修改" message:@"失敗" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
        [_alert show];
        [_alert release];
    }
}*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIImagePicker Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // Access the uncropped image from info dictionary
    upload_photo = UIImageJPEGRepresentation(image, 1.0);
    if ([upload_photo length] > 0) {
        //更新server端照片
        //重新計算圖檔尺寸大小, 以便可以降低server端圖檔資料大小
        NSInteger image_w = [image size].width;
        NSInteger image_h = [image size].height;
        NSInteger max_length=0;
        if (image_w > image_h) {
            max_length = image_w;
        }
        else
        {
            max_length = image_h;
        }
        CGFloat scale= photo_but.frame.size.width/max_length;
        UIGraphicsBeginImageContext(CGSizeMake(image_w*scale, image_h*scale));
        [image drawInRect:CGRectMake(0, 0, image_w*scale, image_h*scale)];
        upload_photo=[UIImageJPEGRepresentation(UIGraphicsGetImageFromCurrentImageContext(), 1.0)retain];
        UIGraphicsEndImageContext();
        
        LoginDataObject *_login = [LoginDataObject sharedInstance];
        NSString *contentStr = [upload_photo base64EncodedString];
        NSString *query_url = addBusinessCardPhoto(_login.sessionId, contentStr);
        [self sendFileByPost:query_url];
        
        /*if ([upload_photo length] > 0) {
            [photo_img removeFromSuperview];
            photo_img = [[UIImageView alloc]init];
            card.image = upload_photo;
            UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
            UIImage *img_pic = [UIImage imageWithData:card.image];
            
            NSInteger image_w = [img_pic size].width;
            NSInteger image_h = [img_pic size].height;
            NSInteger max_length=0;
            if (image_w > image_h) {
                max_length = image_w;
            }
            else
            {
                max_length = image_h;
            }
            CGFloat scale= photo_but.frame.size.width/max_length;
            [photo_img setFrame:CGRectMake((photo_but.frame.size.width-image_w*scale)/2, (photo_but.frame.size.height-image_h*scale)/2, image_w*scale, image_h*scale)];
            photo_img.frame=fixBlurryRect(photo_img.frame);
            
            [photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
            //[photo_img setImage:[UIImage imageWithData:card.image]];
            
            [photo_but addSubview:photo_img];
            [photo_img autorelease];
        }*/
        
        
        /*
         QueryPattern *query=[QueryPattern new];
         LoginDataObject *_login = [LoginDataObject sharedInstance];
         NSString *contentStr = [upload_photo base64EncodedString];
         NSString *query_url = addBusinessCardPhoto(_login.sessionId, contentStr);
         [query prepareDic:addBusinessCardPhoto(_login.sessionId, contentStr)];
         if (([[query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
            UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:@"大頭照修改" message:@"成功" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
            [_alert show];
            [_alert release];
            
            //若有成功才換照片.
            photo_img = [[UIImageView alloc]init];
            [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
            [photo_but addSubview:photo_img];
            card.image = content;
            if ([card.image length] > 0) {
                UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
                UIImage *img_pic = [UIImage imageWithData:card.image];
                
                //[photo_img setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
                [photo_img setImage:[UIImage imageWithData:card.image]];
            }
            [photo_img autorelease];
            
        }
        else
        {
            NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
            UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:@"大頭照修改" message:@"失敗" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
            [_alert show];
            [_alert release];
        }
        
        [query release];*/
        
        //card.image = content;
        //[photo_but setImage:image forState:UIControlStateNormal]; 
    }
    
    // Save image
    [imagePicker dismissModalViewControllerAnimated:YES];
    [imagePicker release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerController...cancel...");
    [imagePicker dismissModalViewControllerAnimated:YES];
    [imagePicker release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark IBAction
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)_editPhoto:(id)sender
{
    NSLog(@"editPhoto...");
    // Create image picker controller
    imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Allow editing of image ?
    imagePicker.allowsEditing = NO;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
}

-(IBAction)pickerSubmit:(id)sender
{
    NSLog(@"pickerSubmit trigger...");
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    _cell.textField1.text = [[countryDic allKeys] objectAtIndex:currentPickerRow];//[countryArray objectAtIndex:row];
    [pickerBaseView setHidden:YES];
    
    //reach
    [card_table_map setValue:_cell.textField1.text forKey:_cell.label1.text];
}

-(IBAction)pickerCancel:(id)sender
{
    NSLog(@"pickerCancel trigger...");
    [pickerBaseView setHidden:YES];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PickerView delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    currentPickerRow = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[countryDic allKeys] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [[countryDic allKeys] objectAtIndex:row];
}

-(void) showPicker{
    [picker reloadAllComponents];
    //[picker setHidden:NO];
    [pickerBaseView setHidden:NO];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TextField delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSIndexPath *_indexP = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    [detailTable selectRowAtIndexPath:_indexP animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self maintainCellColor:textField.tag];
    currentSelRow = textField.tag;
    
    //動態調整table cell位置, 使qwerty鍵盤不會擋到.
    //[picker.picker setHidden:YES];
    /*[pickerBaseView setHidden:YES];
    int table_cell_y = detailTable.rowHeight*(currentSelRow + 1)+detailTable.frame.origin.y - baseScroll.contentOffset.y;
    int _height = baseScroll.frame.size.height - table_cell_y;//need to > 260
    if (_height < 260) {
        [baseScroll setContentOffset:CGPointMake(baseScroll.contentOffset.x, baseScroll.contentOffset.y + (260 - _height)) animated:YES];
    }*/
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //[card_fields_value removeObjectAtIndex:textField.tag];
    //[card_fields_value insertObject:textField.text atIndex:textField.tag];
    
    //reach
    NSIndexPath *_indexP = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[detailTable cellForRowAtIndexPath:_indexP];
    [card_table_map setValue:textField.text forKey:_cell.label1.text];
}

-(void) maintainCellColor:(NSInteger)newIndex
{
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 setTextColor:[UIColor colorWithRed:57/255.0 green:85/255.0 blue:135/255.0 alpha:1]];
    [_cell.label1 setTextColor:[UIColor blackColor]];
    //[_cell.textField1 setTextColor:[UIColor redColor]];
    currentSelRow = newIndex;
    _cell = (BusinessCard_Cell2 *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 setTextColor:[UIColor whiteColor]];
    [_cell.label1 setTextColor:[UIColor whiteColor]];
}

-(void) keyboardWasShown:(NSNotification *)nsNotification {
    NSDictionary *userInfo = [nsNotification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    // Portrait:    Height: 264.000000  Width: 768.000000
    // Landscape:   Height: 1024.000000 Width: 352.000000
    [pickerBaseView setHidden:YES];
    int table_cell_y = detailTable.rowHeight*(currentSelRow + 1)+detailTable.frame.origin.y - baseScroll.contentOffset.y;
    int _height = baseScroll.frame.size.height - table_cell_y;//need to > 260
    if (_height < 260) {
        [baseScroll setContentOffset:CGPointMake(baseScroll.contentOffset.x, baseScroll.contentOffset.y + (260 - _height)) animated:YES];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusinessCard_Cell2";
	BusinessCard_Cell2 *cell = (BusinessCard_Cell2 *)[detailTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"BusinessCard_Cell2" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[BusinessCard_Cell2 class]]){
                cell=(BusinessCard_Cell2*)currentObject;
                [cell.textField1 setDelegate:self];
                if (indexPath.row < [card_fields_name count]) {
                    [cell.label1 setText:[card_fields_name objectAtIndex:indexPath.row]];
                    //[cell.textField1 setText:[card_fields_value objectAtIndex:indexPath.row]];
                    [cell.textField1 setText:[card_table_map valueForKey:cell.label1.text]];
                    [cell.textField1 setTag:indexPath.row];
                    
                    if ([cell.label1.text isEqualToString:AMLocalizedString(@"國家",nil)]) {
                        [cell.textField1 setEnabled:NO];
                        NSLog(@"card.countryName = %@, id=%@", card.countryName, [countryDic valueForKey:card.countryName]);
                        [cell.textField1 setText:card.countryName];
                    }
                    //根據title動態調整輸入框大小
                    //CGSize stringSize = [[cell.label1 text] sizeWithFont:[cell.label1 font]];
                    CGSize stringSize = titleMaxSize;
                    [cell.label1 setFrame:CGRectMake(cell.label1.frame.origin.x, cell.label1.frame.origin.y, stringSize.width, cell.label1.frame.size.height)];
                    [cell.textField1 setFrame:CGRectMake(cell.label1.frame.origin.x + cell.label1.frame.size.width + 6, cell.textField1.frame.origin.y, cell.frame.size.width - (cell.label1.frame.origin.x + stringSize.width + 6), cell.textField1.frame.size.height)];
                }
                break;
            }
        }
	}
    
    [cell setFcLayout:indexPath withRows:[card_fields_name count]];
    //Set cell text
	return cell;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"FcGroupTableCell2";
 
 FcGroupTableCell2 *cell = (FcGroupTableCell2 *)[detailTable dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[[FcGroupTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
 }
 
 // Configure the cell...
 cell.textLabel.text= [NSString stringWithFormat:@"%d", indexPath.row];
 if (0==indexPath.row) {
 cell.mode =FcGroupTableCellMode_TOP;
 }else if(indexPath.row == [card_fields_name count]-1){
 cell.mode = FcGroupTableCellMode_BUTTON;
 }else{
 cell.mode = FcGroupTableCellMode_MIDDLE;
 }
 [cell setLayout];
 return cell;
 
 }*/


/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 UITableViewCell *thisCell=[mettingsTable cellForRowAtIndexPath:indexPath];
 return [thisCell frame].size.height;
 //return 63.0f;
 }*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 resignFirstResponder];
    [self maintainCellColor:indexPath.row];
    currentSelRow = indexPath.row;
    if ([[card_fields_name objectAtIndex:currentSelRow] isEqualToString:AMLocalizedString(@"國家",nil)]) {
        [self showPicker];
    }
    else
    {
        //[picker.picker setHidden:YES];
        [pickerBaseView setHidden:YES];
    }
}

/*- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCard_Cell2 *_cell = (BusinessCard_Cell2 *)[tableView cellForRowAtIndexPath:indexPath];
    [_cell.textField1 resignFirstResponder];
    [self maintainCellColor:indexPath.row];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger row_count = 0;
    row_count = [card_fields_name count];
    return row_count;
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 NSInteger section_count = 0;
 return section_count;//plus 1 is for user undefined group
 }
 
 - (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
 {
 return nil;
 }*/
@end
