//
//  ShoppingCartCellDataObject.m
//  WMBT
//
//  Created by link on 2011/6/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCartCellDataObject.h"


@implementation ShoppingCartCellDataObject
@synthesize productId,productName,color,imgUrl,price,quantity,dlImg;
static ShoppingCartCellDataObject *processData = nil;
- (id)init{
    dlImg = [DownloadImg new];
    return self;
}
- (void)dealloc
{
    [dlImg release];
    [super dealloc];
}+(ShoppingCartCellDataObject *) getProcessData{
    return processData;
}
+(void) cleanProcessData{
    [processData release];
    processData = nil;
}
+(void) setProcessData:(ShoppingCartCellDataObject *)data{
    processData = data;
    [processData retain];
}
@end
