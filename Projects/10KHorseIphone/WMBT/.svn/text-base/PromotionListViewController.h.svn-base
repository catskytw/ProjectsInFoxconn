//
//  PromotionListVewController.h
//  WMBT
//
//  Created by link on 2011/5/26.
//  Copyright 2011年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcProductTableCell.h"

@interface PromotionListViewController : UITableViewController {
    NSMutableArray *productListArray;
    NSMutableArray *sectionArray;
	NSMutableDictionary *SectionDic;
    id mainController;
    CGFloat cellHeight;
}
@property(nonatomic,retain) id mainController;
@property(nonatomic,retain) NSMutableArray *productListArray;
-(UITableViewCell *)getFcProductListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath;
-(void)loadData;
@end
