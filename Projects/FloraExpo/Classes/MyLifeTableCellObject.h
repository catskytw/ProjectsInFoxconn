//
//  MyLifeTableCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyLifeTableCellObject : NSObject {
	NSString *objectKey;
	NSString *objectName;
	NSString *objectPicName;
}
@property(nonatomic,retain)NSString *objectKey;
@property(nonatomic,retain)NSString *objectName;
@property(nonatomic,retain)NSString *objectPicName;
@end
