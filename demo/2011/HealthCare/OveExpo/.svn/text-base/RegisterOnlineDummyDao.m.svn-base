//
//  RegisterOnlineDummyDao.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegisterOnlineDummyDao.h"
#import "CommonDataObject.h"
#import "RegistryOnlineDataObj.h"
@implementation RegisterOnlineDummyDao
-(NSArray*)hospitalList{
    NSArray *m_returnArray=[NSArray arrayWithObjects:
                            [[CommonDataObject alloc]initWithId:@"0" withName:@"高雄醫學大學附設中和紀念醫院"],
                            [[CommonDataObject alloc]initWithId:@"1" withName:@"高雄市立小港醫院"],
                            [[CommonDataObject alloc]initWithId:@"2" withName:@"台灣基督長老教會新樓醫療財團法人"],
                            [[CommonDataObject alloc]initWithId:@"3" withName:@"行政院衛生署屏東醫院"],
                            [[CommonDataObject alloc]initWithId:@"4" withName:@"惠德醫院"],
                            nil];
    return m_returnArray;
}
-(NSArray*)getDepartmentList:(NSString*)hospitalId{
    NSInteger m_hospitalId=[hospitalId intValue];
    NSArray *m_returnArray=nil;
    switch (m_hospitalId) {
        case 0:
            m_returnArray=[NSArray arrayWithObjects:
                           [[CommonDataObject alloc]initWithId:@"00" withName:@"內科"],
                           [[CommonDataObject alloc]initWithId:@"01" withName:@"外科"],
                           [[CommonDataObject alloc]initWithId:@"02" withName:@"小兒科"],
                           [[CommonDataObject alloc]initWithId:@"03" withName:@"婦產科"]
                           , nil];
            break;
        case 1:
            m_returnArray=[NSArray arrayWithObjects:
                           [[CommonDataObject alloc]initWithId:@"10" withName:@"內科"],
                           [[CommonDataObject alloc]initWithId:@"11" withName:@"外科"],
                           [[CommonDataObject alloc]initWithId:@"12" withName:@"婦產科"],
                           [[CommonDataObject alloc]initWithId:@"13" withName:@"牙科"],
                           [[CommonDataObject alloc]initWithId:@"14" withName:@"復健科"],
                        nil];
            break;
        case 2:
            m_returnArray=[NSArray arrayWithObjects:
                           [[CommonDataObject alloc]initWithId:@"20" withName:@"內科"],
                           [[CommonDataObject alloc]initWithId:@"21" withName:@"胸腔腫瘤科"],
                           [[CommonDataObject alloc]initWithId:@"22" withName:@"家醫科"],
                           [[CommonDataObject alloc]initWithId:@"23" withName:@"小兒科"],
                           nil];
            break;
        case 3:
            m_returnArray=[NSArray arrayWithObjects:
                           [[CommonDataObject alloc]initWithId:@"30" withName:@"家醫科"],
                           [[CommonDataObject alloc]initWithId:@"31" withName:@"老人門診"],
                           [[CommonDataObject alloc]initWithId:@"32" withName:@"復健科"],
                           [[CommonDataObject alloc]initWithId:@"33" withName:@"小兒科"],
                           nil];
            break;
        case 4:
            m_returnArray=[NSArray arrayWithObjects:
                           [[CommonDataObject alloc]initWithId:@"40" withName:@"一般科"],
                           [[CommonDataObject alloc]initWithId:@"41" withName:@"復健科"],
                           [[CommonDataObject alloc]initWithId:@"42" withName:@"內科"],
                           [[CommonDataObject alloc]initWithId:@"43" withName:@"外科"],
                           nil];
            break;
    }
    return m_returnArray;
}

-(RegistryOnlineDataObj*)getRegistryOnlineData:(NSString*)_queryId{
    RegistryOnlineDataObj *m_returnObj=[[RegistryOnlineDataObj alloc] initWithId:@"" withName:@""];
    NSInteger m_queryId=[_queryId intValue];
    switch (m_queryId) {
        case 0:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"15";
            m_returnObj.comment=@"當天停診，由林瑋醫師代診";
            break;
        case 1:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"周大軍",@"廖正輝",@"張哲銘",@"許添華",@"楊至凱",@"林芳瑜", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"";
            break;
        case 2:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"卓華偉",@"王維中",@"朱宗怡",@"李志昇",@"林學正",@"李文德", nil];
            m_returnObj.registryCount=@"12";
            m_returnObj.comment=@"";
            break;
        case 3:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"王英俊",@"林瑋",@"王思婷",@"朱建勳",@"李玲佳",@"郭維安", nil];
            m_returnObj.registryCount=@"4";
            m_returnObj.comment=@"";
            break;
        case 10:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"8";
            m_returnObj.comment=@"";
            break;
        case 11:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"周大軍",@"廖正輝",@"張哲銘",@"許添華",@"楊至凱",@"林芳瑜", nil];
            m_returnObj.registryCount=@"15";
            m_returnObj.comment=@"當天停診，由李政經醫師代診";
            break;
        case 12:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"卓華偉",@"王維中",@"朱宗怡",@"李志昇",@"林學正",@"李文德", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"";
            break;
        case 13:
            m_returnObj.times=[NSArray arrayWithObjects:@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"王英俊",@"林瑋",@"王思婷",@"朱建勳",@"李玲佳",@"郭維安", nil];
            m_returnObj.registryCount=@"12";
            m_returnObj.comment=@"";
            break;
        case 14:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"4";
            m_returnObj.comment=@"";
            break;
        case 20:
            m_returnObj.times=[NSArray arrayWithObjects:@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"周大軍",@"廖正輝",@"張哲銘",@"許添華",@"楊至凱",@"林芳瑜", nil];
            m_returnObj.registryCount=@"8";
            m_returnObj.comment=@"";
            break;
        case 21:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"卓華偉",@"王維中",@"朱宗怡",@"李志昇",@"林學正",@"李文德", nil];
            m_returnObj.registryCount=@"15";
            m_returnObj.comment=@"";
            break;
        case 22:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"王英俊",@"林瑋",@"王思婷",@"朱建勳",@"李玲佳",@"郭維安", nil];
            m_returnObj.registryCount=@"ˋ";
            m_returnObj.comment=@"當天停診，由周大軍醫師代診";
            break;
        case 23:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"12";
            m_returnObj.comment=@"";
            break;
        case 30:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"周大軍",@"廖正輝",@"張哲銘",@"許添華",@"楊至凱",@"林芳瑜", nil];
            m_returnObj.registryCount=@"15";
            m_returnObj.comment=@"";
            break;
        case 31:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"卓華偉",@"王維中",@"朱宗怡",@"李志昇",@"林學正",@"李文德", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"";
            break;
        case 32:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"王英俊",@"林瑋",@"王思婷",@"朱建勳",@"李玲佳",@"郭維安", nil];
            m_returnObj.registryCount=@"12";
            m_returnObj.comment=@"";
            break;
        case 33:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"";
            break;
        case 40:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"周大軍",@"廖正輝",@"張哲銘",@"許添華",@"楊至凱",@"林芳瑜", nil];
            m_returnObj.registryCount=@"15";
            m_returnObj.comment=@"";
            break;
        case 41:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"卓華偉",@"王維中",@"朱宗怡",@"李志昇",@"林學正",@"李文德", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"";
            break;
        case 42:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"王英俊",@"林瑋",@"王思婷",@"朱建勳",@"李玲佳",@"郭維安", nil];
            m_returnObj.registryCount=@"12";
            m_returnObj.comment=@"當天停診，由林瑋醫師代診";
            break;
        case 43:
            m_returnObj.times=[NSArray arrayWithObjects:@"上午",@"下午",@"夜間", nil];
            m_returnObj.doctors=[NSArray arrayWithObjects:@"李政經",@"蕭玉芳",@"王耿豪",@"林一達", nil];
            m_returnObj.registryCount=@"20";
            m_returnObj.comment=@"當天停診，由周大軍醫師代診";
            break;
        default:
            break;
    }
    return [m_returnObj autorelease];
}
@end
