//
//  FcResourceUtility.m
//  OveExpo
//
//  Created by  on 11/10/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcResourceUtility.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "FcDrawing.h"

#define PLIST_FILE_PATH_RESOURCE @"Resource.plist"
@interface FcResourceUtility(PrivateMethod)
+ (void)readPlist;
+ (void)writeToPlist;
+ (BOOL)copyResource:(NSString *)resourceName toPath:(NSString *)path;
+ (NSString*)createEditableCopyOfPlistIfNeeded;
@end

@implementation FcResourceUtility
static NSString *localVersion=@"";
static NSString *serverVersion=@"";
static BOOL hasNewVer = NO;
static NSArray *resourceFiles;

+ (BOOL)copyResource:(NSString *)resourceName toPath:(NSString *)path
{
    NSFileManager *_fileManager = [NSFileManager defaultManager];
    NSString *_targetfileWithPath = [path stringByAppendingFormat:@"/%@",resourceName];
    NSLog(@"FcResourceCopy(debug) : _targetfileWithPath = %@", _targetfileWithPath);
    if ([_fileManager fileExistsAtPath:_targetfileWithPath isDirectory:NO] == YES) {
        NSLog(@"FcResourceCopy(Info) : Resource already exist...");
        return YES;
    }
    
    NSString *_resourcePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@""];
    
    if ([_fileManager fileExistsAtPath:_resourcePath isDirectory:NO]==NO) {
        NSLog(@"FcResourceCopy(Error) : file(%@) is not exist...", resourceName);
        return NO;
    }
    
    NSError *error=nil;
    if ([_fileManager copyItemAtPath:_resourcePath toPath:_targetfileWithPath error:&error] == NO) {
        NSLog(@"FcResourceCopy(Error) : %@", [error localizedFailureReason]);
        return NO;
    }
    
    return YES;
}

+ (NSString *)getLocalVersion
{
    [self readPlist];
    return localVersion;
}

+ (NSString *)getServerVersion
{
    NSString *version=nil;
    if (MY_TEST == YES) {
        version = @"1.0";
    }
    else
    {
        //Todo : Get photo list
        LoginDataObject *_login = [LoginDataObject sharedInstance];
        NSMutableArray *_pics = [NSMutableArray new];
        QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        [query prepareDic:getResourceVersion(_login.sessionId)];
        
        if (([[query getValue:@"response" withIndex:0] isEqualToString:@"0"])) {
            version = [query getValue:@"version" withIndex:0];
            NSInteger num=[query getNumberUnderNode:@"urlList" withKey:@"url"];
            for(int i=0;i<num;i++){
                NSString *_url = [query getValueUnderNode:@"urlList" withKey:@"url" withIndex:i];
                [_pics addObject:_url];
            }
            resourceFiles = _pics;
        }
        [_pics autorelease];
        [query release];
    }
    if (version!=nil) {
        serverVersion = version;
    }
    
    return serverVersion;
}

+ (BOOL)hasNewResourceVersion
{
    NSString *_localVer = [self getLocalVersion];
    NSString *_serverVer = [self getServerVersion];
    return YES;
    if (![_localVer isEqualToString:_serverVer]) {
        
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)updateResources
{
    BOOL _result = YES;
    if ([self hasNewResourceVersion]) {
        //XXXX : Need to get resources from server.
        if (MY_TEST == YES) {
            //Get resources name from server
            NSMutableArray *_resources = [NSMutableArray new];
            [_resources addObject:@"/reach1.txt"];
            [_resources addObject:@"/reach2.txt"];
            [_resources addObject:@"/group_table_i.png"];
            resourceFiles = [_resources autorelease];
            
            //Get resources data from server
            NSString *_resourceName = @"group_table_i.png";
            //NSString *_resourcePath = [@"/Users/foxconn/Downloads/" stringByAppendingFormat:_resourceName];
            NSString *_resourcePath = [[NSBundle mainBundle] pathForResource:_resourceName ofType:@""];
            NSError *error;
            NSFileManager *_fileManager = [NSFileManager defaultManager];            
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDir=[[paths objectAtIndex:0] stringByAppendingFormat:@"/%@",_resourceName];
            NSLog(@"documentDir=%@", documentDir);
            if ([_fileManager copyItemAtPath:_resourcePath toPath:documentDir error:&error] == NO) {
             NSLog(@"FcResourceCopy(Error) : %@", [error localizedFailureReason]);
                _result = NO;
             }
            
            //Test : test by using getQRCode
            /*NSURL *_photo_url = [NSURL URLWithString:getQRCode(_login.sessionId)];
            
            NSLog(@"_photo_url=%@", [_photo_url path]);
            NSData *data=[NSData dataWithContentsOfURL:_photo_url];
            
            //Write file
            NSError *error;
            NSFileManager *_fileManager = [NSFileManager defaultManager];            
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDir=[paths objectAtIndex:0];
            if ([data writeToFile:[documentDir stringByAppendingFormat:@"/123.png"] atomically:YES] == NO) {
                NSLog(@"FcResourceCopy(Error) : %@", [error localizedFailureReason]);
                _result = NO;
            }*/
            
        }
        else
        {
            //若是第一次使用需要做local端的圖臺資料copy.
            if (localVersion==nil || [localVersion isEqualToString:@""] == YES) {
                NSLog(@"copy 圖臺資料...");
                //*** binaryData
                NSArray *_photographs_1 = [[NSArray alloc] initWithObjects:@"A_2F_V", @"A_3F_V", @"B_1F_V", @"B_2F_V", nil];
                NSArray *_photographs_2 = [[NSArray alloc] initWithObjects:@"_location", @"_point", @"_region", @"_route", nil];
                NSArray *_photographs_3 = [[NSArray alloc] initWithObjects:@".dat", @".idx", nil];
                //*** route
                NSArray *_photographs_4 = [[NSArray alloc] initWithObjects:@"_route.txt", nil];
                //1.generate target path
                //NSFileManager *_fileManager = [NSFileManager defaultManager];            
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentDir=[paths objectAtIndex:0];
                //NSString *documentDir=[[paths objectAtIndex:0] stringByAppendingFormat:@"/%@",_resourceName];
                NSLog(@"documentDir=%@", documentDir);
                //2.generate file name
                for (int i=0; i<[_photographs_1 count]; i++) {
                    NSString *file_1 = [_photographs_1 objectAtIndex:i];
                    for (int j=0; j<[_photographs_2 count]; j++) {
                        NSString *file_2 = [_photographs_2 objectAtIndex:j];
                        for (int k=0; k<[_photographs_3 count]; k++) {
                            NSString *file_3 = [_photographs_3 objectAtIndex:k];
                            NSString *_fullFileName = [NSString stringWithFormat:@"%@%@%@", file_1, file_2, file_3];
                            NSLog(@"_fullFileName=%@", _fullFileName);
                            //NSString *_toPath = [NSString stringWithFormat:@"%@/%@",documentDir,_fullFileName];
                            [self copyResource:_fullFileName toPath:documentDir];
                        }
                    }
                    
                    for (int j=0; j<[_photographs_4 count]; j++) {
                        NSString *file_4 = [_photographs_4 objectAtIndex:j];
                        NSString *_fullFileName = [NSString stringWithFormat:@"%@%@", file_1, file_4];
                        NSLog(@"_fullFileName2=%@", _fullFileName);
                        //NSString *_toPath = [documentDir stringByAppendingFormat:@"/%@",_fullFileName];
                        [self copyResource:_fullFileName toPath:documentDir];
                    }
                }
                
                
            }
            
            //Get resources from server
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDir=[paths objectAtIndex:0];
            for (int i=0; i<[resourceFiles count]; i++) {
                NSString *_resourceName = [resourceFiles objectAtIndex:i];
                //暫時解 start : check in 之前要移除.
                //_resourceName = [_resourceName substringFromIndex:1];
                //_resourceName = [NSString stringWithFormat:@"/%@",_resourceName];
                //暫時解 end.
                
                NSString *_resourceName_http = [URLPREFIX stringByAppendingFormat:_resourceName];
                //NSString *_resourceName_http = [URLPREFIX stringByAppendingFormat:@"/941A047F-053C-49BD-B9E3-339295FB5B22.png"];
                NSLog(@"_resourceName=%@", _resourceName_http);
                //Get photo from server.                
                NSURL *_photo_url = [NSURL URLWithString:_resourceName_http];
                //NSURL *_photo_url = [NSURL URLWithString:getQRCode(_login.sessionId)];
                NSLog(@"_photo_url=%@", [_photo_url path]);
                NSData *data=[NSData dataWithContentsOfURL:_photo_url];
                
                //Write photo to user document path
                NSString *_toPath = [documentDir stringByAppendingFormat:_resourceName];
                NSLog(@"_toPath=%@", _toPath);
                NSError *error;
                if ([data length] == 0) {
                    NSLog(@"圖臺檔案 length is zero...");
                    _result = NO;
                }else if([data writeToFile:_toPath options:NSDataWritingAtomic error:&error] == NO) {
                    NSLog(@"FcResourceCopy(Error) : %@", [error localizedFailureReason]);
                    //NSLog(@"FcResourceCopy(Error) : ...");
                    _result = NO; 
                }
                /*if ([data writeToFile:_toPath atomically:YES] == NO) {
                 //NSLog(@"FcResourceCopy(Error) : %@", [error localizedFailureReason]);
                 NSLog(@"FcResourceCopy(Error) : ...");
                 _result = NO; 
                 }*/
            }
        }
    }
    
    //Update local version
    if (_result == YES) {
        [self writeToPlist];
    }
    return _result;
}

+(NSString*)createEditableCopyOfPlistIfNeeded{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    NSString *writeDBPath=[documentDir stringByAppendingPathComponent:PLIST_FILE_PATH_RESOURCE];
    NSLog(@"writeDBPath %@",writeDBPath);
    if([fileManager fileExistsAtPath:writeDBPath isDirectory:NO])
        return writeDBPath; //有檔案了
    
    NSString *defaultDatabasePath=[[NSBundle mainBundle] pathForResource:PLIST_FILE_PATH_RESOURCE ofType:@""];
    NSError *error;
    [fileManager removeItemAtPath:writeDBPath error:&error];
    NSLog(@"defaultDatabasePath %@",defaultDatabasePath);    
    BOOL r=[fileManager copyItemAtPath:defaultDatabasePath toPath:writeDBPath error:&error];
    if(!r) NSLog(@"Copy database file failure!");
    return writeDBPath;
}

+ (void)readPlist
{
    //NSString *filePath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Account.plist"];
    
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self createEditableCopyOfPlistIfNeeded]];
    
    localVersion = [[plistDict objectForKey:@"localVersion"] copy];
    
    if (plistDict) {
        [plistDict release];
    }
    /* You could now call the string "value" from somewhere to return the value of the string in the .plist specified, for the specified key. */
}

+ (void)writeToPlist
{
    // NSString *filePath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[self createEditableCopyOfPlistIfNeeded]];
    //NSLog(filePath);
    
    
    if (serverVersion != nil && [serverVersion length]>0) {
    //if (NO) {
        NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self createEditableCopyOfPlistIfNeeded]];
        [plistDict setValue:serverVersion forKey:@"localVersion"];
        [plistDict writeToFile:[self createEditableCopyOfPlistIfNeeded] atomically: YES];
        if (plistDict) {
            [plistDict release];
        }
    }
    
    /* This would change the firmware version in the plist to 1.1.1 by initing the NSDictionary with the plist, then changing the value of the string in the key "ProductVersion" to what you specified */
}

+ (void) selfTest
{
    NSString *_path = @"/Users/foxconn/project/svnX/temp";
    NSString *_resource = @"group_table_i.png";
    BOOL result = [FcResourceUtility copyResource:_resource toPath:_path];
    NSLog(@"selfTest : %d",result);
}

@end
