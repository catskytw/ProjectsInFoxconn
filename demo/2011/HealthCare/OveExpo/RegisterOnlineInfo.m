//
//  RegisterOnlineInfo.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegisterOnlineInfo.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "FcGroupTableCell.h"
#import "Tools.h"
#import "RegisterOnlineDataAdaptor.h"
#import "RegisterOnlineDummyDao.h"
#import "DateUtilty.h"
#import "RegistrySelectedRecord.h"
@interface RegisterOnlineInfo(PrivateMethod)
-(void)fetchData;
-(void)releaseLocalData;
-(void)resetAllContentLabelColor;
-(UILabel*)makeContentLabel;
-(UILabel*)searchContentLabel:(UITableViewCell*)_cell;
@end
@implementation RegisterOnlineInfo
@synthesize hospitablName,departmentName,comment,contentTable,registryCount,registryBtn,btnBackImage,lineImage,queryId;
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    fcPicker=[FcPickerController new];
    contentArray=[[NSMutableArray array] retain];
    [self fetchData];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [contentArray release];
    [self releaseLocalData];
    [super viewDidUnload];
}
#pragma -

#pragma mark - DelegateMethod
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *m_CellIdentifier = @"RegisterInfoTableCell";
    
    FcGroupTableCell *m_cell = [tableView dequeueReusableCellWithIdentifier:m_CellIdentifier];
    UILabel *m_contentLabel=nil;
    if (m_cell == nil) {
        m_cell = [[[FcGroupTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:m_CellIdentifier] autorelease];
        m_contentLabel=[self makeContentLabel];
        [m_cell addSubview:m_contentLabel];
        [contentArray addObject:m_contentLabel];
    }
    m_cell.textLabel.text= AMLocalizedString([labelArray objectAtIndex: indexPath.row],nil);
    m_cell.textLabel.frame = CGRectMake(GroupCellLabelDiff_Left, m_cell.textLabel.frame.origin.y, m_cell.textLabel.frame.size.width, m_cell.textLabel.frame.size.height);
    [m_cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    NSString *m_tmpString=nil;
    switch (indexPath.row) {
        case 0:
            m_cell.mode =FcGroupTableCellMode_TOP;
            m_tmpString=[NSString stringWithFormat:@"%.f",[[NSDate date]timeIntervalSince1970]*1000];
            [m_contentLabel setText:[DateUtilty dateString:m_tmpString]];
            break;
        case 1:
            m_cell.mode = FcGroupTableCellMode_MIDDLE;
            [m_contentLabel setText:[regInfoDataObj.times objectAtIndex:0]];
            break;
        case 2:
            m_cell.mode = FcGroupTableCellMode_BUTTON;
            [m_contentLabel setText:[regInfoDataObj.doctors objectAtIndex:0]];
            break;
    }
    [m_cell setLayout];
    return m_cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self resetAllContentLabelColor];
    UILabel *m_thisLabel=[contentArray objectAtIndex:indexPath.row];
    [m_thisLabel setTextColor:[UIColor whiteColor]];
    actionType=[indexPath row];
    switch (actionType) {
        case 0:
            [fcPicker usingDatePicker:YES];
            break;
        case 1:
            pickerDataArray=regInfoDataObj.times;
            [fcPicker usingDatePicker:NO];
            break;
        case 2:
            pickerDataArray=regInfoDataObj.doctors;
            [fcPicker usingDatePicker:NO];
            break;
    }
    [fcPicker.picker reloadAllComponents];
    [fcPicker slideUp:YES];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerDataArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return (NSString*)[pickerDataArray objectAtIndex:row];
}
-(void)pickerSubmit{
    [fcPicker slideUp:NO];
    int m_row=0;
    NSString *m_tmpString;
    UILabel *m_tmpLabel;
    switch (actionType){
        case 0:
            m_tmpString=[NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
            m_tmpLabel=(UILabel*)[contentArray objectAtIndex:0];
            [m_tmpLabel setText:[DateUtilty dateString:m_tmpString]];
            break;
        case 1:
            m_row = [fcPicker.picker selectedRowInComponent:0];
            m_tmpLabel=(UILabel*)[contentArray objectAtIndex:1];
            [m_tmpLabel setText:[regInfoDataObj.times objectAtIndex:m_row]];
            break;
        case 2:
            m_row = [fcPicker.picker selectedRowInComponent:0];
            m_tmpLabel=(UILabel*)[contentArray objectAtIndex:2];
            [m_tmpLabel setText:[regInfoDataObj.doctors objectAtIndex:m_row]];
            break;
    }
}
-(void)pickerCancel{
    [fcPicker slideUp:NO];
}
#pragma -
#pragma mark - ActionMethod
-(IBAction)registryAction:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"message", nil) message:AMLocalizedString(@"registrySuccess", nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"close", nil) otherButtonTitles: nil];
    [alert show];
}
#pragma -
#pragma mark - Layout
-(UILabel*)makeContentLabel{
    CGSize m_stringSize=[Tools estimateStringSize:AMLocalizedString(@"Register_Hospital",nil) withFontSize:16.0f withMaxSize:ccs(100, 30)];
    CGRect m_lblRect = CGRectMake(GroupCellLabelDiff_Left+m_stringSize.width+GroupCellLabel_Space, 0, GroupCellWidth-(GroupCellLabelDiff_Left+m_stringSize.width+GroupCellLabel_Space), GroupCellHeight);
    
    UILabel *m_returnLabel= [[UILabel alloc] initWithFrame:m_lblRect];
    m_returnLabel.tag=9999; //特殊之tag,用來辨識
    [m_returnLabel setBackgroundColor:[UIColor clearColor]];
    m_returnLabel.textAlignment = UITextAlignmentLeft;
    [m_returnLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [m_returnLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    return m_returnLabel;
}
-(void)setUIDefault{
    [super setUIDefault];
    [self settingBtnStyle:registryBtn];
    contentTable.backgroundView = [[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:contentTable.frame.size forNinePatchNamed:@"group_table"]]autorelease];
    [btnBackImage setImage:[TUNinePatchCache imageOfSize:btnBackImage.frame.size forNinePatchNamed:@"bg_black"]];
    [lineImage setImage:[TUNinePatchCache imageOfSize:lineImage.frame.size forNinePatchNamed:@"bg_line"]];
    [registryBtn setTitle:AMLocalizedString(@"registryNow", nil) forState:UIControlStateNormal];
    [comment setText:regInfoDataObj.comment];
    [registryCount setText:regInfoDataObj.registryCount];
    [hospitablName setText:[RegistrySelectedRecord share].hospitablName];
    [departmentName setText:[RegistrySelectedRecord share].departmentName];
    
    fcPicker.delegate = self;
    fcPicker.pickerdelegate = self;
    
    [self.view addSubview:fcPicker.view];
    fcPicker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif, fcPicker.view.frame.size.width, fcPicker.view.frame.size.height);
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    labelArray=[[NSArray arrayWithObjects:
                 @"date",@"time",@"doctor", nil] retain];
    RegisterOnlineDataAdaptor *m_dao=[RegisterOnlineDummyDao new];
    regInfoDataObj=[[m_dao getRegistryOnlineData:queryId] retain];
}
-(void)releaseLocalData{
    [labelArray release];
}
#pragma -
#pragma mark - PrivateMethod
-(void)resetAllContentLabelColor{
    for(UILabel *m_label in contentArray)
        [m_label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
}
-(UILabel*)searchContentLabel:(UITableViewCell*)_cell{
    NSArray *subViews=[_cell subviews];
    for(id subView in subViews){
        if([subView isKindOfClass:[UILabel class]] && ((UILabel*)subView).tag==9999)
            return (UILabel*)subView;
    }
    return nil;
}
#pragma -
@end
