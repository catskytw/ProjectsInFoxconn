//
//  SignOffNameListCell.m
//  MobileOffice
//
//  Created by Chang Link on 11/9/5.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffNameListCell.h"

#import "SignOffContent3View.h"
@implementation SignOffNameListCell
@synthesize nameLabel;
@synthesize typenameLabel;
@synthesize seperateImgView;
@synthesize uncheckImgView,checkImgView;
@synthesize checkedBtn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(NSString*)addFlowTypeName:(NSString*)name  FlowEnum:(FlowTypeEnum)flowEnum{
    switch (flowEnum) {
        case FLOWTYPE_CONFIRMLEAVE:
            return [name stringByAppendingString:@" 銷假單"];
            
        case FLOWTYPE_ASKLEAVE:
            return [name stringByAppendingString:@" 請假單"];
            
        case FLOWTYPE_CONFIRMWORK:
            return [name stringByAppendingString:@" 出勤單"];
            
        case FLOWTYPE_BUSSINESSTRIP:
            return [name stringByAppendingString:@" 出差單"];
            
        default:
            break;
    }
    return name;
}
-(NSString*)flowTypeName:(FlowTypeEnum)flowEnum{
    switch (flowEnum) {
        case FLOWTYPE_CONFIRMLEAVE:
            return @" 銷假單";
            
        case FLOWTYPE_ASKLEAVE:
            return @" 請假單";
            
        case FLOWTYPE_CONFIRMWORK:
            return @" 出勤單";
            
        case FLOWTYPE_BUSSINESSTRIP:
            return @" 出差單";
            
        default:
            return @"";
            break;
    }
    return @"";
}
-(void)setDO:(SignOffNameListCellDO*)cellDO{
    if ([cellDO.name length]==0) {
        bNull = YES;
        checkedBtn.hidden = YES;
        uncheckImgView.hidden = YES;
    }else{
        bNull = NO;
    }
    typenameLabel.text= @"";
    nameLabel.text = cellDO.name;
    if(!bNull)
        typenameLabel.text = [self flowTypeName:cellDO.flowEnum];
    
    selectedArray = [NSMutableArray new];
    [selectedArray addObject:nameLabel];
    seperateLineRect = seperateImgView.frame;
    index = cellDO.index;
    sTaskId = cellDO.taskId;
    [super setLayout];    
    //[self bringSubviewToFront:checkedBtn];
    [self bringSubviewToFront:checkImgView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCheckedTaskIdNotification:) name:TaskIdNotification object:nil];
}
-(void)getCheckedTaskIdNotification:(NSNotification*)noti{
    BOOL bTask = [[noti object] isEqualToString:sTaskId];
    if (!bTask) {
        checkImgView.hidden = YES; 
    }
    //bChecked = bTask;
    //[self setSelected:bChecked animated:YES];
}
-(IBAction)check:(id)sender{
    //not click
    if(![SignOffContent3View checkTaskId:sTaskId])
    { 
        checkImgView.hidden = bChecked;
        bChecked = !bChecked;
    
        if (bChecked) {
            [[NSNotificationCenter defaultCenter] postNotificationName:TaskIdNotification object:sTaskId];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:TaskIdNotification object:@"-"];  
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
   
    if (bNull) 
        return;
    
    checkImgView.hidden = !selected;
    bChecked = selected;
    if (bChecked) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TaskIdNotification object:sTaskId];        
    }else{
        //[[NSNotificationCenter defaultCenter] postNotificationName:TaskIdNotification object:@"-"];  
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:AgreeEnableNotification object:[NSString stringWithFormat:@"%d", bChecked]];
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc {
    [checkedBtn release];
    [uncheckImgView release];
    [nameLabel release];
    [seperateImgView release];
    if (selectedArray) {
        [selectedArray release];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TaskIdNotification object:nil];
    [typenameLabel release];
    [super dealloc];
}
@end
