//
//  JSONCoreDataUtil.h
//  FoxconnQueryLib
//
//  Created by 廖 晨志 on 2010/12/21.
//  Copyright 2010 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSONCoreDataUtil : NSObject {
	NSMutableArray *dataArray;
    //搜尋深度
    NSInteger depthIndex;
}
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic)NSInteger depthIndex;
-(void)fetchObjects:(NSDictionary*)dataDic withQueryString:(NSString *)queryString withDepth:(NSInteger)depth;
-(void)fetchObjectsWithNoTypeDataSource:(id)dataSource withQueryString:(NSString*)queryString;
-(void)fetchObjects:(NSDictionary*)dataDic withQueryString:(NSString*)queryString;
-(void)fetchObjectsInArray:(NSArray*)dataArray withQueryString:(NSString*)queryString;
-(NSString*)searchValue:(NSInteger)index;

@end
