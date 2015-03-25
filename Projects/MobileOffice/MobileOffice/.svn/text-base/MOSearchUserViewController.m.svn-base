//
//  MOSearchUserViewController.m
//  MobileOffice
//
//  Created by  on 11/9/8.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import "UIKit/UIKit.h"

#import "WheelDisk.h"
#import "EventAction.h"
#import "FcConfig.h"
#import "EventTableCell.h"
#import "DrawEventObject.h"
#import "UIView_extend.h"
#import "EventObject.h"
#import "DateButton.h"
#import "DateCaculator.h"
#import "LocalizationSystem.h"
#import "FcDrawing.h"
#import "FcEventButton.h"
#import "DateView.h"
#import "WEPopoverController.h"
#import "EventEditViewController.h"
#import "EventContent.h"
#import "CalendarDAO.h"
#import "Tools.h"

#import "MOSearchUserViewController.h"
#import "MOSearchItem.h"
#import "MOSearchResultItem.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "NinePatch.h"
#import "Tools.h"
#import "MOButton.h"
#import "FcTextField.h"
#import "MOSearchType.h"
#import "MOLoginViewController.h"
#import "SBJsonWriter.h"
#import "MOSearchTableCell.h"
#import "MOLoginInfo.h"
#import "AttendanceModel.h"
#define MY_DEBUG NO
//XXXX(done : 09/17) : Need create a API for delegate.(1.add workers, 2.remove workers)
//XXXX : 驗證所需的server和database Rex 已經提供, but install need ask link.
//XXXX : formal驗證要把 MY_DEBUG set NO
/*
 * 
 */
@interface MOSearchUserViewController(PrivateMethod)
- (void) prepareTestData;//For testing
- (void) prepareData;//For testing
//- (void) _querySearchTypes:(NSMutableDictionary *)returnArray;
//- (void) _querySearchItems:(NSMutableDictionary *)returnArray withWorkNo:(NSString *)workNo withType:(NSString *)type;
//- (void) _queryWorkers:(NSMutableDictionary *)returnArray withWorkNo:(NSString *)workNo withFilterTime:(NSString *)time withCondition:(NSString *)json;
- (NSDictionary *) _querySearchTypes;
- (NSDictionary *) _querySearchItems:(NSString *)workNo withType:(NSString *)type;
- (NSDictionary *) _queryWorkers:(NSString *)workNo withFilterTime:(NSString *)time withCondition:(NSString *)json;

- (void) addWorkersWithCondition:(NSString *)condition;
- (void) removeWorkersWithCondition:(NSString *)condition;
-(NSString *) prepareJsonForQueryWorkers;
@end

@implementation MOSearchUserViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - utilities
-(NSDictionary *) _querySearchTypes
{
    //NSString *workNo = _workNo;
    //NSString *password = _password;
    NSMutableDictionary *returnArray = [[NSMutableDictionary new]autorelease];
    QueryPattern *query=[QueryPattern new];
    //[query prepareDic:loginURL(workNo, password)];
    [query prepareDic:querySearchTypes([MOLoginViewController loginInfo].sessionId)];
    NSInteger num=[query getNumberUnderNode:@"filterTypeList" withKey:@"filterType"];
    for(int i=0;i<num;i++){
        //NSDictionary *eventData=[query getObjectUnderNode:@"filterTypeList" withIndex:i];
        MOSearchType *thisEvent=[[MOSearchType alloc]init];
        thisEvent.filterType=(NSString*)[query getValueUnderNode:@"filterTypeList" withKey:@"filterType" withIndex:i];
        thisEvent.filterName=(NSString*)[query getValueUnderNode:@"filterTypeList" withKey:@"filterName" withIndex:i];
        
        [returnArray setValue:[thisEvent autorelease] forKey:thisEvent.filterType];
    }
    [query release];
    return returnArray;
}

-(NSDictionary *) _querySearchItems:(NSString *)workNo withType:(NSString *)type
{
    //NSString *_workNo = workNo;
    //NSString *_type = type;
    NSLog(@"_querySearchItems : workNo=%@, type=%@", workNo, type);
    NSMutableDictionary *returnArray = [[NSMutableDictionary new]autorelease];
    QueryPattern *query=[QueryPattern new];
    //[query prepareDic:loginURL(workNo, password)];
    NSDate *_date = [DateCaculator share].attendanceDay;
    NSInteger _month = [[DateCaculator share] monthInYear:_date];
    NSString *_monthStr = [NSString stringWithFormat:@"%d",_month];
    [query prepareDic:querySearchItems([MOLoginViewController loginInfo].sessionId, [MOLoginViewController loginInfo].loginId, type, _monthStr)];
    NSInteger num=[query getNumberUnderNode:@"itemList" withKey:@"name"];
    for(int i=0;i<num;i++){
        //NSDictionary *eventData=[query getObjectUnderNode:@"itemList" withIndex:i];
        
        MOSearchItem *_item=[[MOSearchItem alloc]init];
        //_item.content=(NSString *)[query getValueUnderNode:@"itemList" withKey:@"name" withIndex:i];
        //_item.serialNo=(NSString *)[query getValueUnderNode:@"itemList" withKey:@"value" withIndex:i];
        _item.content=(NSString *)[query getValueFromNodeString:[NSString stringWithFormat:@"itemList[%d].name",i]];
        _item.serialNo=(NSString *)[query getValueFromNodeString:[NSString stringWithFormat:@"itemList[%d].value",i]];
        [returnArray setValue:[_item autorelease] forKey:_item.content];
    }
    [query release];
    return returnArray;
}

-(NSString *) prepareJsonForQueryWorkers
{
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    NSArray *types = [searchTypes allValues];
    MOSearchType *type = nil;
    for (int i=0; i<[types count]; i++) {
        type = [types objectAtIndex:i];
        NSEnumerator *_indicator = [[[type items]allValues]objectEnumerator];
        MOSearchItem *_item = nil;
        NSMutableArray *json_1 = [[NSMutableArray alloc] init];
        while ((_item = [_indicator nextObject]) != nil) {
            if ([_item isSelected] == YES) {
                NSLog(@"_item.serialNo=%@", _item.serialNo);
                [json_1 addObject:_item.serialNo];
            }
        }
        
        if ([json_1 count] > 0) {
            [json setValue:[json_1 autorelease] forKey:type.filterType];
        }
        else
        {
            [json_1 release];
        }
        
    }
    SBJsonWriter *parser = [[SBJsonWriter alloc] init];
    NSString * json_Str = [parser stringWithObject:json];
    NSLog(@"Reach : json1 = %@", json_Str);
    //if ([json_Str length] == 0) {
    //    json_Str = @"{}";
    //}
    //NSLog(@"Reach : json2 = %@", json_Str);
    return json_Str;
}

-(NSDictionary *) _queryWorkers:(NSString *)workNo withFilterTime:(NSString *)time withCondition:(NSString *)json
{
    //NSString *_workNo = workNo;
    //NSString *_type = type;
    NSMutableDictionary *returnArray = [[NSMutableDictionary new] autorelease];
    NSMutableDictionary *_tempArray = [[[NSMutableDictionary alloc]init]autorelease];
    NSMutableDictionary *_new_searchResultImtes_selected = [[[NSMutableDictionary alloc]init]autorelease];
    
    if (MY_DEBUG == YES) {
        for (int i=0; i<30; i++) {
            MOSearchResultItem *item = [[MOSearchResultItem alloc]init];
            NSString *content = [NSString stringWithFormat:@"胡智宇%d",i];
            NSString *serialNo = [NSString stringWithFormat:@"胡智宇%d",i];
            [item setName:content];
            [item setWorkNo:serialNo];
            [item setIsSelected:NO];
            MOSearchResultItem *_item_org = [searchResultImtes_selected objectForKey:item.workNo];
            [searchResultImtes_selected removeObjectForKey:item.workNo];
            if (_item_org != nil) {
                item.isSelected = YES;
                [_new_searchResultImtes_selected setValue:item forKey:item.workNo];
            }
            [_tempArray setValue:[item autorelease] forKey:item.workNo];
        }
    }
    else
    {
        NSString *_queryStr = queryWorkers([MOLoginViewController loginInfo].sessionId, workNo, time, json);
        _queryStr = [_queryStr stringByAppendingFormat:@"&rnd=%i",arc4random()];
        _queryStr = [_queryStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"_queryStr = %@", _queryStr);
        if ([json isEqualToString:@"{}"] == YES) {
            if ([searchResultImtes_Cache count] > 0) {
                [returnArray removeAllObjects];
                [returnArray addEntriesFromDictionary:searchResultImtes_Cache];
                return returnArray;
            }
        }
        
        //QueryPattern *query=[[QueryPattern alloc] initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        QueryPattern *query=[QueryPattern new];
        [query prepareDic:_queryStr];
        NSInteger num=[query getNumberUnderNode:@"itemList" withKey:@"workNo"];
        for(int i=0;i<num;i++){
            MOSearchResultItem *_item=[[[MOSearchResultItem alloc]init]autorelease];
            _item.name=(NSString *)[query getValueFromNodeString:[NSString stringWithFormat:@"itemList[%d].cname",i]];
            _item.workNo=(NSString *)[query getValueFromNodeString:[NSString stringWithFormat:@"itemList[%d].workNo",i]];
            //_item.workNo=(NSString *)[query getValueUnderNode:@"itemList" withKey:@"workNo" withIndex:i];
            _item.isSelected = NO;
            MOSearchResultItem *_item_org = [searchResultImtes_selected objectForKey:_item.workNo];
            [searchResultImtes_selected removeObjectForKey:_item.workNo];
            if (_item_org != nil) {
                _item.isSelected = YES;
                //???? : 這邊若改用setValue:[_item autoreleas]會造成memory release問題(ps. on [returnArray removeAllObjects];), need clarify.(Reach fixed : 原因不明 09/17)
                [_new_searchResultImtes_selected setValue:_item forKey:_item.workNo];
            }
            
            if (_item.name == nil || _item.workNo == nil) {
                NSLog(@"Name = %@, WorkNo = %@", _item.name, _item.workNo);
                UIAlertView *_alertView = [[[UIAlertView alloc] initWithTitle:@"Warrning!" message:[NSString stringWithFormat:@"Some one data is empty : Name = %@, WorkNo = %@", _item.name, _item.workNo] delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil]autorelease];
                [_alertView show];
            }
            [_tempArray setValue:_item forKey:_item.workNo];
            
        }
        [query release];
    }
    
    
    [returnArray removeAllObjects];
    
    if ([[_tempArray allValues]count] > 0) {
        //[returnArray addEntriesFromDictionary:_tempArray];
        [returnArray addEntriesFromDictionary:_tempArray];
        if ([searchResultImtes_Cache count] == 0) {
            [searchResultImtes_Cache addEntriesFromDictionary:_tempArray];
        }
        //XXXX(done : 09/17) : 通知delegate要移除的workers.(ps.利用searchResultImtes_selected剩下的item.
        //[[self delegate] didRemoveWorkers:[searchResultImtes_selected allValues]];
        //最後再把新的item回copy給searchResultImtes_selected.
        //[searchResultImtes_selected removeAllObjects];
        [searchResultImtes_selected addEntriesFromDictionary:_new_searchResultImtes_selected];
        
    }
    
    return returnArray;
}

NSInteger searchSearchItemsCompare(id obj1, id obj2, void *context)
{
    MOSearchItem *item1 = (MOSearchItem *)obj1;
    MOSearchItem *item2 = (MOSearchItem *)obj2;
    return [item1.content compare:item2.content];
}

-(void) updateSearchItemsView:(NSString *)type
{
    NSLog(@"type = %@", type);
    int columnCount = 4;
    NSLog(@"type index = %d", searchTypeIdx);
    switch (searchTypeIdx) {
        case 0:
            columnCount = 4;
            break;
        case 1:
            columnCount = 4;
            break;
        case 2:
            columnCount = 5;
            break;
        case 3:
            columnCount = 9;
            break;
        default:
            break;
    }
    [searchItemsView removeAllSubViews];
    [searchItemsView setFrame:CGRectMake(searchItemsView.frame.origin.x, searchItemsView.frame.origin.y, searchItemsView_scroll.frame.size.width, searchItemsView.frame.size.height)];
    NSArray *searchItems = [[[(MOSearchType *)[searchTypes valueForKey:type] items] allValues] sortedArrayUsingFunction:searchSearchItemsCompare context:NULL];
    NSEnumerator *iterator = [searchItems objectEnumerator];
    MOSearchItem *item = nil;
    int leftInterval = 22;//Left interval.
    int rightInterval = 24;//Right interval.
    int item_x = 0;
    int item_y = 0;
    int columInterval_x = 12;
    int rowInterval_y = 7;
    int _displayWidth = searchItemsView.frame.size.width-leftInterval-rightInterval;
    int _displayHeight = searchItemsView.frame.size.height;

    int item_width = (_displayWidth-(columInterval_x)*(columnCount-1))/columnCount;
    int item_high = (_displayHeight-(rowInterval_y)*(4-1))/4;;
    
    int next_x = 0;
    int next_y = item_high + rowInterval_y;
    int x_offset = 0;
    int contentSize_width = searchItemsView_scroll.frame.size.width;
    [searchPageCtrl setNumberOfPages:1];

    while ((item = (MOSearchItem *)[iterator nextObject]) != nil) {
        UIButton *searchItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchItem.titleLabel setLineBreakMode:UILineBreakModeTailTruncation];
        UIFont *defaultFont = [UIFont fontWithName:DefaultFontName size:20.0f];
        [searchItem.titleLabel setFont:defaultFont];

        //item_width = stringSize.width;
        
        //*** Calcuate the org pointer.
        BOOL isLocalOK = NO;
            NSLog(@"next_x: %d item_width %d columInterval_x %d _displayWidth %d", next_x , item_width , columInterval_x, _displayWidth);
            if ((next_x + item_width /*+ columInterval_x*/) <= _displayWidth) {
                item_x = next_x;
                next_x = next_x + item_width + columInterval_x;
                isLocalOK = YES;
            }
            else if((next_y + item_high /*+ rowInterval_y*/) <= _displayHeight)
            {
                //NSLog(@"change line : go to next line.");
                item_y = next_y;
                next_y = next_y + item_high + rowInterval_y;
                item_x = 0;
                next_x = item_width + columInterval_x;
                isLocalOK = YES;
            }
            else
            {
                isLocalOK = NO;
                //NSLog(@"lcoal not fount : go next page.");
                item_x = 0;
                item_y = 0;
                next_x = item_width + columInterval_x;
                next_y = item_high + rowInterval_y;
                x_offset = x_offset + searchItemsView_scroll.frame.size.width;
                
                //*** Setting page controller
                [searchPageCtrl setNumberOfPages:([searchPageCtrl numberOfPages]+1)];
                contentSize_width = contentSize_width + searchItemsView_scroll.frame.size.width;
                [searchItemsView setFrame:CGRectMake(searchItemsView.frame.origin.x, searchItemsView.frame.origin.y, contentSize_width, searchItemsView.frame.size.height)];
            }
        
        //*** Setting button item
        NSLog(@"searchItem rect: %d  %d  %d  %d", (item_x + x_offset + leftInterval) , item_y , item_width, item_high);
        [searchItem setFrame:CGRectMake((item_x + x_offset + leftInterval), item_y, item_width, item_high)];
        [searchItem setBackgroundImage:
        [TUNinePatchCache imageOfSize:searchItem.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
        [searchItem addTarget:self action:@selector(clickSearchItem:) forControlEvents:UIControlEventTouchUpInside];
        [searchItem setTitle:[item content] forState:UIControlStateNormal];
        [searchItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        if ([item isSelected] == YES) {
            [searchItem setBackgroundImage:
             [TUNinePatchCache imageOfSize:searchItem.frame.size forNinePatchNamed:@"bg_search_popup_marked"] forState:UIControlStateNormal];
            [searchItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [searchItem setBackgroundImage:nil forState:UIControlStateNormal];
            [searchItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [searchItemsView addSubview:searchItem];
    }
    
    //*** Setting scroll view
    searchItemsView_scroll.showsVerticalScrollIndicator = NO;
    searchItemsView_scroll.showsHorizontalScrollIndicator=NO;
    //searchItemsView_scroll.contentSize = searchItemsView.frame.size;
    searchItemsView_scroll.contentSize = CGSizeMake(contentSize_width, searchItemsView_scroll.frame.size.height);
    searchItemsView_scroll.contentOffset = CGPointMake(0, 0);
    
}

NSInteger searchResultItemsCompare(id obj1, id obj2, void *context)
{
    MOSearchResultItem *item1 = (MOSearchResultItem *)obj1;
    MOSearchResultItem *item2 = (MOSearchResultItem *)obj2;
    return [item1.name compare:item2.name];
}

-(void) updateResultItemsView
{
    //NSLog(@"type = %@", type);
    [resultItemsView removeAllSubViews];
    [resultItemsView setFrame:CGRectMake(resultItemsView.frame.origin.x, resultItemsView.frame.origin.y, resultItemsView_scroll.frame.size.width, resultItemsView.frame.size.height)];
    //NSArray *searchItems = [[searchTypes valueForKey:type]allObjects];
    if (searchResultImtes == nil || [[searchResultImtes allValues] count] == 0) {
        NSLog(@"Warning : query items is empty...");
        return;
    }
    NSArray *resultItems = [[searchResultImtes allValues] sortedArrayUsingFunction:searchResultItemsCompare context:NULL];
    //NSArray *resultItems_sorted =
    //[resultItems sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSEnumerator *iterator = [resultItems objectEnumerator];
    MOSearchResultItem *item = nil;
    
    int leftInterval = 39;//Left interval.
    int rightInterval = 38;//Right interval.
    int item_x = 0;
    int item_y = 0;

    int rowInterval_y = 6;
    int columInterval_x = 9;
    int buttonXY_interval = 15;
    int next_x = 0;
    int _displayWidth = resultItemsView.frame.size.width-leftInterval-rightInterval;
    int _displayHeight = resultItemsView.frame.size.height;
    int item_width = (_displayWidth-columInterval_x*5)/6;
    int item_high = (_displayHeight-(rowInterval_y)*(4-1))/4;;
    int next_y = item_high + rowInterval_y;
    int x_offset = 0;
    int contentSize_width = resultItemsView_scroll.frame.size.width;

    
    [resultPageCtrl setNumberOfPages:1];
        
    while ((item = (MOSearchResultItem *)[iterator nextObject]) != nil) {
        MOButton *resultItem = [[MOButton alloc]init];
        [resultItem.titleLabel setLineBreakMode:UILineBreakModeTailTruncation];
        //*** Filter items by search text field
        NSString *_item_name = [item name];
        NSString *_search_input = searchTF2.textField.text;
        if (([_search_input length] > 0) &&
            ([_item_name rangeOfString:_search_input].length <= 0)) {
            //NSLog(@"filter not found at (%@)", _item_name);
            continue;
        }
        UIFont *defaultFont = [UIFont fontWithName:DefaultFontName size:18.0f];
        [resultItem.titleLabel setFont:defaultFont];
        //CGSize stringSize = [Tools estimateStringSize:[item name] withFontSize:18.0f];
        //item_width = stringSize.width;
        
        //*** Calcuate the org pointer.
        BOOL isLocalOK = NO;
        int origin_x = [resultItemsView frame].origin.x;
        if ((next_x + item_width/* + columInterval_x*/) <= _displayWidth) {
            item_x = next_x;
            next_x = next_x + item_width + columInterval_x;
            isLocalOK = YES;
            //break;
        }
        else if((next_y + item_high/* + rowInterval_y*/) <= _displayHeight)
        {
            //NSLog(@"change line : go to next line.");
            item_y = next_y;
            next_y = next_y + item_high + rowInterval_y;
            item_x = 0;
            next_x = item_width + columInterval_x;
            isLocalOK = YES;
            //break;
        }
        else
        {
            isLocalOK = NO;
            //NSLog(@"lcoal not fount : go next page.");
            //break;
            item_x = 0;
            item_y = 0;
            next_x = item_width + columInterval_x;
            next_y = item_high + rowInterval_y;
            x_offset = x_offset + resultItemsView_scroll.frame.size.width;
            [resultPageCtrl setNumberOfPages:([resultPageCtrl numberOfPages]+1)];
            contentSize_width = contentSize_width + resultItemsView_scroll.frame.size.width;
            [resultItemsView setFrame:CGRectMake(resultItemsView.frame.origin.x, resultItemsView.frame.origin.y, contentSize_width, resultItemsView.frame.size.height)];
            //break;
        }
        
        //*** Setting button item
        [resultItem setFrame:CGRectMake((item_x + x_offset + leftInterval), item_y, item_width, item_high)];
        [resultItem setBackgroundImage:
         [TUNinePatchCache imageOfSize:resultItem.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
        [resultItem setTitle:[item name] forState:UIControlStateNormal];
        [resultItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [resultItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [resultItem setWorkNo:[item workNo]];
        [resultItem setSelected:NO];
        //NSLog(@"Result item name = %@, serial=%@", [item name], [item workNo]);
        if ([item isSelected] == YES) {
            [resultItem setBackgroundImage:
             [TUNinePatchCache imageOfSize:resultItem.frame.size forNinePatchNamed:@"bg_search_popup_marked"] forState:UIControlStateNormal];
            [resultItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [resultItem setBackgroundImage:nil forState:UIControlStateNormal];
            [resultItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [resultItem addTarget:self action:@selector(clickResultItem:) forControlEvents:UIControlEventTouchUpInside];
        [resultItemsView addSubview:resultItem];
    }
    
    //*** Setting scroll view
    resultItemsView_scroll.showsVerticalScrollIndicator = NO;
    resultItemsView_scroll.showsHorizontalScrollIndicator=NO;
    resultItemsView_scroll.contentSize = CGSizeMake(contentSize_width, resultItemsView_scroll.frame.size.height);
    resultItemsView_scroll.contentOffset = CGPointMake(0, 0);

    
}

#pragma mark - View lifecycle
- (void) clickSearchItem:(id *)sender
{
    UIButton *button = (UIButton *)sender;
    //NSLog(@"clickSearchItem...[button titleLabel].text = %@, currentType = %@", [button titleLabel].text, currentType);
    
    //*** If current type is different with using type, then we need to reset last selected search items at first.
    if ([usingType isEqualToString:currentType] == NO) {
        NSArray *_buttons = [searchItems_selected allValues];
        for (int i=0; i<[_buttons count]; i++) {
            MOSearchItem *_button = [_buttons objectAtIndex:i];
            [_button setIsSelected:NO];
        }
        [searchItems_selected removeAllObjects];
    }
    usingType = currentType;
    
    NSDictionary *_searchItems = [(MOSearchType *)[searchTypes valueForKey:usingType] items];
    MOSearchItem *_item = [_searchItems valueForKey:[button titleLabel].text];
    BOOL _isSelected = [_item isSelected];
    [_item setIsSelected:!_isSelected];
    //NSLog(@"clickSearchItem..._item = %@, isSelected=%d", [_item content], [_item isSelected]);
    if ([_item isSelected] == YES) {
        [button setBackgroundImage:
         [TUNinePatchCache imageOfSize:button.frame.size forNinePatchNamed:@"bg_search_popup_marked"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchItems_selected setObject:_item forKey:_item.serialNo];
    }
    else
    {
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchItems_selected removeObjectForKey:_item.serialNo];
    }
    
    NSString *json_str = [self prepareJsonForQueryWorkers];
    NSDate *_date = [DateCaculator share].attendanceDay;
    NSInteger _month = [[DateCaculator share] monthInYear:_date] ;
    NSString *_monthStr = [NSString stringWithFormat:@"%d",_month];
    [searchResultImtes removeAllObjects];
    [searchResultImtes addEntriesFromDictionary:[self _queryWorkers:[MOLoginViewController loginInfo].loginId withFilterTime:_monthStr withCondition:json_str]];
    [self updateResultItemsView];
}

- (void) clickResultItem:(id *)sender
{
    MOButton *button = (MOButton *)sender;
    //NSLog(@"clickResultItem...[button titleLabel].text = %@, currentType = %@", [button titleLabel].text, currentType);
    
    MOSearchResultItem *_item = [searchResultImtes valueForKey:[button workNo]];
    BOOL _isSelected = [_item isSelected];
    [_item setIsSelected:!_isSelected];
    [button setSelected:[_item isSelected]];
    if ([_item isSelected] == YES) {
        //[button setEnabled:YES];
        [button setHighlighted:YES];
        [button setBackgroundImage:
         [TUNinePatchCache imageOfSize:button.frame.size forNinePatchNamed:@"bg_search_popup_marked"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchResultImtes_selected setValue:_item forKey:_item.workNo];
        //Notify delegate
        [[self delegate] didAddWorkers:[[NSArray alloc] initWithObjects:_item, nil]];
    }
    else
    {
        //[button setEnabled:NO];
        [button setHighlighted:NO];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchResultImtes_selected removeObjectForKey:_item.workNo];
        //Notify delegate
        [[self delegate] didRemoveWorkers:[[NSArray alloc] initWithObjects:_item, nil]];
    }
    
    //NSLog(@"clickResultItem..._item = %@, isHighlighted=%d, serialNo=%@", [_item name], [button isHighlighted], [_item workNo]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchTypeIdx = 0;
    // Do any additional setup after loading the view from its nib.
    //*** Set background view
    //[backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[TUNinePatchCache imageOfSize:CGSizeMake([backgroundView frame].size.width, [backgroundView frame].size.height) forNinePatchNamed:@"bg_search_popup"]]];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    [backgroundView_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake([backgroundView frame].size.width, [backgroundView frame].size.height) forNinePatchNamed:@"bg_search_popup"]];
    [self prepareData];
    
    //*** Set search view
    [searchView setBackgroundColor:[UIColor clearColor]];
    [searchTypeTableView reloadData];
    [searchTypeTableView_bg setImage:[TUNinePatchCache imageOfSize:searchTypeTableView_bg.frame.size forNinePatchNamed:@"bg_search_popup_result"]];
    //UIImageView *_tableBg = [[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:searchTypeTableView.frame.size forNinePatchNamed:@"bg_search_popup_result"]]autorelease];
    //[searchTypeTableView setBackgroundView:_tableBg];
    //[searchTypeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:0];
    UITableViewCell *cell = [searchTypeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //[cell setSelected:YES];
    
    
    [self updateSearchItemsView:[cell textLabel].text];
    currentType = [cell textLabel].text;
    //[searchItemsView_scroll setBackgroundColor:[UIColor colorWithPatternImage:[TUNinePatchCache imageOfSize:CGSizeMake([searchItemsView_scroll frame].size.width, [searchItemsView_scroll frame].size.height) forNinePatchNamed:@"bg_search_popup_result"]]];
    [searchItemsView_scroll setBackgroundColor:[[UIColor alloc] initWithRed:215/255.f green:217/255.f blue:228/255.f alpha:1]];
    [searchItemsView_bg setImage:[TUNinePatchCache imageOfSize:searchItemsView_bg.frame.size forNinePatchNamed:@"bg_search_popup_result_border"]];
    [searchItemsView setBackgroundColor:[UIColor clearColor]];
    //searchPageCtrl addTarget:self action:@selector(uiSearchPageChanged:) forControlEvents:<#(UIControlEvents)#>
    //[searchItemsView_scroll setContentSize:searchItemsView.frame.size];
    [searchTable_scroll setContentSize:searchTable_scroll_bg.frame.size];
    //searchTableCell_bg = [[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake([resultItemsView_scroll frame].size.width, [resultItemsView_scroll frame].size.height) forNinePatchNamed:@"bg_search_popup_result"]];
    //*** After searchItemView ready then we can display the init data.
    [self tableView:searchTypeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"FcTextField" owner:self options:nil];
    searchTF2 = [array lastObject];
    [searchTF2 setDelegate:self];
    //searchTF2 setBgImg:
    [[searchTF2 textField] setTextColor:[UIColor colorWithRed:81 green:81 blue:81 alpha:1]];
    //[[searchTF2 textField] setText:@"關鍵字搜尋"];
    [[searchTF2 textField] setPlaceholder:@"關鍵字搜尋"];
    [[searchTF2 textField] setValue:[[UIColor alloc] initWithRed:81/255.f green:81/255.f blue:81/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];

    [searchTF2 setFrame:CGRectMake(540, 33, 200, 50)];
    //[[searchTF2 bgImg] setHighlighted:YES];
    [searchTF2 setLayout];
    [backgroundView addSubview:searchTF2];
    
    /*[searchTF setTextColor:[UIColor colorWithRed:153 green:153 blue:153 alpha:1]];
    [searchTF setPlaceholder:@"帳號"];
    [searchTF setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [searchTF_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox_search"]];
    [searchTF_bk setHighlightedImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox_search_i"]];
    [searchTF_bk setHighlighted:YES];*/
    [searchTF setHidden:YES];
    
    //*** Set result view
    [self updateResultItemsView];
    //[resultItemsView_scroll setBackgroundColor:[UIColor colorWithPatternImage:[TUNinePatchCache imageOfSize:CGSizeMake([resultItemsView_scroll frame].size.width, [resultItemsView_scroll frame].size.height) forNinePatchNamed:@"bg_search_popup_result"]]];
    [resultItemsView_bg setImage:[TUNinePatchCache imageOfSize:resultItemsView_bg.frame.size forNinePatchNamed:@"bg_search_popup_result"]];
    [resultItemsView setBackgroundColor:[UIColor clearColor]];
    
    //*** Set others view
    [resetButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:resetButton.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [resetButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:resetButton.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    [closeButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:closeButton.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:closeButton.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
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
	return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)?YES:NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TextField delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self updateResultItemsView];
    return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - page control delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)uiSearchPageChanged:(id)sender
{
    NSLog(@"Search view : pageChanged...page is %d.", [searchPageCtrl currentPage]);
    //[searchPageCtrl setNumberOfPages:([searchPageCtrl numberOfPages]+1)];
    //[searchPageCtrl setNumberOfPages:1];
}

-(void)uiResultPageChanged:(id)sender
{
    NSLog(@"Result view : pageChanged...page is %d.", [resultPageCtrl currentPage]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - DelegateMethod
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == searchItemsView_scroll) {
        if (pageControlUsed){
            [self changePage:scrollView];
            return;
        }
        CGFloat pageWidth = searchItemsView_scroll.frame.size.width;
        int page = floor((searchItemsView_scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        searchPageCtrl.currentPage = page;
    }
    else
    {
        if (pageControlUsed){
            [self changePage:scrollView];
            return;
        }
        CGFloat pageWidth = resultItemsView_scroll.frame.size.width;
        int page = floor((resultItemsView_scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        resultPageCtrl.currentPage = page;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate==YES)
        pageControlUsed=YES;
    else
        [self changePage:scrollView];
}

- (IBAction)changePage:(id)sender{
    if (sender == searchItemsView_scroll) {
        [searchItemsView_scroll scrollRectToVisible:CGRectMake(searchItemsView_scroll.frame.size.width*searchPageCtrl.currentPage, 0, searchItemsView_scroll.frame.size.width, searchItemsView_scroll.frame.size.height) animated:YES];
    }
    else if(sender == resultItemsView_scroll)
    {
        [resultItemsView_scroll scrollRectToVisible:CGRectMake(resultItemsView_scroll.frame.size.width*resultPageCtrl.currentPage, 0, resultItemsView_scroll.frame.size.width, resultItemsView_scroll.frame.size.height) animated:YES];
    }
    //[_eventId release];
    //_eventId=nil;
    
    //NSString *_eventString=[_eventsId objectAtIndex:pageControl.currentPage];
    //_eventId=[[NSString stringWithString:_eventString] retain];
    //[self constructEventContent:_eventString];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Button delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)uiReset:(id)sender
{
    NSLog(@"uiReset...");
    [[self delegate] didRemoveWorkers:[searchResultImtes_selected allValues]];
    [searchResultImtes_selected removeAllObjects];
    [searchResultImtes_Cache removeAllObjects];
    [searchTypes removeAllObjects];
    [searchItems_selected removeAllObjects];
    [searchResultImtes removeAllObjects];
    [searchTypeTableView removeAllSubViews];
    [searchItemsView removeAllSubViews];
    [self viewDidLoad];
}

-(IBAction)uiClose:(id)sender
{
    [self.view removeFromSuperview];
    /*
     下面的code是必要的,
     [AttendanceModel share].attendanceType有被監控,
     可利用更改其值(即使相同值)來驅動畫面
     */
    NSInteger m_tmp=[[AttendanceModel share] attendanceType];
    [[AttendanceModel share] setAttendanceType:m_tmp];
    //[self release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table View
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *types = [searchTypes allKeys];
    
    return [types count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MOSearchTableCell";
	
    MOSearchTableCell *cell = (MOSearchTableCell*)[searchTypeTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *_nibs = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
        cell = (MOSearchTableCell*)[_nibs lastObject];
	}
    
    NSArray *types = [searchTypes allValues];
    MOSearchType *type = [types objectAtIndex:indexPath.row];
    [cell.cellLabel setText:type.filterName];
    [cell setDefaultUI];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTypeIdx = indexPath.row;
    NSArray *types = [searchTypes allKeys];
    NSString *type = [types objectAtIndex:indexPath.row];
    NSLog(@"didSelectRowAtIndexPath : type=%@", type);
    currentType = type;
    //[searchTypeTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:0];
    //searchTypeTableView setBackgroundColor:<#(UIColor *)#>
    [self updateSearchItemsView:type];
    [searchTypeTableView reloadData];
    [searchTable_scroll scrollRectToVisible:CGRectMake(0, 144-indexPath.row*46, searchTable_scroll.frame.size.width, searchTable_scroll.frame.size.height) animated:YES];
    UITableViewCell *cell = [searchTypeTableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table View
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//XXXX(done : 09/17) : need a API(prepareData) for formal release.
- (void) prepareData
{
    if(MY_DEBUG == YES)
    {
        [self prepareTestData];
    }
    else
    {
        
        if (searchResultImtes_Cache != Nil) {
            [searchResultImtes_Cache release];
        }
        searchResultImtes_Cache = [NSMutableDictionary new];
        
        if (searchItems_selected != Nil) {
            [searchItems_selected release];
        }
        searchItems_selected = [NSMutableDictionary new];
        
        if (searchTypes != nil) {
            [searchTypes release];
        }
        searchTypes = [[NSMutableDictionary alloc]init];
        
        if (searchResultImtes != nil) {
            [searchResultImtes release];
        }
        searchResultImtes = [[NSMutableDictionary alloc]init];
        
        if (searchResultImtes_selected != nil) {
            [searchResultImtes_selected release];
        }
        searchResultImtes_selected = [[NSMutableDictionary alloc]init];
        NSDictionary *_tmpDic = [self _querySearchTypes];
        [searchTypes addEntriesFromDictionary:_tmpDic];//get all search types
        /*if ([searchTypes count] > 0) {//default is first object
            MOSearchType *_type = [[searchTypes allValues] firstObjectCommonWithArray:[searchTypes allValues]];
            _type.items = [[NSMutableDictionary new]autorelease];
            [_type.items addEntriesFromDictionary:[self _querySearchItems:@"workno" withType:[_type filterType]]];
        }*/
        NSArray *_types = [searchTypes allValues];
        for (int i=0; i<[_types count]; i++) {
            MOSearchType *_type = [_types objectAtIndex:i];
            _type.items = [[NSMutableDictionary new]autorelease];
            [_type.items addEntriesFromDictionary:[self _querySearchItems:@"workno" withType:[_type filterType]]];
        }
        
        //*** Prepare worker
        NSString *json_str = [self prepareJsonForQueryWorkers];
        NSDate *_date = [DateCaculator share].attendanceDay;
        NSInteger _month = [[DateCaculator share] monthInYear:_date] ;
        NSString *_monthStr = [NSString stringWithFormat:@"%d",_month];
        [searchResultImtes addEntriesFromDictionary:[self _queryWorkers:[MOLoginViewController loginInfo].loginId withFilterTime:_monthStr withCondition:json_str]];
    }
}

- (void) prepareTestData
{
    searchTypes = [[NSMutableDictionary alloc]init];
    
    MOSearchType *type1 = [[MOSearchType alloc]init];
    NSMutableDictionary *searchItems1 = [[NSMutableDictionary alloc]initWithCapacity:100];
    for (int i=0; i<150; i++) {
        MOSearchItem *item = [[MOSearchItem alloc]init];
        NSString *content = [NSString stringWithFormat:@"駐地%d",i];
        [item setContent:content];
        [item setSerialNo:[NSString stringWithFormat:@"駐地id%d",i]];
        [item setIsSelected:NO];
        [searchItems1 setValue:[item autorelease] forKey:content];
    }
    type1.filterType = @"assignAddr";
    type1.filterName = @"駐地";
    type1.items = searchItems1;
    [searchTypes setValue:[type1 autorelease] forKey:type1.filterName];
    
    MOSearchType *type2 = [[MOSearchType alloc]init];
    NSMutableDictionary *searchItems2 = [[NSMutableDictionary alloc]init];
    for (int i=0; i<10; i++) {
        MOSearchItem *item = [[MOSearchItem alloc]init];
        NSString *content = [NSString stringWithFormat:@"姓%d",i];
        [item setContent:content];
        [item setSerialNo:[NSString stringWithFormat:@"姓id%d",i]];
        [item setIsSelected:NO];
        [searchItems2 setValue:item forKey:content];
    }
    type2.filterType = @"fName";
    type2.filterName = @"姓氏";
    type2.items = searchItems2;
    [searchTypes setValue:type2 forKey:type2.filterName];
    
    MOSearchType *type3 = [[MOSearchType alloc]init];
    NSMutableDictionary *searchItems3 = [[NSMutableDictionary alloc]init];
    for (int i=0; i<30; i++) {
        MOSearchItem *item = [[MOSearchItem alloc]init];
        NSString *content = [NSString stringWithFormat:@"部門%d",i];
        [item setContent:content];
        [item setSerialNo:[NSString stringWithFormat:@"部門id%d",i]];
        [item setIsSelected:NO];
        [searchItems3 setValue:[item autorelease] forKey:content];
    }
    type3.filterType = @"dept";
    type3.filterName = @"部門";
    type3.items = searchItems3;
    [searchTypes setValue:[type3 autorelease] forKey:type3.filterName];
    
    MOSearchType *type4 = [[MOSearchType alloc]init];
    NSMutableDictionary *searchItems4 = [[NSMutableDictionary alloc]init];
    for (int i=0; i<30; i++) {
        MOSearchItem *item = [[MOSearchItem alloc]init];
        NSString *content = [NSString stringWithFormat:@"出差地%d",i];
        [item setContent:content];
        [item setSerialNo:[NSString stringWithFormat:@"出差地id%d",i]];
        [item setIsSelected:NO];
        [searchItems4 setValue:[item autorelease] forKey:content];
    }
    type4.filterType = @"evtAddr";
    type4.filterName = @"出差地";
    type4.items = searchItems4;
    [searchTypes setValue:[type4 autorelease] forKey:type4.filterName];
    
    searchResultImtes = [[NSMutableDictionary alloc]init];
    /*for (int i=0; i<300; i++) {
        MOSearchResultItem *item = [[MOSearchResultItem alloc]init];
        NSString *content = [NSString stringWithFormat:@"胡智宇%d",i];
        NSString *serialNo = [NSString stringWithFormat:@"胡智宇%d",i];
        [item setName:content];
        [item setWorkNo:serialNo];
        [item setIsSelected:NO];
        [searchResultImtes setValue:[item autorelease] forKey:serialNo];
    }*/
    searchResultImtes_selected = [[NSMutableDictionary alloc]init];
}

@end







