//
//  DiscountDetailObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiscountDetailObject : NSObject {
	BOOL hasDiscount;
	NSArray *descriptionArray;
}
@property(nonatomic)BOOL hasDiscount;
@property(nonatomic,retain)NSArray *descriptionArray;
@end
