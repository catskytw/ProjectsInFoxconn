//
//  TransListObject.h
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransListObject : NSObject {
	NSString *transId,*transName;
}
@property(nonatomic,retain)NSString *transId,*transName;
@end
