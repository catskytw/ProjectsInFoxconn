//
//  AuditContent2View.m
//  Audit
//
//  Created by Chang Link on 11/9/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffContent2View.h"
#import "SignOffNameListCellDO.h"
#import "FcContent2View.h"
#import "SignOffNameListCell.h"
#import "SignOffNameListCellDO.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "MOLoginViewController.h"
#import "MOLoginInfo.h"
@implementation SignOffContent2View
@synthesize tableLineImg;
@synthesize searchFcTf;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setLayout{
    tableLineImg.image = [TUNinePatchCache imageOfSize:tableLineImg.frame.size forNinePatchNamed:@"line_step2"];
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"FcTextField"
                                                      owner:self
                                                    options:nil];
    searchFcTf = ((FcTextField*)[nibViews objectAtIndex: 0]);
    [searchFcTf setDelegate:self];
    searchFcTf.frame = CGRectMake(24, 20, searchFcTf.frame.size.width, searchFcTf.frame.size.height);
    [searchFcTf setLayout];
    [self addSubview:searchFcTf];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFlowEnumNotification:) name:FlowEnumNotification object:nil];
}
-(void)getFlowEnumNotification:(NSNotification*)noti{
    flowEnum = [(NSString*)[noti object] intValue];
    [self getData];
    [dataTable reloadData];
    selectedIndex = -1;
    [(FcContent2View*)self.superview moveArrow];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"Step2 textFieldDidBeginEditing");
    searchFcTf.bFocus = YES;
    [searchFcTf setLayout];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    searchFcTf.bFocus = NO;
    NSLog(@"textFieldDidEndEditing %@", textField.text);
    [searchFcTf setLayout];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn %@", textField.text);
    if (dataArray) {
        [dataArray removeAllObjects];
    }else{
        dataArray = [NSMutableArray new];
    }
    if (querryData) {
        for (SignOffNameListCellDO *dao in querryData) {
            NSRange textRange;
            textRange =[[dao.name lowercaseString] rangeOfString:[textField.text lowercaseString]];
            
            if(textRange.location != NSNotFound || textField.text.length ==0) {
                [dataArray addObject:dao];
            }
        }
        [dataTable reloadData];
    }
    [textField resignFirstResponder];
    return YES;
}
-(void)getData{
    QueryPattern *qp=[QueryPattern new];
    NSString *sWorkNo;
    

    sWorkNo=  [MOLoginViewController loginInfo].loginId;
  
    NSString *sType = [NSString stringWithFormat:@"%d",flowEnum];
    
	[qp prepareDic:getFlowTaskList([MOLoginViewController loginInfo].sessionId,sWorkNo,sType)];
    if (dataArray) {
        [dataArray removeAllObjects];
    }else{
        dataArray = [NSMutableArray new];
    }
    if (querryData) {
        [querryData removeAllObjects];
    }else{
        querryData = [NSMutableArray new];
    }
    @try {
        for(int i=0;i<[qp getNumberUnderNode:@"taskList" withKey:@"initiatorName"];i++){
            
            SignOffNameListCellDO *dao = [SignOffNameListCellDO new];
            dao.name = [qp getValue:@"initiatorName" withIndex:i];
            //dao.employee_name = [self addFlowTypeName:[qp getValue:@"initiatorName" withIndex:i]];
            dao.taskId = [qp getValue:@"taskId" withIndex:i];
            dao.flowName = [qp getValue:@"flowName" withIndex:i];
            dao.flowType = [qp getValue:@"flowType" withIndex:i];
            dao.flowEnum = flowEnum;
            dao.bChecked = NO;
            [querryData addObject:dao];
            [dataArray addObject:dao];
        }
    }
    @catch (NSException * e) {
       //NPLogException(e);
    }
    @finally {
        [qp release];
    }
}
-(void)setInfo{
    [self setLayout];


    [self getData];
    cellHeight = 46;
    [dataTable reloadData];

    
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

    if ([dataArray count]<13) {
        dataTable.scrollEnabled = NO;
    }
    return ([dataArray count]>13)?[dataArray count]:13;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SignOffNameListCell *cell = (SignOffNameListCell *)[tableView dequeueReusableCellWithIdentifier:@"SignOffNameListCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SignOffNameListCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    cellHeight = cell.frame.size.height;
    if (indexPath.row<[dataArray count]) {
        SignOffNameListCellDO *cellDo =(SignOffNameListCellDO*)[dataArray objectAtIndex:indexPath.row];
        cellDo.index = indexPath.row;
        [cell setDO:cellDo];
    }else{
        SignOffNameListCellDO* nullDO = [SignOffNameListCellDO new];
        nullDO.index = indexPath.row;
        [cell setDO:nullDO];
        [nullDO release];
    }
    
	return cell;
}
#pragma mark -
#pragma mark Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=[dataArray count]) {        
        return;
    }
    selectedIndex = indexPath.row;
    [(FcContent2View*)self.superview moveArrow];
    SignOffNameListCellDO *cellDo =(SignOffNameListCellDO*)[dataArray objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:FlowTypeNotification object:cellDo.flowType];
    [[NSNotificationCenter defaultCenter] postNotificationName:TaskIdNotification object:cellDo.taskId];
     NSLog(@"didSelectRowAtIndexPath flowType %@", cellDo.flowType);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [(FcContent2View*)self.superview moveArrow];
    
}
- (void)dealloc {
    [tableLineImg release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (querryData) {
        [querryData release];
    }
    [super dealloc];
}
@end
