//
//  ExhibitionTableView.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExhibitionTableView : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSMutableArray *contentArray;
	NSString *titleString;
	NSInteger thisType;
	IBOutlet UITableView *thisContentTable;
}
@property(nonatomic,retain)UITableView *thisContentTable;
@property(nonatomic,retain)NSString *titleString;
-(id)initWithType:(NSInteger)type;
@end
