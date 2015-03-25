//
//  ShoppingCartCellDataObject.h
//  WMBT
//
//  Created by link on 2011/6/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadImg.h"

@interface ShoppingCartCellDataObject : NSObject {
    NSString  *productId;
    NSString  *productName;
    float      price;
    NSString  *color;
    NSString  *imgUrl;
    UInt32 quantity;
    DownloadImg *dlImg;
}
+(void) setProcessData:(ShoppingCartCellDataObject *)data;
+(ShoppingCartCellDataObject *) getProcessData;
+(void) cleanProcessData;
@property(nonatomic,retain)NSString *productId,*productName,*color,*imgUrl;
@property(nonatomic)float  price;
@property(nonatomic)UInt32 quantity;
@property(nonatomic,retain)DownloadImg *dlImg;
@end
