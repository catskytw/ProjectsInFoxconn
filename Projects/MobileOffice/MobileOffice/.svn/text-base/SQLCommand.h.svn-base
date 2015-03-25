//
//  SQLCommand.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/9/7.
//  Copyright 2011年 foxconn. All rights reserved.
//
#define AddKeysMapping(localKey, serverKey) [NSString stringWithFormat:@"INSERT INTO IDsMapping (\"LOCALID\",\"SERVERID\") VALUES(\"%@\",\"%@\")",localKey,serverKey]
#define GetLocalKeys(serverKey) [NSString stringWithFormat:@"SELECT LOCALID FROM IDsMapping WHERE SERVERID='%@'",serverKey]
#define AddNewEventId(eventId) [NSString stringWithFormat:@"INSERT INTO NewEventQueue (\"%@\") VALUES (\"%@\")",eventId]
#define AllNewEventsKeys [NSString stringWithFormat:@"SELECT * FROM NewEventQueue"]
#define GetServerKeys(localKey) [NSString stringWithFormat:@"SELECT SERVERID FROM IDsMapping WHERE LOCALID='%@'",localKey]