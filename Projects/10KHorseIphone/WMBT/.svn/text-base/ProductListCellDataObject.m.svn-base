//
//  ProductListCellDataObject.m
//  WMBT
//
//  Created by link on 2011/2/28.
//  Copyright 2011 Foxconn. All rights reserved.
//

#import "ProductListCellDataObject.h"


@implementation ProductListCellDataObject
@synthesize productId,productName,score,imgUrl,price,brand,dlImg;
- (id)init{
    dlImg = [DownloadImg new];
    return self;
}
- (void)dealloc
{
    [dlImg release];
    [super dealloc];
}

@end
