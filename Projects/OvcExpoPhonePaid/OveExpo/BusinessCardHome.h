//
//  BusinessCardHome.h
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCard_MyInfoEditor.h"
#import "BusinessCard_list.h"
#import "FcViewController.h"
@interface BusinessCardHome : FcViewController{
    UIImageView *qr_CodeImg;
    UIImageView *seperateImg;
    UILabel *label1;
    UIButton *editBut;
    UIButton *goListBut;
    BusinessCard_MyInfoEditor *editor;
    BusinessCard_list *cardListCtrl;
    
    //Others
    NSString *fullname;
    NSData *myBarcodeData;
}

@property (nonatomic, retain) IBOutlet UIImageView *qr_CodeImg;
@property (nonatomic, retain) IBOutlet UIImageView *seperateImg;
@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UIButton *editBut;

-(IBAction)editMyBusinessCard:(id)sender;
-(IBAction)cardList:(id)sender;
@end
