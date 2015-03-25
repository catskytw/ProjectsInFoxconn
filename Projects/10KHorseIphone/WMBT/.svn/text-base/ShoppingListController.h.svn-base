//
//  ShoppingListController.h
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartTableCell.h"
#import "ShoppingCartTableCellTextField.h"
#import "tableViewImageDownload.h"
@interface ShoppingListController : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,tableViewImgDownloaderDelegate>{

    UIButton *OrderButton;
    UIButton *continueShoppingButton;
    UITableView *ShoppingListTable;
    UIButton *storeButton;
    
    NSMutableArray *shoppingCartArray;
    CGFloat cellHeight;
    UINavigationController *currentNavigationController;
    UIButton *hideKeyboardButton;
    UILabel *totalLabel;
    ShoppingCartTableCellTextField *currentTextField;
    UIBarButtonItem *editTableButton;
    
    NSString *plistPath;
    UIPickerView *storePicker;
    NSMutableArray *storeArray;
    BOOL bKeyboardMoveup;
    NSMutableDictionary *imageDownloadsInProgress;
}
- (IBAction)continueShopping:(id)sender;
- (IBAction)checkOrder:(id)sender;
- (IBAction)chooseStore:(id)sender;
-(IBAction)editTable;
@property (nonatomic, retain) IBOutlet UIPickerView *storePicker;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UIButton *OrderButton;
@property (nonatomic, retain) IBOutlet UIButton *continueShoppingButton;
@property (nonatomic, retain) IBOutlet UITableView *ShoppingListTable;
@property (nonatomic, retain) IBOutlet UIButton *storeButton;
@property (nonatomic, retain) UINavigationController *currentNavigationController;
@property (nonatomic, retain) IBOutlet UIButton *hideKeyboardButton;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
-(UITableViewCell *)getShoppingListCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

-(void)addToCart:(ShoppingCartCellDataObject*)cellDO;
-(void)processData;
-(void)addEditTableButton;
- (IBAction)hideKeyboard:(id)sender;

-(void)getPlistInfo;
-(void)readPlist;
-(void)writePlist;
-(void)updateTotal;
-(void)loadStoreData;
-(void)wsReturn:(NSNotification*)notification;
+(void)removeallShoppingCart;
-(void)setViewMovedUp:(BOOL)movedUp;
- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath;
@end
