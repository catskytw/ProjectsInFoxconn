//
//  ShoppingCartView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/2.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreNamePickerViewController.h"
extern int LASTVIEWPAGETYPE;
@interface ShoppingCartView : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate> {
    IBOutlet UIButton *orderBtn;
    IBOutlet UIButton *continueBuyBtn;
    IBOutlet UIImageView *titlebackground;
    IBOutlet UIImageView *titleBarBackground;
    IBOutlet UILabel *description;
    IBOutlet UITableView *contentTable;
    IBOutlet UIButton *deleteBtn;
    IBOutlet UIButton *storeNameBtn;
    
    IBOutlet UILabel *totalNum;
    IBOutlet UILabel *totalPrice;
    
    IBOutlet UILabel *qtyLabel;
    IBOutlet UILabel *productNameLabel;
    IBOutlet UILabel *naviBarLabel;
    IBOutlet UILabel *unitPrice;
    IBOutlet UILabel *subTotalLabel;
    IBOutlet UILabel *totalLabel;
    IBOutlet UILabel *storeLabel;
    IBOutlet UITextField *storeName;
    @private
    UIPopoverController *_storeNamePickerPopover;
    StoreNamePickerViewController *_storeNameViewController;
    BOOL isEditable;
}
@property(nonatomic,retain)UIButton *orderBtn,*continuebuyBtn,*deleteBtn,*storeNameBtn;
@property(nonatomic,retain)UIImageView *titlebackground,*titleBarBackground;
@property(nonatomic,retain)UILabel *description,*totalPrice,*totalNum,*qtyLabel,*productNameLabel,*naviBarLabel,*unitPrice,*subTotalLabel,*totalLabel,*storeLabel;
@property(nonatomic,retain)UITableView *contentTable;
@property(nonatomic,retain)UITextField *storeName;
//刪除購物車表格內的訂單
-(IBAction)deleteAction:(id)sender;
//送出購物車內的訂單,下單之動作
-(IBAction)sendOrders:(id)sender;
-(IBAction)showPopover:(id)sender;
-(IBAction)continueShopping:(id)sender;
@end
