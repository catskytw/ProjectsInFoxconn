//
//  CompanyListDataObject.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorListDataObject.h"

@implementation ExhibitorListDataObject
@synthesize iconName,name,exhibitorId,dlImg;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        dlImg = [DownloadImg new];
    }
    
    return self;
}
- (void)dealloc
{
    [dlImg release];
    [super dealloc];
}
@end
