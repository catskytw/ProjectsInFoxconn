//
//  FcProductListViewController.h
//  FcProductList
//
//  Created by link on 2011/2/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcProductTableCell.h"
#import "tableViewImageDownload.h"
@interface FcProductListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,tableViewImgDownloaderDelegate>{
	IBOutlet UITableView *productList;
	NSString	*mainSelectedKey;
	NSString	*mainSelectedName;
	NSString	*stringType;
	NSMutableArray *productListArray;
    NSMutableDictionary *imageDownloadsInProgress;
	id mainController;
	
	CGFloat cellHeight;
}

@property(nonatomic,retain) UITableView *productList;

@property(nonatomic,retain) NSString	*mainSelectedKey;
@property(nonatomic,retain) NSString	*mainSelectedName;
@property(nonatomic,retain) id mainController;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property(nonatomic,retain) NSMutableArray *productListArray;
-(UITableViewCell *)getFcProductListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath;
-(void) loadBrandData:(NSString*)key andSort:(int)sortKey;
- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath;
@end

