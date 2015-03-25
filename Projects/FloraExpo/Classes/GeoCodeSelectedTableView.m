//
//  GeoCodeSelectedTableView.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GeoCodeSelectedTableView.h"
#import "BSKmlResult.h"
#import "POI.h"
#import "Vars.h"

@implementation GeoCodeSelectedTableView
@synthesize geoCodeSelectedTable;
@synthesize contentArray;
@synthesize parentMapView;

-(id)initWithGeoCodeArray:(NSArray*)geoCodeArray{
	if((self=[super initWithTitle:AMLocalizedString(@"PleaseChoosePlace",nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:AMLocalizedString(@"Choose",nil),AMLocalizedString(@"Cancel",nil),nil])){
		contentArray=[[NSArray arrayWithArray:geoCodeArray]retain];
		geoCodeTable=[[UITableView alloc]initWithFrame:CGRectMake(10, 115, 264, 200)];
		geoCodeTable.dataSource=self;
		geoCodeTable.delegate=self;
		[geoCodeTable setBackgroundColor:[UIColor clearColor]];
		selectedIndex=-1;
		parentMapView=nil;
	}
	return self;
}
- (void)willPresentAlertView:(UIAlertView *)alertView{

	self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y-100, self.frame.size.width, self.frame.size.height+235);
	[self addSubview:geoCodeTable];
	
}
-(void)dealloc{
	[contentArray release];
	[super dealloc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeMedium;
	
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int row=[indexPath row];
	UITableViewCell *thisCell=[tableView dequeueReusableCellWithIdentifier:@"geocodecell"];
	if(thisCell==nil){
		thisCell=[[[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:@"geocodecell"]autorelease];
		//[thisCell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	BSKmlResult *thisResult=(BSKmlResult*)[contentArray objectAtIndex:row];
	NSArray *componentArray=[[thisResult.addressComponents reverseObjectEnumerator]allObjects];
	NSMutableString *detailAddress=[NSMutableString new];
	for(BSAddressComponent *myComponent in componentArray){
		[detailAddress appendString:myComponent.longName];
	}
	thisCell.textLabel.text=detailAddress;
	[thisCell.textLabel setTextColor:[UIColor whiteColor]];
	[thisCell.textLabel setNumberOfLines:5];
	
	return thisCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	selectedIndex=[indexPath row];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	//按了選擇,且下方的table有選擇
	if(buttonIndex==0 && selectedIndex!=-1){
		BSKmlResult *thisPoint=(BSKmlResult*)[contentArray objectAtIndex:selectedIndex];
		CLLocationCoordinate2D center={thisPoint.latitude,thisPoint.longitude};
		MKCoordinateRegion myRegion={center,{0.004,0.004}};
		if(parentMapView!=nil){
			//移到中心點位
			[parentMapView setRegion:myRegion animated:YES];
			//[parentMapView setCenterCoordinate:center animated:YES];
			//加annotation
			POI *mainPosition=[[[POI alloc]initWithCoords:center withTitle:@"" withSubTitle:@""]autorelease];
			mainPosition.poiType=poiMainPositionType;
			[parentMapView addAnnotation:mainPosition];
		}
	}
}
@end
