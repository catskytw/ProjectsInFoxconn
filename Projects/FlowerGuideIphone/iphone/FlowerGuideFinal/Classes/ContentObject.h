//
//  ContentObject.h
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContentObject : NSObject {
	NSString *title;
	NSMutableArray *contentArray;
	NSString *picUrl;
}
@property(nonatomic,retain)NSString *title,*picUrl;
@property(nonatomic,retain)NSMutableArray *contentArray;
@end
