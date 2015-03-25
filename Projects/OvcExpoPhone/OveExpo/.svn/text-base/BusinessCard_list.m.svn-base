//
//  BusinessCard_list.m
//  OveExpo
//
//  Created by  on 11/9/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard_list.h"
#import "BusinessCard_ListCell.h"
#import "FcTextField.h"
#import "BusinessCard.h"
#import "BusinessCard_box.h"
#import "FcSearchField.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"

@interface BusinessCard_list(PrivateMethod)
- (void)setBackButton;
- (NSDictionary *) _getBusinessCardList;
@end

@implementation BusinessCard_list

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
    [card_company_map release];
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
    //card_company_map = [[NSMutableDictionary alloc]init];
    filterArray = [[NSMutableArray alloc]init];
    card_company_map =[self _getBusinessCardList];
    [filterArray setArray:[card_company_map allValues]];
    
}

- (NSDictionary *) _getBusinessCardList
{
    NSDictionary *returnVal = nil;
    if (MY_TEST == YES) {
        NSMutableDictionary *_card_company_map = [[[NSMutableDictionary alloc]init]autorelease];
        //init card fields.
        for (int i=0; i<12; i++) {
            BusinessCard *card = [[[BusinessCard alloc]init]autorelease];
            card.firstName = @"智宇";
            card.lastName = @"胡";
            card.fullName = [card.lastName stringByAppendingFormat:card.firstName];
            NSString *_language = LocalizationGetLanguage;
            NSLog(@"[_system getLanguage]=%@", _language);
            //LocalizationSystem *_system = [LocalizationSystem sharedLocalSystem];
            //NSString *_language = LocalizationGetLanguage;
            /*NSLog(@"[_system getLanguage]=%@", [_system getLanguage]);
            if ([[_system getLanguage] isEqualToString:@"en"] == YES) {
                card.fullName = [card.firstName stringByAppendingFormat:card.lastName];
            }
            else
            {
                card.fullName = [card.lastName stringByAppendingFormat:card.firstName];
            }*/
            card.company = [NSString stringWithFormat:@"鴻海_%d",i];
            card.title = @"高級勞工";
            [_card_company_map setValue:card forKey:card.company];
        }
        //returnVal = [_card_company_map retain];
        returnVal = [_card_company_map retain];
    }
    else
    {
        //XXXX
        NSMutableDictionary *_card_company_map = [[[NSMutableDictionary alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            [query prepareDic:getBusinessCardList(_login.sessionId)]; 
            //NSArray* dateList=(NSArray*)[query getObjectUnderNode:@"dateList" withIndex:0];
            NSInteger num=[query getNumberUnderNode:@"businessCardList" withKey:@"id"];
            for(int i=0;i<num;i++){
                BusinessCard *card = [[[BusinessCard alloc]init]autorelease];
                card.cardId=(NSString*)[query getValueUnderNode:@"businessCardList" withKey:@"id" withIndex:i];
                card.firstName = (NSString*)[query getValueFromNodeString:[NSString stringWithFormat:@"businessCardList[%d].firstName",i]];
                card.lastName = (NSString*)[query getValueFromNodeString:[NSString stringWithFormat:@"businessCardList[%d].lastName",i]];
                card.fullName = [card.lastName stringByAppendingFormat:card.firstName];
                /*LocalizationSystem *_system = [LocalizationSystem sharedLocalSystem];
                if ([[_system getLanguage] isEqualToString:@"en"] == YES) {
                    card.fullName = [card.firstName stringByAppendingFormat:card.lastName];
                }
                else
                {
                    card.fullName = [card.lastName stringByAppendingFormat:card.firstName];
                }*/
                
                card.company = (NSString*)[query getValueFromNodeString:[NSString stringWithFormat:@"businessCardList[%d].companyName",i]];
                if ((id)card.company == [NSNull null]) {
                    card.company = @"";
                }
                card.title = (NSString*)[query getValueFromNodeString:[NSString stringWithFormat:@"businessCardList[%d].jobTitle",i]];
                if ((id)card.title == [NSNull null]) {
                    card.title = @"";
                }
                [_card_company_map setValue:card forKey:card.company];
            }
            returnVal = [_card_company_map retain];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {            
        }
    }
    //return [returnArray autorelease];
    return returnVal;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:AMLocalizedString(@"名片盒",nil)];
    [UITuneLayout setNaviTitle:self];
    //[[self navigationItem] setHidesBackButton:YES];
    //[self setBackButton];
    
    //Set search text field
    [searchBgImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 60) forNinePatchNamed:@"bg_black"]];
    if(!searchField)
        searchField = [FcSearchField new];
    searchField.view.frame = ccRectShift(searchField.view.frame, CGPointMake(25, 13));
    [self.view addSubview:searchField.view];
    [searchField settextfildDelegate:self];
    [searchField.textfild setPlaceholder:AMLocalizedString(@"輸入廠商名稱",nil)];
    [searchField.textfild setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField.textfild setValue:[UIFont fontWithName:DefaultFontName size:18.0f] forKeyPath:@"_placeholderLabel.font"];
    [self prepareData];
    // Do any additional setup after loading the view from its nib.
    /*NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"FcTextField" owner:self options:nil];
    searchTF2 = [array lastObject];
    [searchTF2 setDelegate:self];
    [[searchTF2 textField] setTextColor:[UIColor colorWithRed:81 green:81 blue:81 alpha:1]];
    [[searchTF2 textField] setPlaceholder:@"關鍵字搜尋"];
    [searchTF2 setFrame:CGRectMake(34, 20, 252, 40)];
    [searchTF2 setLayout];*/
    //[self.view addSubview:searchTF2];
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

- (void)viewWillAppear:(BOOL)animated
{
    //[[self navigationItem] setHidesBackButton:YES];
    //[self setBackButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [backButton removeFromSuperview];
    [backButton release];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TextField delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *_search_input = textField.text;
    if ([_search_input length] == 0) {
        NSLog(@"Filter ignore...");
        [filterArray setArray:[card_company_map allValues]];
        [cardListTable reloadData];
        return  NO;
    }
    
    [filterArray removeAllObjects];
    NSArray *all_value = [card_company_map allValues];
    for (int i=0; i<[all_value count]; i++) {
        BusinessCard *_card = [all_value objectAtIndex:i];
        if (([_search_input length] > 0) &&
            ([_card.company rangeOfString:_search_input].length <= 0)) {
            //NSLog(@"filter not found at (%@)", _item_name);
            continue;
        }
        [filterArray addObject:_card];
    }

    [cardListTable reloadData];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusinessCard_ListCell";
	BusinessCard_ListCell *cell = (BusinessCard_ListCell *)[cardListTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"BusinessCard_ListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[BusinessCard_ListCell class]]){
                cell=(BusinessCard_ListCell*)currentObject;
                [cell setUIDefault];
                BusinessCard *_card = [filterArray objectAtIndex:indexPath.row];
                [cell.label1 setText:_card.company];
                [cell.label2 setText:_card.fullName];
                NSString *_title = [NSString stringWithFormat:@"%@ %@",_card.fullName, _card.title];
                NSLog(@"_title=%@",_title);
                if (_card.title != nil) {
                    [cell.label2 setText:_title];
                }
                break;
            }
        }
	}
    
    //Set cell text
	return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 UITableViewCell *thisCell=[mettingsTable cellForRowAtIndexPath:indexPath];
 return [thisCell frame].size.height;
 //return 63.0f;
 }*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //currentSelCell = (BusinessCard_ListCell *)[cardListTable cellForRowAtIndexPath:indexPath];
    BusinessCard *_card = [filterArray objectAtIndex:indexPath.row];
    BusinessCard_box *_box = [[BusinessCard_box alloc]initWithCardId:_card.cardId];
    [_box setBackItem:AMLocalizedString(@"返回",nil)];
    [[self navigationController] pushViewController:_box animated:YES];
    [_box autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger row_count = 0;
    row_count = [filterArray count];
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
