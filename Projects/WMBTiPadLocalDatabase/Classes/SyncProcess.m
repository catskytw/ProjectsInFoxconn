//
//  SyncProcess.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SyncProcess.h"
#import "SyncCommand.h"
#import "QueryPattern.h"
#import "NSString+extension.h"
@interface SyncProcess (PrivateMethod)
-(void)printColumnValue:(NSString*)column withTable:(NSString*)tableName;
-(NSString*)fetchFileName:(NSString*)subPath;
@end
@implementation SyncProcess
-(void)test{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSInteger filesNum= [[[NSFileManager defaultManager] directoryContentsAtPath:documentsDirectory] count];
    NSLog(@"total files: %i",filesNum);
}
-(void)syncDatabase{
//    examValue();
//    start sync
    syncProductSpec();
    syncProductType();
    syncProductImage();
    syncProduct();
    syncProductBrand();
    syncProductScene();
    syncProductSceneGroup();
    
//    end sync
}
-(void)downloadAllPic{
    //download all pics from 2 tables: T_PRODUCT_IMAGE0, T_PRODUCT_SCENE0
    //delete all pics
    NSString *path=[NSString documentPath];
    NSError *err;
    NSArray *r=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&err];
    for(NSString *fileName in r){
        if([fileName rangeOfString:@".jpg"].length>0){
            [[NSFileManager defaultManager] removeItemAtPath:
             [NSString stringWithFormat:@"%@/%@",path,fileName] error:&err];
        }
    }
    NSInteger allTotal;
    NSInteger totalCount=[[SingletonDBConnect share]intForQuery:COUNTSQLSTRING(@"T_PRODUCT_IMAGE0")];
    allTotal=totalCount;
    int startIndex=0;
    int num=50;
    
    do {
        NSArray *picPathes=getImageNameFromImageTable(num,startIndex);
        for (NSString *picSubPath in picPathes) {
            syncPic(picSubPath,[self fetchFileName:picSubPath]);
            if([[self fetchFileName:picSubPath]isEqualToString:@"09000002AL1112060215.JPG"])
                NSLog(@"find main pic!");
        }
        startIndex+=num;
    } while (startIndex<totalCount);
    
    //download from T_PRODUCT_SCENE
    totalCount=[[SingletonDBConnect share]intForQuery:COUNTSQLSTRING(@"T_PRODUCT_SCENE0")];
    allTotal+=totalCount;
    startIndex=0;
    do {
        NSArray *picPathes=getImageNameFromSceneTable(num,startIndex);
        for (NSString *picSubPath in picPathes) {
            syncPic(picSubPath,[self fetchFileName:picSubPath]);
        }
        startIndex+=num;
    } while (startIndex<totalCount);
    NSLog(@"%i pics downloaded.",allTotal);
}
-(void)printColumnValue:(NSString*)column withTable:(NSString*)tableName{
    QueryPattern *tmp=[QueryPattern new];
    [tmp prepareDicWithDictionary:(NSDictionary*)examTable(column,tableName)];
    for (int i=0; i<[tmp getNumberForKey:column]; i++) {
        NSLog(@"%@",[tmp getValue:column withIndex:i]);
    }
    [tmp release];
}
                    
-(NSString*)fetchFileName:(NSString*)subPath{
    NSArray *s=[subPath componentsSeparatedByString:@"/"];
    return [s objectAtIndex:[s count]-1];
}
@end
