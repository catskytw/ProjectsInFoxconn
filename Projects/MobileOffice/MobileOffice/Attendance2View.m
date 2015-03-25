//
//  Attendance2View.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "Attendance2View.h"
#import "AttendanceCell.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "AttendanceModel.h"
#import "AttendanceCell.h"
#import "TravelDataObject.h"
#import "OverDataObject.h"
#import "DateCaculator.h"
@class FcContent2View;
@interface Attendance2View(PrivateMethod)
-(NSString*)getCellBundleName:(NSInteger)_attendanceType;
-(AttendanceCell*)setAttendanceCell:(OverTimeCell*)_cell withIndexPath:(NSIndexPath*)_indexPath;
-(OverTimeCell*)setOverTimeCell:(OverTimeCell*)_cell withIndexPath:(NSIndexPath*)_indexPath;
-(NSMutableArray*)chooseAttendanceDataArray:(NSInteger)_attendanceType;
-(void)cancelBtnAction:(id)sender;
-(void)caculateTableHeight;
-(void)refreshTable;
@end
@implementation Attendance2View
-(void)dealloc{
    [super dealloc];
}
-(void)setInfo{
    attendanceType=ATTENDANCE_TRAVEL;
    [self setLayout];
    cellHeight=48;
    if (!dataArray) {
        dataArray = [self chooseAttendanceDataArray:attendanceType];
    }
    [[AttendanceModel share]addObserver:self forKeyPath:@"attendanceType" options:NSKeyValueObservingOptionNew context:NULL]; 
}
-(void)setLayout{
    UIColor *color=[UIColor colorWithPatternImage:[TUNinePatchCache imageOfSize:CGSizeMake(135, 3) forNinePatchNamed:@"line_step2"]];
    [dataTable setSeparatorColor:color];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat m_height=0.0f;
    if(attendanceType==ATTENDANCE_TRAVEL){
        TravelDataObject *m_thisObject=[[AttendanceModel share].attendanceArray objectAtIndex:[indexPath row]];
        NSInteger m_count=([m_thisObject.evtAddrList count]>1)?[m_thisObject.evtAddrList count]:1;
        m_height= m_count*cellHeight;
    }
    else
        m_height=cellHeight;
    return m_height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger m_rows=0;
    tableContentHeight=0;
    switch (attendanceType) {
        case ATTENDANCE_TRAVEL:
            m_rows=[[AttendanceModel share].attendanceArray count];
            break;
        case ATTENDANCE_OVERTIME:
            m_rows=[[AttendanceModel share].overTimeArray count];
            break;
        case ATTENDANCE_OFF:
            m_rows=[[AttendanceModel share].offArray count];
            break;
    }
    return m_rows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *m_cellName=[self getCellBundleName:attendanceType];
    OverTimeCell *cell = (OverTimeCell*)[tableView dequeueReusableCellWithIdentifier:m_cellName];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:m_cellName owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
	}
    switch (attendanceType) {
        case ATTENDANCE_TRAVEL:
            [self setAttendanceCell:cell withIndexPath:indexPath];
            break;
        case ATTENDANCE_OVERTIME:
        case ATTENDANCE_OFF:
            [self setOverTimeCell:cell withIndexPath:indexPath];
            break;
        default:
            break;
    }
    [cell.cancelBtn setTag:[indexPath row]];
    [cell.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.separator setImage:[TUNinePatchCache imageOfSize:CGSizeMake(135, 3) forNinePatchNamed:@"line_step2"]];
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     CGPoint offSet=scrollView.contentOffset;
     NSMutableDictionary *dicInfo=[NSMutableDictionary dictionary];
     [dicInfo setValue:[[NSValue valueWithCGPoint:offSet]retain] forKey:@"offset"];
     [[NSNotificationCenter defaultCenter]postNotificationName:Attendance3ViewYOffSet object:nil userInfo:dicInfo];
}

//TODO fix the API parameters
-(void)queryDataController:(NSInteger)_attendanceType{
    NSDate *m_firstDate= [[DateCaculator share]firstDateInMonth:[[DateCaculator share] selectedDay]];
    NSDate *m_lastDate= [[DateCaculator share]lastDateInMonth:[[DateCaculator share] selectedDay]];
    switch (_attendanceType) {
        case ATTENDANCE_TRAVEL:
            [[AttendanceModel share]getTravelData:[AttendanceModel share].workNos withStartDate:m_firstDate withEndDate:m_lastDate];
            break;
        case ATTENDANCE_OVERTIME:
            [[AttendanceModel share]getOTList:[AttendanceModel share].workNos withStartDate:m_firstDate withEndDate:m_lastDate];
            break;
        case ATTENDANCE_OFF:
            [[AttendanceModel share]getLeaveList:[AttendanceModel share].workNos withStartDate:m_firstDate withEndDate:m_lastDate];
            break;
        default:
            break;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSInteger m_AttendanceType=[((NSString*)[change objectForKey:NSKeyValueChangeNewKey]) intValue];
    attendanceType=m_AttendanceType;
    [self queryDataController:m_AttendanceType];
    dataArray=[self chooseAttendanceDataArray:attendanceType];
    [self refreshTable];
    switch (m_AttendanceType) {
        case ATTENDANCE_TRAVEL:
            [[NSNotificationCenter defaultCenter] postNotificationName:DrawAttendanceSchedule object:nil];
            break;
        case ATTENDANCE_OVERTIME:
            [[NSNotificationCenter defaultCenter] postNotificationName:DrawOverTimeShcedule object:nil];
            break;
        case ATTENDANCE_OFF:
            [[NSNotificationCenter defaultCenter] postNotificationName:DrawOffSchedule object:nil];
            break;
        default:
            break;
    }
}

-(NSString*)getCellBundleName:(NSInteger)_attendanceType{
    NSString *m_returnName;
    switch (_attendanceType) {
        case ATTENDANCE_TRAVEL:
            m_returnName=@"AttendanceCell";
            break;
        case ATTENDANCE_OVERTIME:
        case ATTENDANCE_OFF:
            m_returnName=@"OverTimeCell";
        default:
            break;
    }
    return m_returnName;
}

-(NSMutableArray*)chooseAttendanceDataArray:(NSInteger)_attendanceType{
    NSMutableArray *m_returnArray;
    switch (_attendanceType) {
        case ATTENDANCE_TRAVEL:
            m_returnArray=[AttendanceModel share].attendanceArray;
            break;
        case ATTENDANCE_OVERTIME:
            m_returnArray=[AttendanceModel share].overTimeArray;
            break;
        case ATTENDANCE_OFF:
            m_returnArray=[AttendanceModel share].offArray;
            break;
    }
    return m_returnArray;
}
-(OverTimeCell*)setOverTimeCell:(OverTimeCell*)_cell withIndexPath:(NSIndexPath*)_indexPath{
    OverTimeCell *m_cell=_cell;
    OverDataObject *m_obj=(OverDataObject*)[dataArray objectAtIndex:[_indexPath row]];
    m_cell.workNo=m_obj.workNo;
    [m_cell.nameLabel setText:m_obj.cname];
    return m_cell;
}
-(AttendanceCell*)setAttendanceCell:(OverTimeCell*)_cell withIndexPath:(NSIndexPath*)_indexPath{
    AttendanceCell *m_cell=(AttendanceCell*)_cell;
    TravelDataObject *m_dataObject=[dataArray objectAtIndex:[_indexPath row]];
    [m_cell.nameLabel setText:m_dataObject.cname];
    [m_cell.assignAddr setText:m_dataObject.assignAddr];
    
    NSInteger startX=91;
    NSInteger startY=28;
    NSInteger spaceY=48;
    NSInteger count=0;
    for(NSString *purpose in m_dataObject.evtAddrList){
        UILabel *m_label=[[UILabel alloc] initWithFrame:CGRectMake(startX, startY+(spaceY*count), 42, 14)];
        [m_label setTextColor:[UIColor blackColor]];
        [m_label setFont:[UIFont fontWithName:DefaultFontName size:14.0f]];
        [m_label setBackgroundColor:[UIColor clearColor]];
        [m_label setText:purpose];
        m_label.textAlignment=UITextAlignmentRight;
        [m_cell addSubview:[m_label autorelease]];
        count++;
    }
    return m_cell;
}
-(void)cancelBtnAction:(id)sender{
    UIButton *m_thisBtn=(UIButton*)sender;
    NSString *m_attendanceString=nil;
    switch ([AttendanceModel share].attendanceType) {
        case ATTENDANCE_TRAVEL:
            [[AttendanceModel share].attendanceArray removeObjectAtIndex:m_thisBtn.tag];
            m_attendanceString=DrawAttendanceSchedule;
            break;
        case ATTENDANCE_OVERTIME:
            [[AttendanceModel share].overTimeArray removeObjectAtIndex:m_thisBtn.tag];
            m_attendanceString=DrawOverTimeShcedule;
            break;
        case ATTENDANCE_OFF:
            [[AttendanceModel share].offArray removeObjectAtIndex:m_thisBtn.tag];
            m_attendanceString=DrawOffSchedule;
            break;
    }
    [self refreshTable];
    [[NSNotificationCenter defaultCenter] postNotificationName:m_attendanceString object:nil];
}
-(void)refreshTable{
    [dataTable reloadData];
    [self caculateTableHeight];
}
-(void)caculateTableHeight{
    [AttendanceModel share].tableHeight=dataTable.contentSize.height;
}
@end
