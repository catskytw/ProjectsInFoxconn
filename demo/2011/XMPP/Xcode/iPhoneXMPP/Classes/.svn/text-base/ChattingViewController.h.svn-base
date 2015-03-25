//
//  ChattingViewController.h
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPJID.h"

@interface ChattingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    IBOutlet UITableView *_contentTable;
    IBOutlet UITextField *_messageField;
    UIBarButtonItem *backItem;
    @public
    XMPPJID *targetJid;
    NSString *targetDisplayName;
}
@property(nonatomic,retain)UITableView *_contentTable;
@property(nonatomic,retain)UITextField *_messageField;
@property(nonatomic,retain)XMPPJID *targetJid;
@property(nonatomic,retain)NSString *targetDisplayName;
-(void)reloadConversationTable:(NSNotification*)notification;
-(void)strangeReload;
-(void)reloadTableData;
@end
