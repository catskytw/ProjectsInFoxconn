//
//  AuditContent1View.m
//  Audit
//
//  Created by Chang Link on 11/9/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffContent1View.h"
#import "SignOffTypeCell.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
@implementation SignOffContent1View

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
    dataArray = [[NSMutableArray alloc]  initWithObjects:  AMLocalizedString(@"confirmLeave", nil)
                 ,AMLocalizedString(@"askLeave", nil),AMLocalizedString(@"confirmWork", nil),AMLocalizedString(@"bussinessTrip", nil),AMLocalizedString(@"confirmTrip", nil),AMLocalizedString(@"backHome", nil) ,nil];
    [dataTable reloadData];
    [dataTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    SignOffTypeCell *cell = (SignOffTypeCell *)[tableView dequeueReusableCellWithIdentifier:@"SignOffTypeCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SignOffTypeCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    cellHeight = cell.frame.size.height;
    [cell setDO:[dataArray objectAtIndex:indexPath.row]];
	return cell;
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"Import SN didSelectRowAtIndexPath indexPath :%d",indexPath.row);
    [[NSNotificationCenter defaultCenter] postNotificationName:FlowEnumNotification object:[NSString stringWithFormat:@"%d",indexPath.row]];
    
}
@end
