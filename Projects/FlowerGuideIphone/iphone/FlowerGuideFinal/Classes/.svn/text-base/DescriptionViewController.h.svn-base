//
//  DescriptionViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController {
	IBOutlet UIScrollView *thisScrollView;
	IBOutlet UILabel *titleLabel;
	//欲顯示之資料,title,content為一個pair之資料結構
	NSMutableArray *dataStringArray;
	//顯示之UI
	NSMutableArray *uiArray;
	NSString *titleString;
	//給予y值高度,從此高度開始自動排列
	int startY;
	int textWidth;
	int startX;
}
@property(nonatomic,retain)UIScrollView *thisScrollView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)NSMutableArray *dataStringArray;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic)int startX,startY,textWidth;
-(id)initWithDefaultStartY;
-(id)initWithYValue:(NSInteger)yValue withXValue:(NSInteger)xValue withTextWidth:(NSInteger)width;
-(UILabel*)getTitleLabel:(NSString*)stringText;
-(UILabel*)getContentText:(NSString*)stringText;
-(void)constructThisPage;
@end
