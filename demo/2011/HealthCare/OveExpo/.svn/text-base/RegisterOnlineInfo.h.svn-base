//
//  RegisterOnlineInfo.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcViewController.h"
#import "RegistryOnlineDataObj.h"
#import "FcPickerController.h"
@interface RegisterOnlineInfo : FcViewController<UITableViewDelegate,UITableViewDataSource,FcPickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UITableView *contentTable;
    IBOutlet UILabel *hospitablName,*departmentName,*registryCount;
    IBOutlet UILabel *comment;
    IBOutlet UIButton *registryBtn;
    IBOutlet UIImageView *btnBackImage,*lineImage;
    
    NSString *queryId;
    NSArray *labelArray,*pickerDataArray;
    NSMutableArray *contentArray;
    NSInteger cellCount;
    NSInteger actionType;
    RegistryOnlineDataObj *regInfoDataObj;
    FcPickerController *fcPicker;
}
@property(nonatomic,retain)UITableView *contentTable;
@property(nonatomic,retain)UILabel *hospitablName,*departmentName,*registryCount;
@property(nonatomic,retain)UILabel *comment;
@property(nonatomic,retain)UIImageView *btnBackImage,*lineImage;
@property(nonatomic,retain)UIButton *registryBtn;
@property(nonatomic,retain)NSString *queryId;

-(IBAction)registryAction:(id)sender;
@end
