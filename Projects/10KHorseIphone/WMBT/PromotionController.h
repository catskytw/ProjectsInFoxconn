//
//  PromotionController.h
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcProductTableCell.h"
#import "tableViewImageDownload.h"
@interface PromotionController : UIViewController <UITableViewDataSource,UITableViewDelegate,tableViewImgDownloaderDelegate>{
    
    UITableView *prmotionTableView;
    UISegmentedControl *promotionSegment;
    NSMutableArray *productListArray;
    NSMutableArray *sectionArray;
	NSMutableDictionary *SectionDic;
    NSMutableArray *eventArray;
    id mainController;
    CGFloat productCellHeight;
    CGFloat eventCellHeight;
    UIView *SegmentBackGroundView;
    NSMutableDictionary *imageDownloadsInProgress;
}
@property (nonatomic, retain) IBOutlet UIView *SegmentBackGroundView;
@property(nonatomic,retain) id mainController;
@property (nonatomic, retain) IBOutlet UITableView *prmotionTableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *promotionSegment;
@property(nonatomic,retain) NSMutableDictionary *imageDownloadsInProgress;
- (IBAction)promotionSegmentChange:(id)sender;
-(UITableViewCell *)getFcProductListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)getEventCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
-(void)loadProductData;
-(void)loadEventData;
-(void)setUIDefault;
- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath;
@end
