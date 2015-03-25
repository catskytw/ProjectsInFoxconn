//
//  AuditContent2View.h
//  Audit
//
//  Created by Chang Link on 11/9/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentXibView.h"
#import "FcTextField.h"
#import "FcConfig.h"
@interface SignOffContent2View : ContentXibView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
    NSMutableArray *dataArray;
    UIImageView *tableLineImg;
    FcTextField *searchFcTf;
    FlowTypeEnum flowEnum;
    NSString *flowType;
    NSMutableArray *querryData;
}
@property (nonatomic, retain) IBOutlet UIImageView *tableLineImg;
@property (nonatomic, retain) FcTextField *searchFcTf;
-(void)setLayout;
-(void)getData;

@end
