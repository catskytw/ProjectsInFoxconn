//
//  AuditContent3View.h
//  Audit
//
//  Created by Chang Link on 11/9/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentXibView.h"
#import "FcConfig.h"
static NSString *TaskId=@"";
@interface SignOffContent3View : ContentXibView<UITextViewDelegate>{
    
    UIImageView *line1Img;
    UILabel *idDataLabel;
    UILabel *uidDataLabel;
    UILabel *orgDataLabel;
    UILabel *titleDataLabel;
    UIScrollView *infoScrollView;
    UIButton *agreeBtn;
    UIButton *rejectBtn;
    UITextView *commentTV;
    UIImageView *line2Img;
    UIImageView *line3Img;
    UIImageView *line4Img;
    UIImageView *line5Img;
    
    NSString *flowType;
    FlowTypeEnum flowEnum;
    NSMutableArray *dataArray;
    UILabel *idLabel;
    UILabel *uidLabel;
    UILabel *deptLabel;
    UILabel *jobTitleLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *idLabel;
@property (nonatomic, retain) IBOutlet UILabel *uidLabel;
@property (nonatomic, retain) IBOutlet UILabel *deptLabel;
@property (nonatomic, retain) IBOutlet UILabel *jobTitleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *line5Img;
@property (nonatomic, retain) IBOutlet UIImageView *line4Img;
@property (nonatomic, retain) IBOutlet UIImageView *line3Img;
@property (nonatomic, retain) IBOutlet UIImageView *line2Img;
@property (nonatomic, retain) IBOutlet UIImageView *line1Img;
@property (nonatomic, retain) IBOutlet UILabel *idDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *uidDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *orgDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleDataLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *infoScrollView;
@property (nonatomic, retain) IBOutlet UIButton *agreeBtn;
@property (nonatomic, retain) IBOutlet UIButton *rejectBtn;
@property (nonatomic, retain) IBOutlet UITextView *commentTV;
- (IBAction)agree:(id)sender;
- (IBAction)reject:(id)sender;

-(void)initLayout;
-(void)setApplicationInfo;
-(void)completeFlowTask:(int)eventMode;
+(BOOL)checkTaskId:(NSString*) taskId;
-(void)clearInfo;
@end
