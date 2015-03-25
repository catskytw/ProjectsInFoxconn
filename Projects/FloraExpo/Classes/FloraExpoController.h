//
//  FloraExpoController.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DescriptionViewController.h"
#import "NewsDetailInfoViewController.h"
@interface FloraExpoController : NSObject {
	NSArray *dataArray;
}
@property(nonatomic,retain)NSArray *dataArray;
-(id)initWithType:(NSInteger)tableType withKey:(NSString*)key;
-(NSString*)getTitle:(NSInteger)tableType;
-(NSInteger)getNumberOfRow:(NSInteger)tableType;
-(NSInteger)getNumberOfSection:(NSInteger)tableType;
-(UITableViewCell*)getTableCell:(NSInteger)tableType withTableView:(UITableView*)tableView withIndexPath:(NSIndexPath *)indexPath;
-(UIViewController*)getNextViewControllerOnForaExpoContent:(NSInteger)index;
-(NewsDetailInfoViewController*)getNextViewControllerOnNews:(NSString*)key;
-(UIViewController*)getNextViewControllerOnAboutFlora:(NSInteger)index;
@end
