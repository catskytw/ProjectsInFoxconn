//
//  Tool.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Tool.h"
#import "QueryPattern.h"
#import "FcConfig.h"
@implementation Tool
+(void)pointNil:(NSArray*)_pointers{
    for (id pointer in _pointers) {
        pointer=nil;
    }
}
+(void)nilRelease:(id)_pointer{
    if(_pointer!=nil){
        [_pointer release];
        _pointer=nil;
    }
}
-(void)contructArray:(NSMutableArray*)_targetArray{
    if(!_targetArray)
        _targetArray=[[NSMutableArray alloc] init];
    else
        [_targetArray removeAllObjects];
}

+(NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    NSString *uuidStr = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) autorelease];
    CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
    
    CFRelease(uuidObject);
    
    return uuidStr;
}

+(NSString *)getReGeoCode:(CLLocation *)_Location{
    QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR_GOOGLEMAP];
    [query prepareDic:reGeoCode(_Location.coordinate.latitude, _Location.coordinate.longitude)];
    NSString* address = @"";
    @try {
        if ([query getNumberForKey:@"formatted_address"]>0) {
             address = [query getValueFromNodeString:@"formatted_address"];
        }else{
            NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
        }
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [query release];
        
    }
    return address;
}

+(void)makePhoneCall:(NSString*)phoneNumber{
    NSString *m_phoneNumber = [@"tel://"
                               stringByAppendingString:phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_phoneNumber]];
}
@end
