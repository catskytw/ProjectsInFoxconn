//
//  Attendance1View.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "Attendance1View.h"
#import "AttendanceFunCell.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "FcDrawing.h"
#import "AttendanceModel.h"
@implementation Attendance1View
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setInfo{
    cellHeight = 77;
    dataArray = [[NSMutableArray alloc]  initWithObjects:AMLocalizedString(@"trip", nil),AMLocalizedString(@"takeLeave", nil),AMLocalizedString(@"overtime", nil),nil];
    [dataTable reloadData];
    [dataTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]  animated:NO scrollPosition:UITableViewScrollPositionTop];//預設選定第一個cell
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AttendanceFunCell *cell = (AttendanceFunCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendanceFunCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AttendanceFunCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    switch ([indexPath row]) {
        case 0:
            [cell.funImage setImage:[FcDrawing loadUIImage:@"img_business_l" withType:@"png"]];
            break;
        case 1:
            [cell.funImage setImage:[FcDrawing loadUIImage:@"img_leave_l" withType:@"png"]];
            break;
        case 2:
            [cell.funImage setImage:[FcDrawing loadUIImage:@"img_overtime_l" withType:@"png"]];
            break;
        //TODO if you have more options, please add items here.
    }
    [cell setDO:[dataArray objectAtIndex:[indexPath row]]];
	return cell;
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [AttendanceModel share].attendanceType=[indexPath row];
}
@end
