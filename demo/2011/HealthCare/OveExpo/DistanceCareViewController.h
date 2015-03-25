//
//  DistanceCare.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcViewController.h"
#import "DistanceCareDataObject.h"
@interface DistanceCareViewController : FcViewController{
    IBOutlet UITextView *contentText;
    IBOutlet UIButton *phoneBtn;
    IBOutlet UIImageView *btnBackground,*lineImage;
    
    NSString *phoneNumber;
    DistanceCareDataObject *dao;
}
@property(nonatomic,retain)UITextView *contentText;
@property(nonatomic,retain)UIButton *phoneBtn;
@property(nonatomic,retain)UIImageView *btnBackground,*lineImage;
-(IBAction)callPhoneNumber:(id)sender;
@end
