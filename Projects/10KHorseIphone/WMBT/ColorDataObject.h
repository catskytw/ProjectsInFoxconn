//
//  ColorDataObject.h
//  WMBT
//
//  Created by link on 2011/6/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ColorDataObject : NSObject {
    NSString *colorId;
	NSString *Name;
	NSString *colorRGB;
}
@property(nonatomic,retain)NSString *colorId, *Name, *colorRGB;
@end
