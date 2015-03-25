//
//  ProductSubCatelogController.h
//  WMBT
//
//  Created by link on 2011/6/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductSubCatelogController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    NSIndexPath  *catelogIndexPath;
	NSString	*mainSelectedKey;
	NSString	*mainSelectedName;
	NSMutableDictionary *sCategoryDic;
    NSMutableArray *sortArray;
	id mainController;
    IBOutlet UITableView *subCatelogTable;
}
- (void)loadData;
@property(nonatomic,retain)id mainController;
@property(nonatomic,retain)NSIndexPath  *catelogIndexPath;
@property(nonatomic,retain)NSString	*mainSelectedKey;
@property(nonatomic,retain)NSString	*mainSelectedName;
@end
