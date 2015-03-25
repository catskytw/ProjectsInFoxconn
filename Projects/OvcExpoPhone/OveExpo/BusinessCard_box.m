//
//  BusinessCard_MyInfoEditor.m
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard_box.h"
#import "BusinessCard_Cell2.h"

#import "NSData+base64.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "FcDrawing.h"

@interface BusinessCard_box(PrivateMethod)
- (void) prepareData;
- (BOOL) _getCardInfo:(NSString *)result;
-(void)setBackButton;
-(void) maintainCellColor:(NSInteger)newIndex;
@end

@implementation BusinessCard_box

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
            NSLog(@"cardId=%@, sessionId=%@", cardId, _login.sessionId);
            NSString *_queryStr = getBusinessCardById(_login.sessionId, cardId);
            //NSString *_queryStr = getMyBusinessCard(_login.sessionId);
            _queryStr = [_queryStr stringByAppendingFormat:@"&rnd=%i",arc4random()];
            NSLog(@"_queryStr=%@", _queryStr);
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
                card.photo_url = [URLPREFIX stringByAppendingFormat:eventData];
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
    
    //[self initCountry];
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
    [self setTitle:AMLocalizedString(@"名片盒",nil)];
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
    //[baseScroll setContentSize:CGSizeMake(self.view.frame.size.width, detailTable.frame.origin.y + detailTable.frame.size.height+200)];
    [baseScroll setContentSize:CGSizeMake(self.view.frame.size.width, detailTable.frame.origin.y + detailTable.frame.size.height)];
    detailTable.backgroundView = [[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:detailTable.frame.size forNinePatchNamed:@"group_table"]];
    UIImage *photo_but_mask = [UIImage imageNamed:@"namecard_pic_mask.png"];
    UIImage *img_pic = [UIImage imageNamed:@"img_pic.png"];
    photo_img = [[UIImageView alloc]initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:photo_but_mask]withImage:img_pic]];
    [photo_img setFrame:CGRectMake(0, 0, photo_but.frame.size.width, photo_but.frame.size.height)];
    [photo_but addSubview:photo_img];
    [photo_but setEnabled:NO];
    if ([card.image length] > 0) {
        //NSData *content = [NSData dataFromBase64String:card.image];
        [photo_img setImage:[UIImage imageWithData:card.image]];
        //[photo_but setImage:[UIImage imageWithData:card.image] forState:UIControlStateNormal];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [card_table_map removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated
{
    //[[self navigationItem] setHidesBackButton:YES];
    //[self setBackButton];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [backButton removeFromSuperview];
    [backButton release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setBackButton{
    backButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	backButton.frame = CGRectMake(15.0, 7.0,50, 30);
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
	}
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIImagePicker Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"imagePickerController...already selected...");
    // Access the uncropped image from info dictionary
    UIImage *_image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *content = UIImageJPEGRepresentation(_image, 1.0);
    //NSString *contentStr = [content base64EncodedString];
    card.image = content;
    // Save image
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
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
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //[card_fields_value removeObjectAtIndex:textField.tag];
    //[card_fields_value insertObject:textField.text atIndex:textField.tag];
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
                        NSLog(@"card.countryName = %@", card.countryName);
                        [cell.textField1 setText:card.countryName];
                    }
                    //根據title動態調整輸入框大小
                    //CGSize stringSize = [[cell.label1 text] sizeWithFont:[cell.label1 font]];
                    CGSize stringSize = titleMaxSize;
                    [cell.label1 setFrame:CGRectMake(cell.label1.frame.origin.x, cell.label1.frame.origin.y, stringSize.width, cell.label1.frame.size.height)];
                    [cell.textField1 setFrame:CGRectMake(cell.label1.frame.origin.x + cell.label1.frame.size.width + 5, cell.textField1.frame.origin.y, cell.frame.size.width - (cell.label1.frame.origin.x + stringSize.width + 5), cell.textField1.frame.size.height)];
                }
                break;
            }
        }
	}
    
    [cell setFcLayout:indexPath withRows:[card_fields_name count]];
    [cell.textField1 setEnabled:NO];
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
    [self maintainCellColor:indexPath.row];
    currentSelRow = indexPath.row;
}

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
