//
//  FloraExpoTableDataObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FloraExpoTableDataObject : NSObject {
	//每一個section
	NSMutableArray *sectionArray;
	NSString *title;
	
	NSInteger thisTableKey;
}
@property(nonatomic,retain)NSMutableArray *sectionArray;
@property(nonatomic,retain)NSString *title;
-(NSString*)createTitle;
-(void)createSection;
@end
