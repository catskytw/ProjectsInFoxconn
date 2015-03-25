//
//  ParkingAreaListCellObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParkingAreaListCellObject : NSObject {
	NSString *areaName;
	NSInteger publicNumber;
	NSInteger privateNumber;
}
@property(nonatomic,retain) NSString *areaName;
@property(nonatomic) NSInteger publicNumber;
@property(nonatomic) NSInteger privateNumber;
-(id)initWithAreName:(NSString*)thisAreaName withPublicNumber:(NSInteger)thisPublicNumber withPrivateNumber:(NSInteger)thisPrivateNumber;

@end
