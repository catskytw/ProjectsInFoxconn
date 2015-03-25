//
//  DiscountObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiscountObject : NSObject {
	//key
	NSString *discountKey;
	//活動時間　
	NSString *durationString;
	//活動名稱
	NSString *actionString;
}
@property(nonatomic,retain)NSString* discountKey;
@property(nonatomic,retain)NSString *durationString;
@property(nonatomic,retain)NSString *actionString;
@end
