//
//  PromoteEventCellDataObject.h
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PromoteEventCellDataObject : NSObject {
    NSString *title;
	NSString *content;
	NSString *duration;
    NSString *eventId;
	
}
@property(nonatomic,retain)NSString *title,*content,*duration,*eventId;
@end
