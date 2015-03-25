//
//  ProductCatelogController.h
//  WMBT
//
//  Created by link on 2011/6/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductCatelogController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *catelogTable;
    id mainController;
	NSMutableDictionary *mCategoryDic;
    NSMutableArray *sortArray;
}
@property(nonatomic,retain) UITableView *catelogTable;
@property(nonatomic,retain)id mainController;
-(void)loadAllCategory;
@end
