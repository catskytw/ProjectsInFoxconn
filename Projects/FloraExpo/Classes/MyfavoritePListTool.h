//
//  MyfavoritePListTool.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//deprecated!
@interface MyfavoritePListTool : NSObject {

}
+(void)writeAllDictionaryToPListFile:(NSDictionary*)inputDictionary;
//get all directory name by the category
+(NSMutableArray*)getAllDirectoryByCategory:(NSInteger)type;
+(NSString*)convertPoitypeToPoistring:(NSInteger)poiType;
@end
