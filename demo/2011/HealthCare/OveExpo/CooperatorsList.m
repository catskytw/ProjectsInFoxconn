//
//  CooperatorsList.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CooperatorsList.h"
#import "CooperatorDummyDao.h"
#import "CooperatorInfoView.h"
#import "CommonDataObject.h"
#import "LocalizationSystem.h"
@implementation CooperatorsList
@synthesize categoryUUID;
#pragma mark - View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"CooperatorCategoryList" bundle:nibBundleOrNil];
    if (self) {
        isShowSearchBar=YES;
    }
    return self;
}
#pragma -
#pragma mark - DelegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CooperatorInfoView *m_nextView=[CooperatorInfoView new];
    [m_nextView setBackItem:AMLocalizedString(@"back", nil)];
    CommonDataObject *m_tmpObj=[filteredArray objectAtIndex:[indexPath row]];
    m_nextView.cooperatorId=m_tmpObj.objId;
    m_nextView.title=m_tmpObj.objName;
    [self.navigationController pushViewController:m_nextView animated:YES];
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    [dataArray removeAllObjects];
    CooperatorDataAdaptor *dao=[CooperatorDummyDao new];
    [dataArray addObjectsFromArray:[dao cooperatorsData:categoryUUID]];
    [dao release];
    
    [self filter];
}
#pragma -
@end