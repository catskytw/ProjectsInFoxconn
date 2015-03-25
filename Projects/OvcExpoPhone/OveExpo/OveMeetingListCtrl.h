//
//  OveMeetingListCtrl.h
//  OveExpo
//
//  Created by  on 11/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OveMeetingDetailCtrl2.h"
#import "FcViewController.h"
@interface OveMeetingListCtrl : FcViewController
<
UITableViewDelegate,
UITableViewDataSource
>
{
    //*** 會議列表
    IBOutlet UITableView *mettingsTable;
    
    //*** Next view
    OveMeetingDetailCtrl2 *detailView;
    
    //*** Meeting
    NSString *date;
    NSString *room;
    NSArray *meetings;
    UIButton *backButton;
}

- (id)initWithDate:(NSString *)date;
- (id)initWithRoom:(NSString *)room withDate:(NSString*)date;
@end
