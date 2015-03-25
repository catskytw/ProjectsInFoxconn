//
//  CustomerInfo_Editor.m
//  HealthCare
//
//  Created by Jeff foxconn on 11/11/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomerInfo_Editor.h"
#import "CustomerInfo_Cell.h"

#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "DummyData.h"
#import "NinePatch.h"

@interface CustomerInfo_Editor(PrivateMethod)
- (void) initData;
-(void) setUIDefault;
- (BOOL) _getCustomerInfo:(NSString *)result;
-(void) maintainCellColor:(NSInteger)newIndex;
@end

@implementation CustomerInfo_Editor
@synthesize detailTable;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    isEditing=NO;
    [self initData];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(CGSize) getMaximumLengthFromFieldNames:(NSArray *)_fields_name font:(UIFont *)_font
{
    //計算出最長title的字串長度, 用來作輸入框的對齊
    CGSize m_titleMaxSize = CGSizeMake(0, 0);
    CGSize m_tmpSize = CGSizeMake(0, 0);
    for (int i=0; i<[_fields_name count]; i++) {
        NSString *_field = [_fields_name objectAtIndex:i];
        m_tmpSize = [_field sizeWithFont:_font];
        if (m_tmpSize.width > m_titleMaxSize.width) {
            m_titleMaxSize = m_tmpSize;
        }
    }
    return m_titleMaxSize;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomerInfo_Cell";
	CustomerInfo_Cell *cell = (CustomerInfo_Cell *)[detailTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"CustomerInfo_Cell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[CustomerInfo_Cell class]]){
                cell=(CustomerInfo_Cell*)currentObject;
                [cell.textField1 setDelegate:self];
                if (indexPath.row < [fields_name count]) {
                    [cell.label1 setText:[fields_name objectAtIndex:indexPath.row]];
                    //[cell.textField1 setText:[card_fields_value objectAtIndex:indexPath.row]];
                    [cell.textField1 setText:[fieldName_value_map valueForKey:cell.label1.text]];
                    [cell.textField1 setTag:indexPath.row];
                    
                    //根據title動態調整輸入框大小
                    CGSize stringSize = [self getMaximumLengthFromFieldNames:fields_name font:cell.label1.font];
                    [cell.label1 setFrame:CGRectMake(cell.label1.frame.origin.x, cell.label1.frame.origin.y, stringSize.width, cell.label1.frame.size.height)];
                    [cell.textField1 setFrame:CGRectMake(cell.label1.frame.origin.x + cell.label1.frame.size.width + 6, cell.textField1.frame.origin.y, cell.frame.size.width - (cell.label1.frame.origin.x + stringSize.width + 6), cell.textField1.frame.size.height)];
                }
                break;
            }
        }
	}
    
    [cell setFcLayout:indexPath withRows:[fields_name count]];
    //Set cell text
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomerInfo_Cell *_cell = (CustomerInfo_Cell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 resignFirstResponder];
    [self maintainCellColor:indexPath.row];
    currentSelRow = indexPath.row;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger row_count = 0;
    row_count = [fields_name count];
    return row_count;
}
#pragma mark

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [baseScroll scrollRectToVisible:CGRectMake(0, 0, 320, 460) animated:YES];
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
    
    //reach
    NSIndexPath *_indexP = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    CustomerInfo_Cell *_cell = (CustomerInfo_Cell *)[detailTable cellForRowAtIndexPath:_indexP];
    //[card_table_map setValue:textField.text forKey:_cell.label1.text];
}
#pragma mark

#pragma mark - keyboard delegate
-(void) keyboardWasShown:(NSNotification *)nsNotification {
    NSDictionary *userInfo = [nsNotification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int table_cell_y = detailTable.rowHeight*currentSelRow + detailTable.frame.origin.y - baseScroll.contentOffset.y;
    int _height = baseScroll.frame.size.height - table_cell_y;//need to > 260
    if (_height < kbSize.height) {
        [baseScroll setContentOffset:CGPointMake(baseScroll.contentOffset.x, baseScroll.contentOffset.y + (kbSize.height - _height)) animated:YES];
    }
}
#pragma mark

#pragma mark - keyboard delegate
-(void)rightItemAction:(id)sender{
    isEditing=!isEditing;
    [detailTable setEnabled:isEditing];
    if(isEditing)
        [self setRightItem2:AMLocalizedString(@"complete", nil)];
    else{
        [self maintainCellColor:-1];
        [baseScroll scrollRectToVisible:CGRectMake(0, 0, 320, 460) animated:YES];
        
        NSInteger m_rowCount = [fields_name count];
        for (int i=0;i<m_rowCount;i++) {
            CustomerInfo_Cell *m_cell = (CustomerInfo_Cell *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
            [m_cell.textField1 resignFirstResponder];
        }
        [self setRightItem:AMLocalizedString(@"edit", nil)];
    }
}
#pragma mark

#pragma mark -  PrivateMethod
-(void)initData{
    user = [[DummyData getCustomerInfo]retain];
    if (fieldName_value_map == nil) {
        fieldName_value_map = [NSMutableDictionary new];
    }
    else
    {
        [fieldName_value_map removeAllObjects];
    }
    
    [fieldName_value_map setObject:user.lastName forKey:AMLocalizedString(@"姓",nil)];
    [fieldName_value_map setObject:user.firstName forKey:AMLocalizedString(@"名",nil)];
    [fieldName_value_map setObject:user.phoneNum forKey:AMLocalizedString(@"電話",nil)];
    [fieldName_value_map setObject:user.address forKey:AMLocalizedString(@"地址",nil)];
    [fieldName_value_map setObject:user.email forKey:AMLocalizedString(@"email",nil)];
    [fieldName_value_map setObject:user.emergencyContact forKey:AMLocalizedString(@"緊急聯絡人",nil)];
    [fieldName_value_map setObject:user.note forKey:AMLocalizedString(@"備註",nil)];
    
    if (fields_name == nil) {
        fields_name = [NSMutableArray new];
    }
    else
    {
        [fields_name removeAllObjects];
    }
    [fields_name addObject:AMLocalizedString(@"姓",nil)];
    [fields_name addObject:AMLocalizedString(@"名",nil)];
    [fields_name addObject:AMLocalizedString(@"電話",nil)];
    [fields_name addObject:AMLocalizedString(@"地址",nil)];
    [fields_name addObject:AMLocalizedString(@"email",nil)];
    [fields_name addObject:AMLocalizedString(@"緊急聯絡人",nil)];
    [fields_name addObject:AMLocalizedString(@"備註",nil)];
}

-(void) setUIDefault{
    //[self initData];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"userInfo",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [self setRightItem:AMLocalizedString(@"edit",nil)];
    [detailTable setEnabled:NO];
    [detailTable setFrame:CGRectMake(detailTable.frame.origin.x, detailTable.frame.origin.y, detailTable.frame.size.width, detailTable.rowHeight*[fields_name count])];
    [baseScroll setContentSize:CGSizeMake(self.view.frame.size.width, detailTable.frame.origin.y + detailTable.frame.size.height+250)];
    baseScroll.scrollEnabled=NO;
    detailTable.backgroundView = [[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:detailTable.frame.size forNinePatchNamed:@"group_table"]]autorelease];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

-(void) maintainCellColor:(NSInteger)newIndex
{
    if(currentSelRow==newIndex) return;
    CustomerInfo_Cell *_cell = (CustomerInfo_Cell *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
    [_cell.textField1 setTextColor:[UIColor colorWithRed:57/255.0 green:85/255.0 blue:135/255.0 alpha:1]];
    [_cell.label1 setTextColor:[UIColor blackColor]];
    _cell.selected=NO;
    currentSelRow = newIndex;
    if (newIndex>=0) {
        _cell = (CustomerInfo_Cell *)[detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelRow inSection:0]];
        [_cell.textField1 setTextColor:[UIColor whiteColor]];
        [_cell.label1 setTextColor:[UIColor whiteColor]];
    }
}
#pragma mark
@end
