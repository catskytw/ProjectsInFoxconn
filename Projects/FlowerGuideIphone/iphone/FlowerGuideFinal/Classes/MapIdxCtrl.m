//
//  MapIdxCtrl.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapIdxCtrl.h"
#import "Queue.h"

@implementation MapIdxCtrl
@synthesize startX;
@synthesize startY;
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize cellRow;
@synthesize cellColumn;
-(id)initWithFileName:(NSString*)thisFileName{
	if((self=[super init])){
		NSString *path = [[ NSBundle mainBundle ] pathForResource:thisFileName ofType:@"idx"];
		if (path != nil){
			thisFileHandle=[NSFileHandle fileHandleForReadingAtPath:path];
			totalData=[[thisFileHandle readDataToEndOfFile]retain];
			//totalData=[[NSData dataWithContentsOfFile:path]retain];
			//連續讀header
			startX=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(0, 4)]];
			startY=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(4, 4)]];
			cellWidth=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(8, 4)]];
			cellHeight=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(12, 4)]];
			cellColumn=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(16, 4)]];
			cellRow=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(20, 4)]];
			[thisFileHandle closeFile];
		}
	}
	return self;
}
-(NSMutableDictionary*)getAllFeatureIdWithPoint1:(CGPoint)leftUpPoint withPoint2:(CGPoint)rightDownPoint{
	const int headerLength=24;
	NSMutableArray *grids=[self getAllGridWithPoint1:leftUpPoint withPoint2:rightDownPoint];
	NSMutableDictionary *allFeatureId=[[NSMutableDictionary alloc] init];
	for(NSNumber *thisGridId in grids){
		int thisGridIdValue=[thisGridId intValue];
		[self getAllFeatureIdInCollection:[totalData subdataWithRange:NSMakeRange(headerLength+thisGridIdValue*8, 8)] withDictionary:allFeatureId];
	}
	return [allFeatureId autorelease];
}

-(void)getAllFeatureIdInCollection:(NSData*)indexNodeData withDictionary:(NSMutableDictionary*)inputDictionary{
	int startPosition=[ToolsFunction getIntFromLittleNSData:[indexNodeData subdataWithRange:NSMakeRange(0, 4)]];
	int num=[ToolsFunction getIntFromLittleNSData:[indexNodeData subdataWithRange:NSMakeRange(4, 4)]];
	for(int i=0;i<num;i++){
		FeatureIdxObject *fio=[[[FeatureIdxObject alloc]init]autorelease];
		fio.styleType=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(startPosition+i*12, 4)]];
		fio.positionInDatFile=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(startPosition+4+i*12, 4)]];
		fio.featureId=[ToolsFunction getIntFromLittleNSData:[totalData subdataWithRange:NSMakeRange(startPosition+8+i*12, 4)]];
		
		//if(fio.featureId>1000)
			//NSLog(@"STOP!");
		[inputDictionary setValue:fio forKey:[NSString stringWithFormat:@"%i",fio.featureId]];
	}
	return;
}
-(NSMutableArray*)getAllGridWithPoint1:(CGPoint)leftUpPoint withPoint2:(CGPoint)rightDownPoint{
	//限制viewport的範圍沒有超出圖資地圖
	leftUpPoint.x=MAX(MIN(leftUpPoint.x,cellWidth*cellColumn),0);
	rightDownPoint.x=MAX(MIN(rightDownPoint.x,cellWidth*cellColumn),0);
	leftUpPoint.y=MAX(MIN(leftUpPoint.y,cellHeight*cellRow),0);
	rightDownPoint.y=MAX(MIN(rightDownPoint.y,cellHeight*cellRow),0);
	
	int leftUpColumnNum=(int)floor(leftUpPoint.x/cellWidth);
	int rightDownColumnNum=(int)floor(rightDownPoint.x/cellWidth);
	int leftUpRowNum=(int)floor(leftUpPoint.y/cellHeight);
	int rightDownRowNum=(int)floor(rightDownPoint.y/cellHeight);
	
	int columnCount=rightDownColumnNum-leftUpColumnNum+1;
	int rowCount=rightDownRowNum-leftUpRowNum+1;
	
	NSMutableArray *result=[NSMutableArray arrayWithObjects:nil];
	for(int i=0;i<rowCount;i++){
		for(int j=0;j<columnCount;j++){
			int currentValue=(leftUpRowNum*cellColumn+leftUpColumnNum)+j+i*cellColumn;
			
			if(currentValue>=cellRow*cellColumn){
				continue;
			}
			NSNumber *tmpNum=[NSNumber numberWithInt:currentValue];
			[result enqueue:tmpNum];
		}
	}
	return result;
}
-(void)dealloc{
	[totalData release];
	[super dealloc];
}
@end
