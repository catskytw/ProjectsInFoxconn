//
//  MapLine.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapStyle.h"

@interface MapLine : MapStyle {
	int width;
	int pattern;
}
@property(nonatomic)int width;
@property(nonatomic)int pattern;
-(id)initWithColorData:(NSData*)colorData withWidth:(NSData*)widthData withPattern:(NSData*)patternData;
@end
