//
//  FlowerAreaGallery.h
//  FlowerGuide
//
//  Created by Liao Change on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowerAreaObject.h"
@interface FlowerAreaGallery : UIViewController<UIScrollViewDelegate> {
	IBOutlet UIScrollView *scrollBar;
	IBOutlet UIImageView *mapView;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIScrollView *backgroundScrollView;
	//地圖上之按鍵
	NSMutableArray *allMapButton;
	//下方所有圖片按鍵
	NSMutableArray *allBottomButton;
	//目前是哪個按鍵之index
	int currentNum;
	//每個按鍵的寬度
	int buttonWidth;
	//每個按鍵的間隔
	int space;

	//資料物件
	FlowerAreaObject *thisDataObject;
	NSString *areaId;
}
@property(nonatomic,retain)UIScrollView *scrollBar,*backgroundScrollView;
@property(nonatomic,retain)UIView *mapView;
@property(nonatomic,retain)UILabel *titleLabel;
-(id)initWithFeatureId:(NSString*)inputAreaId;
-(void)addButtonAndFlowerPoint;
-(void)bounceToCurrentPosition:(int)currentPositionNum;
-(void)addButtonEffect:(UIButton*)thisButton;
-(void)delButtonEffect:(UIButton*)thisButton;
-(IBAction)exit:(id)sender;
@end
