//
//  SingletonDb.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SingletonDBConnect.h"
#import "FMDatabase.h"
#define DATABASE_FILE_PATH @"FcWMBTSQLite"
static FMDatabase *singletonDb=nil;

@interface SingletonDBConnect (PrivateMethod) 
+(void)runOpen;
+(NSString*)createEditableCopyOfDatabaseIfNeeded;
@end
@implementation SingletonDBConnect
+(FMDatabase*)share{
    if(singletonDb==nil){
        [self runOpen];
    }
    
    if(![singletonDb goodConnection]){
        [self closeDB];
        [self runOpen];
    }
    
    return singletonDb;
}
+(void)runOpen{
    singletonDb=[[FMDatabase databaseWithPath:[self createEditableCopyOfDatabaseIfNeeded]]retain];
    BOOL r=[singletonDb open];
    if(!r)NSLog(@"open database failure!");
}
+(void)closeDB{
    [singletonDb close];
    [singletonDb release];
    singletonDb=nil;
}

+(NSString*)createEditableCopyOfDatabaseIfNeeded{
    BOOL success;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    NSString *writeDBPath=[documentDir stringByAppendingPathComponent:DATABASE_FILE_PATH];
    if([fileManager fileExistsAtPath:writeDBPath isDirectory:NO])
        return writeDBPath; //有檔案了
    
     NSString *defaultDatabasePath=[[NSBundle mainBundle] pathForResource:DATABASE_FILE_PATH ofType:@""];
    NSError *error;
    [fileManager removeItemAtPath:writeDBPath error:&error];
    BOOL r=[fileManager copyItemAtPath:defaultDatabasePath toPath:writeDBPath error:&error];
    if(!r) NSLog(@"Copy database file failure!");
    return writeDBPath;
}
@end
