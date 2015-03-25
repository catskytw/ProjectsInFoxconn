//
//  SyncAction.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/9/8.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SyncAction.h"
#import "CalendarNetworkInterface.h"
#import "CalendarDAO.h"
#import "FMDatabase.h"
#import "SingletonDBConnect.h"
#import "FMResultSet.h"
#import "SQLCommand.h"
#import "FcConfig.h"
#define DatePlist @"Date.plist"
@interface SyncAction(PrivateMethod)
-(NSString*)createEditableCopyOfPlistIfNeeded;
@end
@implementation SyncAction
-(void)threadAction{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    while ([[NSThread currentThread]isCancelled]==NO) {
        [NSThread sleepForTimeInterval:300.0f];
        
    }
    [pool release];
}

-(void)pushNewEventToServer{
    FMResultSet *r=[[SingletonDBConnect share]executeQuery:AllNewEventsKeys];
    while ([r next]) {
        
    }
}
-(BOOL)addNewEventId:(NSString*)eventId{
    return [[SingletonDBConnect share]executeUpdate:AddNewEventId(eventId)];
}
-(void)fetchNewEventsFromServer{
    NSString *plistPath=[self createEditableCopyOfPlistIfNeeded];
    NSMutableDictionary *plistData=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDate *lastModifyDate=(NSDate*)[plistData objectForKey:@"lastModifyTime"];
    NSMutableDictionary *events=[[CalendarNetworkInterface share] fetchEventsFromDate:lastModifyDate];
    NSArray *allKeys=[[events keyEnumerator] allObjects];
    
    for (NSString *serverId in allKeys) {
        EKEvent *newEvent=(EKEvent*)[events valueForKey:serverId];
        NSString *localKey=@"";
        BOOL hasLocalKey=NO;
        FMResultSet *result=[[SingletonDBConnect share] executeQuery:GetLocalKeys(serverId)];
        //NSLog(@"GetLocolKeys %@", GetLocalKeys(serverId));
        while ([result next]) {
            hasLocalKey=YES;
            localKey = [result stringForColumn:@"LOCALID"];
            //NSLog(@"result localKey %@", localKey);
            break;
        }
        
        if (hasLocalKey) {
            [[CalendarDAO share] updateEventWithEKEvent:newEvent withEventId:localKey];
            NSLog(@"update event %@ %@ %@ %@",newEvent.title, newEvent.location, newEvent.notes, [newEvent.startDate description]);
        }else{
            NSString *_newLocakKey=[[CalendarDAO share]addEventWithEKEvent:newEvent];
            NSLog(@"add event %@ %@ %@ %@",newEvent.title, newEvent.location, newEvent.notes, [newEvent.startDate description]);
            [[SingletonDBConnect share]executeUpdate:AddKeysMapping(_newLocakKey, serverId)];
        }
    }
    NSDate *dateNow=[NSDate new];
    [plistData setValue:dateNow forKey:@"lastModifyTime"];
    [plistData writeToFile:plistPath atomically:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawTodayEvents object:nil];
}

-(NSString*)createEditableCopyOfPlistIfNeeded{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    NSString *writeDBPath=[documentDir stringByAppendingPathComponent:DatePlist];
    if([fileManager fileExistsAtPath:writeDBPath isDirectory:NO])
        return writeDBPath; //有檔案了
    
    NSString *defaultDatabasePath=[[NSBundle mainBundle] pathForResource:DatePlist ofType:@""];
    NSError *error;
    [fileManager removeItemAtPath:writeDBPath error:&error];
    BOOL r=[fileManager copyItemAtPath:defaultDatabasePath toPath:writeDBPath error:&error];
    if(!r) NSLog(@"Copy database file failure!");
    return writeDBPath;
}
@end
