//
//  ExhibitionDescriptionObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//展館詳細說明之資料物件
@interface ExhibitionDescriptionObject : NSObject {
	NSString *title;
	NSString *brief;
	NSString *descriptionText;
	NSString *picName;
}
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *brief;
@property(nonatomic,retain) NSString *descriptionText;
@property(nonatomic,retain) NSString *picName;
@end
