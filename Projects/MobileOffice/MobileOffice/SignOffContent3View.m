//
//  AuditContent3View.m
//  Audit
//
//  Created by Chang Link on 11/9/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffContent3View.h"
#import "NinePatch.h"
#import "ProjectTool.h"
#import "FcConfig.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "LocalizationSystem.h"
#import "MOLoginViewController.h"
#import "MOLoginInfo.h"
@implementation SignOffContent3View
@synthesize idLabel;
@synthesize uidLabel;
@synthesize deptLabel;
@synthesize jobTitleLabel;
@synthesize line5Img;
@synthesize line4Img;
@synthesize line3Img;
@synthesize line2Img;
@synthesize line1Img;
@synthesize idDataLabel;
@synthesize uidDataLabel;
@synthesize orgDataLabel;
@synthesize titleDataLabel;
@synthesize infoScrollView;
@synthesize agreeBtn;
@synthesize rejectBtn;
@synthesize commentTV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dataArray=[[NSMutableArray array] retain];
    }
    return self;
}
- (IBAction)agree:(id)sender {
    NSLog(@"agree");
    [self completeFlowTask:1];
}

- (IBAction)reject:(id)sender {
    NSLog(@"reject");
     [self completeFlowTask:0];
    
}
-(void)completeFlowTask:(int)eventMode{
    QueryPattern *qp=[QueryPattern new];
    NSString *sRemark=commentTV.text;
	[qp prepareDic:completeFlowTask([MOLoginViewController loginInfo].sessionId,TaskId,eventMode,sRemark)];

    @try {
        if(![[qp getValue:@"reponse" withIndex:0]intValue]){
            NSLog(@"completeFlowTask success");
            [[NSNotificationCenter defaultCenter]postNotificationName:UISendSignOffMessageNotification object:AMLocalizedString(@"flowTaskComplete", nil)];
            [[NSNotificationCenter defaultCenter] postNotificationName:FlowEnumNotification object:[NSString stringWithFormat:@"%d",flowEnum]];
            [[NSNotificationCenter defaultCenter] postNotificationName:SIGHOFF_SHOWMSG object:AMLocalizedString(@"sighOffSend", nil)];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"flowTaskComplete", nil) message:[qp getValue:@"reponse" withIndex:0] delegate:nil cancelButtonTitle:AMLocalizedString(@"canel", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [qp release];
    }

}
-(void)initLayout{
    line1Img.image = [TUNinePatchCache imageOfSize:line1Img.frame.size forNinePatchNamed:@"line_step3"];
    line2Img.image = [TUNinePatchCache imageOfSize:line2Img.frame.size forNinePatchNamed:@"line_step3"];
    line3Img.image = [TUNinePatchCache imageOfSize:line3Img.frame.size forNinePatchNamed:@"line_step3"];
    line4Img.image = [TUNinePatchCache imageOfSize:line4Img.frame.size forNinePatchNamed:@"line_step3_2"];
    line5Img.image = [TUNinePatchCache imageOfSize:line5Img.frame.size forNinePatchNamed:@"line_step3_3"];
    idLabel.text =AMLocalizedString(@"id", nil);    
    uidLabel.text = AMLocalizedString(@"uid", nil);   
    deptLabel.text = AMLocalizedString(@"dept", nil);
    jobTitleLabel.text = AMLocalizedString(@"jobTitle", nil);
    //擺入同意取消按鈕，加圖和字
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, agreeBtn.frame.size.width, agreeBtn.frame.size.height)];
    agreeLabel.text = AMLocalizedString(@"agree", nil);
    [agreeLabel setFont:[UIFont fontWithName:DefaultFontName size:15.0f]];
    [agreeLabel setBackgroundColor:[UIColor clearColor]];
    UIImageView *agreeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_agree.png"]];
    //置中所以計算擺入位置
    CGSize textSize = [Tools estimateStringSize:agreeLabel.text withFontSize:15];
    float textlength = textSize.width + 5 + agreeIcon.frame.size.width;
    agreeIcon.frame = CGRectMake(agreeBtn.frame.size.width/2-textlength/2, agreeBtn.frame.size.height/2-agreeIcon.frame.size.height/2, agreeIcon.frame.size.width, agreeIcon.frame.size.height);
    agreeLabel.frame = CGRectMake(agreeIcon.frame.origin.x+agreeIcon.frame.size.width+5, agreeBtn.frame.size.height/2-agreeLabel.frame.size.height/2, agreeLabel.frame.size.width, agreeLabel.frame.size.height);
    [agreeBtn addSubview:agreeIcon];
    [agreeBtn addSubview:agreeLabel];
    [agreeBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:agreeBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:agreeBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    UILabel *rejectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rejectBtn.frame.size.width, rejectBtn.frame.size.height)];
    rejectLabel.text = AMLocalizedString(@"reject", nil);
    
    [rejectLabel setFont:[UIFont fontWithName:DefaultFontName size:15.0f]];
    [rejectLabel setBackgroundColor:[UIColor clearColor]];
    UIImageView *rejectIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_reject.png"]];
    //置中所以計算擺入位置
    //CGSize textSize = [ProjectTool estimateStringSize:rejectLabelLabel.text withFontSize:15];
   // float textlength = textSize.width + 5 + agreeIcon.frame.size.width;
    rejectIcon.frame = CGRectMake(rejectBtn.frame.size.width/2-textlength/2, rejectBtn.frame.size.height/2-rejectIcon.frame.size.height/2, rejectIcon.frame.size.width, rejectIcon.frame.size.height);
    rejectLabel.frame = CGRectMake(rejectIcon.frame.origin.x+rejectIcon.frame.size.width+5, rejectBtn.frame.size.height/2-rejectLabel.frame.size.height/2, rejectLabel.frame.size.width, rejectLabel.frame.size.height);
    [rejectBtn addSubview:rejectLabel];
    [rejectBtn addSubview:rejectIcon];
    [rejectBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:rejectBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [rejectBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:rejectBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFlowTypeNotification:) name:FlowTypeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFlowEnumNotification:) name:FlowEnumNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTaskIdNotification:) name:TaskIdNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAgreeEnableNotification:) name:AgreeEnableNotification object:nil];
    
}
+(BOOL)checkTaskId:(NSString*) taskId{
    return [taskId isEqualToString:TaskId];
}
-(void)getFlowTypeNotification:(NSNotification*)noti{
    flowType = (NSString*)[noti object];
    [self clearInfo];
}
-(void)getFlowEnumNotification:(NSNotification*)noti{
    flowEnum = [(NSString*)[noti object] intValue];
    [self clearInfo];
}
-(void)getAgreeEnableNotification:(NSNotification*)noti{
    if ([(NSString*)[noti object] intValue]) {
        agreeBtn.enabled = YES;
        rejectBtn.enabled = YES;
    }else{
        agreeBtn.enabled = NO;
        rejectBtn.enabled = NO;
    }
}
-(void)getTaskIdNotification:(NSNotification*)noti{
    TaskId = [(NSString*)[noti object] copy];
    NSLog(@"getTaskIdNotification %@",TaskId);
    [self setApplicationInfo];
}
-(void)setInfo{
    [self initLayout];
    //[self setApplicationInfo];
}
-(void)clearInfo{
    idDataLabel.text = @"";
    uidDataLabel.text = @"";
    orgDataLabel.text = @"";
    titleDataLabel.text = @""; 
    commentTV.text =AMLocalizedString(@"comentPlaceHolder", nil);
    for (UIView *view in infoScrollView.subviews) {
        [view removeFromSuperview];
    }
    agreeBtn.enabled = NO;
    rejectBtn.enabled = NO;
}
-(void)setApplicationInfo{
    NSMutableDictionary *dic=[[NSMutableDictionary new] autorelease];
    NSMutableArray *arr=[[NSMutableArray new] autorelease];
    
    QueryPattern *qp=[QueryPattern new];
    
	[qp prepareDic:getFlowTaskContent([MOLoginViewController loginInfo].sessionId,TaskId,flowType)];
    if (dataArray) {
        [dataArray removeAllObjects];
    }else{
        dataArray = [NSMutableArray new];
    }
    @try {
        idDataLabel.text = [qp getValue:@"billNo" withIndex:0];
        uidDataLabel.text = [qp getValue:@"initiatorId" withIndex:0];
        orgDataLabel.text = [qp getValue:@"dept" withIndex:0];
        titleDataLabel.text = [qp getValue:@"jobTitle" withIndex:0];
        NSArray *commonListArray = [qp getObjectUnderNode:@"commonList" withIndex:0];
        for (NSDictionary *commonDic in commonListArray) {
            for (NSString *sKey in [commonDic allKeys]) {
                [dic setValue:[commonDic objectForKey:sKey] forKey:sKey];
                [arr addObject:sKey];
            }
        }
        NSArray *contentListArray = [qp getObjectUnderNode:@"contentList" withIndex:0];
        for (NSDictionary *contentDic in contentListArray) {
            for (NSString *sKey in [contentDic allKeys]) {
                [dic setValue:[contentDic objectForKey:sKey] forKey:sKey];
                [arr addObject:sKey];
            }
        }

    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [qp release];
    }

    CGPoint startPos = CGPointMake(0, 0);
    //各Label間距數值
    float xDist =5;
    float yDist =15;
    float contentWidth = infoScrollView.contentSize.width+5;
    float cloumn2x =contentWidth/2; // 580/2;
    int count = 0;
    for (UIView *view in infoScrollView.subviews) {
        [view removeFromSuperview];
    }
    float textheight = 0;
    for(NSString *aKey in arr){
        float textX = (count%2)?cloumn2x:startPos.x;
        NSString  *showKey = [NSString stringWithFormat:@"%@：",aKey];
        CGSize textSize = [Tools estimateStringSize:showKey withFontSize:18.f];
        
        int numberOfLine = 1;
        if (textSize.width>contentWidth/4-xDist) {
            
            int lineCount = textSize.width/(contentWidth/4-xDist);
            //NSLog(@"lineCount %d", lineCount);
            textSize.width = contentWidth/4-xDist;
            textSize.height = (lineCount+1) * textSize.height;
            numberOfLine =lineCount+1;
            NSLog(@"key height %f ", textSize.height);
        }
        //NSLog(@"key startPos.y %f ", textSize.height);
        UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(textX, startPos.y, textSize.width, textSize.height)];
        [keyLabel setFont:[UIFont fontWithName:DefaultFontName size:18.0f]];
        keyLabel.text = showKey;
        [keyLabel setBackgroundColor:[UIColor clearColor]];
        [keyLabel setLineBreakMode:UILineBreakModeWordWrap];
        [keyLabel setNumberOfLines:numberOfLine];
        [infoScrollView addSubview:keyLabel];
        
        numberOfLine = 1;
        //刪除換行
        NSString *content = [[[dic valueForKey:aKey] stringByReplacingOccurrencesOfString:@"\r" withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        if ([content length]>0) {
            textSize = [Tools estimateStringSize:content withFontSize:18];
            if (textSize.width>contentWidth/4-xDist) {
                int lineCount = textSize.width/(contentWidth-xDist);
                textSize.width = contentWidth/4-xDist;
                textSize.height = (lineCount+1) * (textSize.height+1);
                numberOfLine =lineCount+1;
            }
        }
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(textX+contentWidth/4+xDist, startPos.y, textSize.width, textSize.height)];
        [valueLabel setFont:[UIFont fontWithName:DefaultFontName size:18.0f]];
        valueLabel.text = content;
        [valueLabel setLineBreakMode:UILineBreakModeWordWrap];
        [valueLabel setBackgroundColor:[UIColor clearColor]];
        [valueLabel setNumberOfLines:numberOfLine];
       
        [infoScrollView addSubview:valueLabel];
        if (textheight<textSize.height) {
            textheight = textSize.height;
        }
        if (count%2) {
            startPos.y += (yDist+textheight);
            textheight = 0;
        }
        
        [valueLabel release];
        [keyLabel release];
        count ++;
        
    }
    infoScrollView.contentSize = CGSizeMake(infoScrollView.frame.size.width, startPos.y +textheight);
    
}
-(void)textViewDidBeginEditing:(UITextView *)sender
{
    if ([sender isEqual:commentTV]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:startWriteCommentNotification object:nil];
    } 
    
}
-(void)textViewDidEndEditing:(UITextView *)sender
{
    if ([sender isEqual:commentTV]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:endWriteCommentNotification object:nil];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [line1Img release];
    [line2Img release];
    [line3Img release];
    [line4Img release];
    [line5Img release];
    [idDataLabel release];
    [uidDataLabel release];
    [orgDataLabel release];
    [titleDataLabel release];
    [infoScrollView release];
    [agreeBtn release];
    [rejectBtn release];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    
    [commentTV release];
    [idLabel release];
    [uidLabel release];
    [deptLabel release];
    [jobTitleLabel release];
    [super dealloc];
}
@end
