//
//  MyFavoriteModel.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFavoriteDetailTable.h"
#import "DirectoryObject.h"

@interface MyFavoriteModel : NSObject {

}
+(NSMutableArray*)getFavoriteFolderList:(NSInteger)favType;
+(BOOL)createFavoriteFolder:(NSInteger)categoryType withName:(NSString*)name;
+(BOOL)deleteFavoriteFolder:(NSString*)folderId;

+(NSString*)converCategoryIntToString:(NSInteger)queryType;
+(NSInteger)converCategoryStringToInt:(NSString*)queryMainType;

+(BOOL)editFavoriteFolder:(NSString*)folderId withDirName:(NSString*)dirName;
+(BOOL)addBusFavoriteItem:(NSString*)busLineId withBusStationId:(NSString*)stationId withLeaveMode:(NSString*)leaveString withDestFolderId:(NSString*)destFolderId;
+(NSMutableArray*)getFavoriteButItem:(NSString*)folderId;
+(BOOL)deleteBusFavoriteItem:(NSString*)itemId;
+(BOOL)addParkToFavorite:(NSString*)parkId withDestFolderId:(NSString*)destId;
+(NSMutableArray*)getFavoriteParkingItem:(NSString*)folderId;
+(BOOL)deleteParkFavoriteItem:(NSString*)itemId;
+(NSArray*)getFavLifeItem:(NSString*)folderId;
+(BOOL)addToFavorite:(NSString*)favType withStoreId:(NSString*)storeId withFolderId:(NSString*)folderId;
+(BOOL)deleteLifeFavoriteItem:(NSString*)folderId withItemId:(NSString*)itemId;
+(MyFavoriteDetailTable*)chooseFavoriteDetailViewController:(NSInteger)categoryType withDataObject:(DirectoryObject*)thisDataObject;
+(NSString*)getCategoryName:(NSInteger)queryType;
@end
