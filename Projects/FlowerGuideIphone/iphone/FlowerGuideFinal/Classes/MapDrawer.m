//
//  MapDrawer.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapDrawer.h"
#import "DrawFunctions.h"
#import "Vars.h"
@implementation MapDrawer
@synthesize mapImageRef;
@synthesize pointArray;
@synthesize shortestPathArray;
@synthesize isDrawTree;
@synthesize isDrawContentPoint;
@synthesize isDrawRoute;
@synthesize isDrawShortestPath;
@synthesize worldRect;
@synthesize is3DFlag;
@synthesize height,width;
-(id)initWithWorldRect:(CGRect)thisWorldRect with3D:(BOOL)is3D withMonitorWidth:(NSInteger)thisWidth withMonitorHeight:(NSInteger)thisHeight withFeatureCollection:(FeatureCtrlCollections*)thisFcc withShortestPathArray:(NSMutableArray*)edgeArray{
	if((self=[super init])){
		//先行將所有tree image loading進來
		[self loadTreeImage];
		pointArray=[[NSMutableArray arrayWithObjects:nil]retain];
		shortestPathArray=[[NSMutableArray arrayWithObjects:nil]retain];
		[shortestPathArray addObjectsFromArray:edgeArray];
		width=thisWidth;
		height=thisHeight;
		worldRect=thisWorldRect;
		is3DFlag=is3D;
		fcc=thisFcc;
		
		//reuse this context
		mapContextRef=[DrawFunctions createBitmapContext:width withHeight:height];
		CGContextSetLineCap(mapContextRef, kCGLineCapRound);
		mapImageRef=NULL;
		isDrawTree=YES;
		isDrawRoute=YES;
		isDrawContentPoint=YES;
		isDrawShortestPath=YES;
	}
	return self;
}
-(void)redraw{
	if(mapImageRef!=NULL)
		CGImageRelease(mapImageRef);
	CGContextSaveGState(mapContextRef);
	CGContextClearRect(mapContextRef, CGRectMake(0, 0, width, height));
	/**TODO 
		畫3D圖與畫2D全區圖,應分別拆開
		2D圖之繪製,應重複使用同一個CGImageRef,速度才會快
	 */

	[self drawMapWithDataCtrl:fcc.regionDataCtrl withInxCtrl:fcc.regionIdxCtrl withCGContextRef:mapContextRef withStyleType:FeatureTypeRegion withPointType:regionPointType];
	[self drawMapWithDataCtrl:fcc.regionDataCtrl withInxCtrl:fcc.regionIdxCtrl withCGContextRef:mapContextRef withStyleType:FeatureTypeLine withPointType:regionPointType];

	if(isDrawRoute) [self drawMapWithDataCtrl:fcc.routeDataCtrl withInxCtrl:fcc.routeIdxCtrl withCGContextRef:mapContextRef withStyleType:FeatureTypeLine withPointType:regionPointType];
	if(isDrawShortestPath) [self drawShortestPath:shortestPathArray];
	if(isDrawTree) [self drawMapWithDataCtrl:fcc.regionDataCtrl withInxCtrl:fcc.regionIdxCtrl withCGContextRef:mapContextRef withStyleType:FeatureTypePoint withPointType:regionPointType];
	if(isDrawContentPoint) [self drawMapWithDataCtrl:fcc.pointDataCtrl withInxCtrl:fcc.pointIdxCtrl withCGContextRef:mapContextRef withStyleType:FeatureTypePoint withPointType:pointPointType];	

	mapImageRef=CGBitmapContextCreateImage(mapContextRef);
	CGContextRestoreGState(mapContextRef);
}
-(void)dealloc{
	[self releaseTreeImage];
	CGContextRelease(mapContextRef);
	CGImageRelease(mapImageRef);
	[pointArray release];
	[shortestPathArray release];
	[super dealloc];
}
-(void)drawMapWithDataCtrl:(MapDataCtrl*)dataCtrl withInxCtrl:(MapIdxCtrl*)idxCtrl withCGContextRef:(CGContextRef)ref withStyleType:(NSInteger)styleType withPointType:(NSInteger)pointType{
	MapPresentCtrl *presentCtrl=[[MapPresentCtrl alloc]initWithMapDataCtrl:dataCtrl withMapIdxCtrl:idxCtrl withWorldRect:worldRect withMonitorWidth:width withMonitorHeight:height is3D:is3DFlag];

	NSMutableArray *allFeatures=[presentCtrl getAllFeatureAfterTransform:styleType];

	for(MapFeature *eachFeature in allFeatures){
		[self drawFeature:ref withFeature:eachFeature withPointType:pointType];
	}

	[presentCtrl release];
}
-(void)drawShortestPath:(NSMutableArray*)edgeArray{
	if(edgeArray==nil) return;
	MapPresentCtrl *presentCtrl=[[MapPresentCtrl alloc]initWithMapDataCtrl:nil withMapIdxCtrl:nil withWorldRect:worldRect withMonitorWidth:width withMonitorHeight:height is3D:is3DFlag];
	for(Edge *thisEdge in edgeArray){
		MapFeature *tmpFeature=[fcc.routeDataCtrl getFeatureObject:[thisEdge.edgeName intValue] withFeatureType:FeatureTypeLine];
		[presentCtrl transFormFeature:tmpFeature];
		[self drawShortestPathLine:tmpFeature];
	}
	[presentCtrl release];
}

-(void)drawShortestPathLine:(MapFeature*)lineFeature{
	if([lineFeature.drawingArray count]<2) return;
	CGContextSetRGBStrokeColor(mapContextRef, 0.40625f, 0.8828125f, 0.83203125f, 1.0f);
	CGContextBeginPath(mapContextRef);
	if(is3DFlag)
		CGContextSetLineWidth(mapContextRef, 18);
	else
		CGContextSetLineWidth(mapContextRef, 6);	
	CGPoint headPoint=[[lineFeature.drawingArray objectAtIndex:0]CGPointValue];
	CGContextMoveToPoint(mapContextRef, headPoint.x, headPoint.y);
	for(int i=1;i<[lineFeature.drawingArray count];i++){
		CGPoint thisPoint=[[lineFeature.drawingArray objectAtIndex:i]CGPointValue];
		CGContextAddLineToPoint(mapContextRef, thisPoint.x, thisPoint.y);
	}
	CGContextStrokePath(mapContextRef);
}
-(void)drawFeature:(CGContextRef)ref withFeature:(MapFeature*)targetFeature withPointType:(NSInteger)pointType{

		float red=(float)targetFeature.styleObject.red/255.0f;
		float green=(float)targetFeature.styleObject.green/255.0f;
		float blue=(float)targetFeature.styleObject.blue/255.0f;
		
		MapLine *mapLineStyle;
		CGPoint headPoint;
		
		switch (targetFeature.style) {
			case FeatureTypePoint:
				headPoint=[[targetFeature.drawingArray objectAtIndex:0]CGPointValue];
				[self drawPOI:(MapFeature*)targetFeature withPosition:headPoint withPointType:pointType];
				break;
			case FeatureTypeLine:
				if([targetFeature.drawingArray count]<2)
					return;
				CGContextSetRGBStrokeColor(ref, red, green, blue, 1);
				mapLineStyle=(MapLine*)targetFeature.styleObject;
				
				if(is3DFlag)
					CGContextSetLineWidth(ref, mapLineStyle.width);
				else
					CGContextSetLineWidth(ref, 6);
				CGContextBeginPath(ref);
				headPoint=[[targetFeature.drawingArray objectAtIndex:0]CGPointValue];
				CGContextMoveToPoint(ref, headPoint.x, headPoint.y);
				for(int i=1;i<[targetFeature.drawingArray count];i++){
					CGPoint thisPoint=[[targetFeature.drawingArray objectAtIndex:i]CGPointValue];
					CGContextAddLineToPoint(ref, thisPoint.x, thisPoint.y);
				}
				CGContextStrokePath(ref);
				break;
			case FeatureTypeRegion:
				//TODO 沒有畫region裡的lineStyle
				if([targetFeature.drawingArray count]<3) return;
				CGContextSetRGBFillColor(ref,red,green,blue,1);
				CGContextSetRGBStrokeColor(ref, red, green, blue, 1);
				
				CGContextBeginPath(ref);
				headPoint=[[targetFeature.drawingArray objectAtIndex:0]CGPointValue];
				CGContextMoveToPoint(ref, headPoint.x, headPoint.y);
				for(int i=1;i<[targetFeature.drawingArray count];i++){
					CGPoint thisPoint=[[targetFeature.drawingArray objectAtIndex:i]CGPointValue];
					CGContextAddLineToPoint(ref, thisPoint.x, thisPoint.y);
				}
				CGContextClosePath(ref);
				CGContextDrawPath(ref, kCGPathFillStroke);
				break;
		}
}
-(void)drawPOI:(MapFeature*)featureObject withPosition:(CGPoint)point withPointType:(NSInteger)pointType{
	if(point.x<0 || point.y<0) return;
	MapPoint *styleObject=(MapPoint*)featureObject.styleObject;
	CGSize picSize;
	CGRect spriteRect;
	switch (pointType) {
		case regionPointType:
			picSize=imageSizeArray[styleObject.bmpId];
			spriteRect=CGRectMake(point.x-picSize.width/2, point.y, picSize.width, picSize.height-10);
			[DrawFunctions createAndDrawBitmapImage:mapContextRef withRect:spriteRect withImageRef:imageRefArray[styleObject.bmpId] withTitle:nil withTitleSize:CGSizeZero withTitleYAxisInsect:0];
			 
			break;
		case pointPointType:
			//記錄yValue,以利排序
			featureObject.yValue=([[featureObject.drawingArray objectAtIndex:0]CGPointValue]).y;
			[pointArray addObject:featureObject];
			break;
		default:
			break;
	}
}
-(void)loadTreeImage{
	for(int i=0;i<10;i++){
		NSString *num=((i+1)>9)?[NSString stringWithFormat:@"%i",i+1]:[NSString stringWithFormat:@"0%i",i+1];
		NSString *fileName=[NSString stringWithFormat:@"mapui_icon_tree_%@",num];
		NSString *path = [[ NSBundle mainBundle ] pathForResource:fileName ofType:@"png"];
		CGDataProviderRef provider; 
		CFStringRef cfPath; 
		CFURLRef url; 
		cfPath = CFStringCreateWithCString (NULL, [path UTF8String], kCFStringEncodingUTF8); 
		url = CFURLCreateWithFileSystemPath (NULL, cfPath, 
											 kCFURLPOSIXPathStyle, NO); 
		provider = CGDataProviderCreateWithURL (url); 
		
		imageRefArray[i]=CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentAbsoluteColorimetric);

		CFRelease(cfPath); 
		CFRelease (url); 
		CGDataProviderRelease (provider); 
		
		imageSizeArray[i]=[self getAllTreeImageSize:i];
	}
}
-(void)releaseTreeImage{
	for(int num=0;num<10;num++){
		CGImageRelease(imageRefArray[num]);
	}
}
-(CGSize)getAllTreeImageSize:(NSInteger)imageIndex{
	CGSize returnSize;
	switch (imageIndex) {
		case 0:
		case 1:
			returnSize=CGSizeMake(41,50);
			break;
		case 2:
			returnSize=CGSizeMake(32, 36);
			break;
		case 3:
			returnSize=CGSizeMake(43, 25);
			break;
		case 4:
			returnSize=CGSizeMake(31, 42);
			break;
		case 5:
			returnSize=CGSizeMake(32, 40);
			break;
		case 6:
			returnSize=CGSizeMake(19, 27);
			break;
		case 7:
			returnSize=CGSizeMake(27, 33);
			break;
		case 8:
			returnSize=CGSizeMake(25, 35);
			break;
		case 9:
			returnSize=CGSizeMake(19, 23);
			break;
	}
	return returnSize;
}
@end
