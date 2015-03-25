//
//  SecondViewController.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/24.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcPopWindows.h"
#import "QueryPattern.h"
@interface MemberViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    @public
    IBOutlet UILabel *dataString1;
    IBOutlet UILabel *dataString2;
    IBOutlet UILabel *dataString3;
    IBOutlet UILabel *dataString4;
    IBOutlet UILabel *dataString5;
    IBOutlet UILabel *dataString6;
    IBOutlet UILabel *dataString7;
    IBOutlet UILabel *dataString8;
    IBOutlet UILabel *dataString9;
    IBOutlet UILabel *dataString10;
    IBOutlet UILabel *dataString11;
    IBOutlet UILabel *dataString12;
    IBOutlet UILabel *dataString13;
    IBOutlet UILabel *section2Label1;
    IBOutlet UILabel *section2Label2;
    IBOutlet UILabel *section2Label3;
    IBOutlet UILabel *section2Label4;
    IBOutlet UITableView *table;
    @private
    IBOutlet UIImageView *titleBackground;
    IBOutlet UIImageView *background;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *section1Label;
    IBOutlet UILabel *section2Label;
    IBOutlet UIImageView *tableTitleBackground;
    
    IBOutlet UIButton *logoutBtn;
    IBOutlet UIButton *activeBtn;
    IBOutlet UIButton *changePwdBtn;
    FcPopWindows *popWin;
    QueryPattern *historyOrderQuery;
    IBOutlet UILabel *orderDate;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *discountLabel;
    IBOutlet UILabel *totalLabel;
    IBOutlet UILabel *storeLabel;
    IBOutlet UILabel *orderIdLabel;
}
@property (nonatomic, retain) UILabel *orderIdLabel;
@property (nonatomic, retain) UILabel *storeLabel;
@property (nonatomic, retain) UILabel *totalLabel;
@property (nonatomic, retain) UILabel *discountLabel;
@property (nonatomic, retain) UILabel *orderDate;
@property (nonatomic, retain) UILabel *statusLabel;
@property(nonatomic,retain)UIImageView *tableTitleBackground;
@property(nonatomic,retain)UIImageView *titleBackground,*background;
@property(nonatomic,retain)UILabel *titleLabel,*dataString1,*dataString2,*dataString3,*dataString4,*dataString5,*dataString6,*dataString7,*dataString8,*dataString9,*dataString10,*dataString11,*dataString12,*dataString13;
@property(nonatomic,retain)UILabel *section1Label,*section2Label,*section2Label1,*section2Label2,*section2Label3,*section2Label4;
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)
UIButton *logoutBtn,*activeBtn,*changePwdBtn;

-(IBAction)logoutAction:(id)sender;
-(IBAction)activeAction:(id)sender;
-(IBAction)changePwdAction:(id)sender;
@end
