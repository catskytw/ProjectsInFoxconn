//
//  MapDataCtrl.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapDataCtrl.h"
#import "FcConfig.h"
#import "NSFileHandleExtend.h"
@implementation MapDataCtrl
@synthesize featureCount;
-(id)initWithFileName:(NSString*)thisFileName{
	if((self=[super init])){
		//path = [[[ NSBundle mainBundle ] pathForResource:thisFileName ofType:@"dat"]retain];
        path=[NSString stringWithFormat:@"%@.dat",thisFileName];
		if (path != nil){
			totalData=[[NSData dataWithContentsOfFile:path]retain];
			featureCount=[MiscTool getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(0, 4)]];
		}
	}
	return self;
}
-(MapFeature*)getFeatureObject:(NSInteger)indexInData withFeatureType:(NSInteger)featureType{

	NSData *featureNSData=[self getFeatureData:indexInData];
	//整個feature的長度
	int style=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(0, 2)]];
	if(featureType!=style) return nil;
	MapFeature *result=[MapFeature new];
	result.featureId=indexInData;
	result.style=style;
	int styleLength,nameLength,pointNum,pointLength,addInfoStartPosition,addInfoLength;
	switch (style) {
		case FeatureTypePoint:
			styleLength=10;
			nameLength=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength, 2)]];
			pointNum=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength+2+nameLength, 2)]];
			pointLength=8*pointNum;
			addInfoStartPosition=styleLength+2+nameLength+2+pointLength;
			addInfoLength=[featureNSData length]-addInfoStartPosition;
			result.styleObject=[[[MapPoint alloc]initWithColorData:[featureNSData subdataWithRange:NSMakeRange(2, 4)] withSize:[featureNSData subdataWithRange:NSMakeRange(8, 1)] withBmpId:[featureNSData subdataWithRange:NSMakeRange(6, 2)] withIsIcon:[featureNSData subdataWithRange:NSMakeRange(9, 1)]]autorelease];
			result.featureName=[self getFeatureName:featureNSData withStartPosition:styleLength+2 withLength:nameLength];
			result.points=[self getPoints:styleLength+2+nameLength+2 withFeatureData:featureNSData withPointNum:pointNum];
			result.addInfo=[self getAddInfo:featureNSData withPosition:addInfoStartPosition withLength:addInfoLength];
			break;
		case FeatureTypeLine:
			styleLength=8;
			nameLength=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength, 2)]];
			pointNum=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength+2+nameLength, 2)]];
			pointLength=8*pointNum;
			addInfoStartPosition=styleLength+2+nameLength+2+pointLength;
			addInfoLength=[featureNSData length]-addInfoStartPosition;
			result.styleObject=[[[MapLine alloc]initWithColorData:[featureNSData subdataWithRange:NSMakeRange(2, 4)] withWidth:[featureNSData subdataWithRange:NSMakeRange(7, 1)] withPattern:[featureNSData subdataWithRange:NSMakeRange(6, 1)]]autorelease];
			result.featureName=[self getFeatureName:featureNSData withStartPosition:styleLength+2 withLength:nameLength];
			result.points=[self getPoints:styleLength+2+nameLength+2 withFeatureData:featureNSData withPointNum:pointNum];
			result.addInfo=[self getAddInfo:featureNSData withPosition:addInfoStartPosition withLength:addInfoLength];
			break;
		case FeatureTypeRegion:
			styleLength=18;
			nameLength=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength, 2)]];
			pointNum=[MiscTool getIntFromLittleNSData:[featureNSData subdataWithRange:NSMakeRange(styleLength+2+nameLength, 2)]];
			pointLength=8*pointNum;
			addInfoStartPosition=styleLength+2+nameLength+2+pointLength;
			addInfoLength=[featureNSData length]-addInfoStartPosition;
			result.styleObject=[[[MapRegion alloc]initWithColorData:[featureNSData subdataWithRange: NSMakeRange(8, 4)] withLineData:[featureNSData subdataWithRange:NSMakeRange(2, 6)]]autorelease];
			result.featureName=[self getFeatureName:featureNSData withStartPosition:styleLength+2 withLength:nameLength];
			result.points=[self getPoints:styleLength+2+nameLength+2 withFeatureData:featureNSData withPointNum:pointNum];
			result.addInfo=[self getAddInfo:featureNSData withPosition:addInfoStartPosition withLength:addInfoLength];
			break;
		default:
			//-1代表沒有此項feature
			result.style=-1;
			break;
	}
	
	return [result autorelease];
}

-(NSString*)getAddInfo:(NSData*)featureData withPosition:(NSInteger)startPosition withLength:(NSInteger)length{
	NSString *result=[[[NSString alloc] initWithData:[featureData subdataWithRange:NSMakeRange(startPosition, length)] encoding:NSUnicodeStringEncoding]autorelease];
	return result;
}
-(NSMutableArray*)getPoints:(NSInteger)startPosition withFeatureData:(NSData*)featureData withPointNum:(NSInteger)pointNum{
	NSMutableArray *result=[NSMutableArray arrayWithObjects:nil];
	for(int i=0;i<pointNum;i++){
		int x=[MiscTool getIntFromLittleNSData:[featureData subdataWithRange:NSMakeRange(startPosition+8*i, 4)]];
		int y=[MiscTool getIntFromLittleNSData:[featureData subdataWithRange:NSMakeRange(startPosition+4+8*i, 4)]];
		CGPoint thisCoordination=CGPointMake(x, y);
		[result enqueue:[NSValue valueWithCGPoint:thisCoordination]];
	}
	return result;
}
-(NSString*)getFeatureName:(NSData*)featureNSData withStartPosition:(NSInteger)startPosition withLength:(NSInteger)length{
	NSString *result=[[[NSString alloc] initWithData:[featureNSData subdataWithRange:NSMakeRange(startPosition, length)] encoding:NSUnicodeStringEncoding]autorelease];
	return result;
}
/**
 search the index to acquire FeatureData array
 */
-(NSData*)getFeatureData:(NSInteger)indexInData{
	const int indexNodexLength=6;
	const int headerLength=16;
	int startPosition=6*indexInData+headerLength;
	NSData *indexNode=[totalData subdataWithRange:NSMakeRange(startPosition, indexNodexLength)];
	int featureStartPosition=[MiscTool getIntFromLittleNSData:[indexNode subdataWithRange:NSMakeRange(0, 4)]];
	int featureLength=[MiscTool getIntFromLittleNSData:[indexNode subdataWithRange:NSMakeRange(4, 2)]];

	return [totalData subdataWithRange:NSMakeRange(featureStartPosition, featureLength)];
}
-(void)dealloc{
	[totalData release];
	[super dealloc];
}
@end
