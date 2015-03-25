//
//  ServiceInfoViewController.h
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface ServiceInfoViewController : FcViewController{
    NSString *serviceId;
}
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, retain) NSString* serviceId;
-(void)initData;
-(void)setUIDefault;
@end
