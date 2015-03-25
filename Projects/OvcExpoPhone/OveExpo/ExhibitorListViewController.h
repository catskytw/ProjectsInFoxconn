//
//  CompanyListViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcSearchField.h"
#import "ExhibitorInfoViewController.h"
#import "FcViewController.h"
#import "tableViewImageDownload.h"
@interface ExhibitorListViewController : FcViewController<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate,tableViewImgDownloaderDelegate>{
    NSMutableArray *dataArray;
    NSMutableArray *filteredArray;
    UITableView *tableview;
    FcSearchField *searchField;
    ExhibitorInfoViewController *infoView;
    UIImageView *searchBgImg;
    NSMutableDictionary *imageDownloadsInProgress;
}
@property (nonatomic, retain) IBOutlet UIImageView *searchBgImg;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
-(void)filter;
-(void)initDataArray;
-(void) setUIDefault;
- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath;
@end
