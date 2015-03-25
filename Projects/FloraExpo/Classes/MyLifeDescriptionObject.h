//
//  MyLifeDescriptionObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLifeDescriptionObject : NSObject {
	NSString *categoryName,*storeName,*storePicName,*introduction,*address,*telephone,*discountKey,*fax,*hour_open,*hour_close,*day_off,*web,*email;
	NSInteger payment,parking,indoor_navi,wifi,pet_allow;
}
@property(nonatomic,retain) NSString *categoryName,*storeName,*storePicName,*introduction,*address,*telephone, *discountKey,*fax,*hour_open,*hour_close,*day_off,*web,*email;
@property(nonatomic)NSInteger payment,parking,indoor_navi,wifi,pet_allow;
@end
