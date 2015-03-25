//
//  HospitalList.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HospitalList.h"
#import "RegisterOnlineDummyDao.h"
#import "RegisterOnlineDataAdaptor.h"
#import "DepartmentList.h"
#import "CommonDataObject.h"
#import "LocalizationSystem.h"
#import "RegistrySelectedRecord.h"
@implementation HospitalList

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
    DepartmentList *m_departmentList=[DepartmentList new];
    CommonDataObject *m_data=(CommonDataObject*)[filteredArray objectAtIndex:[indexPath row]];
    [m_departmentList setBackItem:AMLocalizedString(@"back", nil)];
    m_departmentList.title=m_data.objName;
    [RegistrySelectedRecord share].hospitablName=[NSString stringWithString:m_data.objName];
    m_departmentList.hospitalId=m_data.objId;
    [self.navigationController pushViewController:m_departmentList animated:YES];
    [m_departmentList release];
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    [dataArray removeAllObjects];
    RegisterOnlineDataAdaptor *dao=[RegisterOnlineDummyDao new];
    [dataArray addObjectsFromArray:[dao hospitalList]];
    [dao release];
    [self filter];
}
#pragma -
@end
