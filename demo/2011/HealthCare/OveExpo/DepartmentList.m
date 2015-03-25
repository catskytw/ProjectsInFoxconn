//
//  DepartmentList.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DepartmentList.h"
#import "RegisterOnlineDataAdaptor.h"
#import "RegisterOnlineDummyDao.h"
#import "RegisterOnlineInfo.h"
#import "LocalizationSystem.h"
#import "CommonDataObject.h"
#import "RegistrySelectedRecord.h"
@implementation DepartmentList
@synthesize hospitalId;
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
    RegisterOnlineInfo *m_nextView=[RegisterOnlineInfo new];
    CommonDataObject *m_selectedObj=[filteredArray objectAtIndex:[indexPath row]];
    m_nextView.queryId=m_selectedObj.objId;
    [RegistrySelectedRecord share].departmentName=[NSString stringWithString:m_selectedObj.objName];
    m_nextView.title=AMLocalizedString(@"register", nil);
    [m_nextView setBackItem:AMLocalizedString(@"back", nil)];
    [self.navigationController pushViewController:m_nextView animated:YES];
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    [dataArray removeAllObjects];
    RegisterOnlineDataAdaptor *dao=[RegisterOnlineDummyDao new];
    [dataArray addObjectsFromArray:[dao getDepartmentList:hospitalId]];
    [dao release];
    [self filter];
}
#pragma -
@end
