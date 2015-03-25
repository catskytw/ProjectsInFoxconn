//
//  PlaceConfirmPopWindow.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PlaceConfirmPopWindow : UIViewController{
    IBOutlet UILabel *guideTitle;
    IBOutlet UILabel *place;
    IBOutlet UILabel *correctLabel;
    IBOutlet UIButton *confirmBtn;
    IBOutlet UIButton *qrcodeBtn;
}
@property(nonatomic,retain)UILabel *guideTitle,*place,*correctLabel;
@property(nonatomic,retain)UIButton *confirmBtn,*qrcodeBtn;
-(IBAction)confirmAction:(id)sender;
-(IBAction)qrcodeAction:(id)sender;
@end
