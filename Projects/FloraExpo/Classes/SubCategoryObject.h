//
//  SubCategoryObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SubCategoryObject : NSObject {
	NSString *key;
	NSString *subCategoryName;
	BOOL isSelected;
}
@property(nonatomic,retain)NSString *key;
@property(nonatomic,retain)NSString *subCategoryName;
@property(nonatomic)BOOL isSelected;
-(id)initWithSubCategoryName:(NSString*)name isSelected:(BOOL)selectedFlag;
@end
