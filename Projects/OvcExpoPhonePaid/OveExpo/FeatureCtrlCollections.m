//
//  FeatureCtrlCollections.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeatureCtrlCollections.h"
#import "FcConfig.h"
static FeatureCtrlCollections *currentFeatureCtrlCollections;

@interface FeatureCtrlCollections(PrivateMethod)
-(void)releaseObject:(id)obj;
@end
@implementation FeatureCtrlCollections
@synthesize regionIdxCtrl;
@synthesize regionDataCtrl;
@synthesize pointIdxCtrl;
@synthesize pointDataCtrl;
@synthesize routeIdxCtrl;
@synthesize routeDataCtrl;
@synthesize locationIdxCtrl;
@synthesize locationDataCtrl;
@synthesize whichFloor;
+(FeatureCtrlCollections*)current{
	if(currentFeatureCtrlCollections==nil)
		currentFeatureCtrlCollections=[FeatureCtrlCollections new];
	return currentFeatureCtrlCollections;
}
-(id)init{
    if((self=[super init])){
        regionIdxCtrl=nil;
        regionDataCtrl=nil;
        pointIdxCtrl=nil;
        pointDataCtrl=nil;
        routeIdxCtrl=nil;
        routeDataCtrl=nil;
    }
    return self;
}
-(void)loadMapData:(NSInteger)MapDataType{
    whichFloor=MapDataType;
    [self releaseObject:regionDataCtrl];
    [self releaseObject:regionIdxCtrl];
    [self releaseObject:pointDataCtrl];
    [self releaseObject:pointIdxCtrl];
    [self releaseObject:routeDataCtrl];
    [self releaseObject:routeIdxCtrl];
    [self releaseObject:locationDataCtrl];
    [self releaseObject:locationIdxCtrl];
    /*
    A_2F=0,
    A_3F=1,
    B_1F=2,
    B_2F=3
     */
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    NSString *region,*route,*point,*location;
    switch (MapDataType) {
        case A_2F:
            region=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_2F_V_region"];
            route=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_2F_V_route"];
            point=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_2F_V_point"];
            location=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_2F_V_location"];
            break;
        case A_3F:
            region=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_3F_V_region"];
            route=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_3F_V_route"];
            point=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_3F_V_point"];
            location=[NSString stringWithFormat:@"%@/%@",documentDir,@"A_3F_V_location"];
            break;
        case B_1F:
            region=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_1F_V_region"];
            route=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_1F_V_route"];
            point=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_1F_V_point"];
            location=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_1F_V_location"];
            break;
        case B_2F:
            region=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_2F_V_region"];
            route=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_2F_V_route"];
            point=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_2F_V_point"];
            location=[NSString stringWithFormat:@"%@/%@",documentDir,@"B_2F_V_location"];
            break;
    }
    NSLog(@"region:%@",region);
    regionDataCtrl=[[MapDataCtrl alloc]initWithFileName:region];
    regionIdxCtrl=[[MapIdxCtrl alloc]initWithFileName:region];
    pointDataCtrl=[[MapDataCtrl alloc]initWithFileName:point];
    pointIdxCtrl=[[MapIdxCtrl alloc]initWithFileName:point];
    routeDataCtrl=[[MapDataCtrl alloc]initWithFileName:route];
    routeIdxCtrl=[[MapIdxCtrl alloc]initWithFileName:route];
    locationIdxCtrl=[[MapIdxCtrl alloc]initWithFileName:location];
    locationDataCtrl=[[MapDataCtrl alloc]initWithFileName:location];
}

-(void)dealloc{
	[regionIdxCtrl release];
	[regionDataCtrl release];
	[pointIdxCtrl release];
	[pointDataCtrl release];
	[routeIdxCtrl release];
	[routeDataCtrl release];
    [locationDataCtrl release];
    [locationIdxCtrl release];
	currentFeatureCtrlCollections=nil;
	[super dealloc];
}

-(void)releaseObject:(id)obj{
    if(obj!=nil){
        [obj release];
        obj=nil;
    }
}
@end
