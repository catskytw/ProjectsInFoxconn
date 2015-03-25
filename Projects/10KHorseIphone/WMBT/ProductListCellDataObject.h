//
//  ProductListCellDataObject.h
//  WMBT
//
//  Created by link on 2011/2/28.
//  Copyright 2011 Foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadImg.h"

@interface ProductListCellDataObject : NSObject {
	NSString *productId;
	NSString *productName;
	NSString *score;
	NSString *imgUrl;
	NSString *price;
	NSString *brand;
    DownloadImg *dlImg;
	
}
@property(nonatomic,retain)NSString *productId,*productName,*score,*imgUrl,*price,*brand;
@property(nonatomic,retain)DownloadImg *dlImg;


@end
