//
//  DescriptionViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloraExpoDescriptionController.h"

@interface DescriptionViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIScrollView *thisScrollView;
	FloraExpoDescriptionController *fedc;
	NSString *thisDescriptionKey;
	
	//欲顯示之資料,title,content為一個pair之資料結構
	NSMutableArray *dataStringArray;
	//顯示之UI
	NSMutableArray *uiArray;
	NSString *titleString;
	//給予y值高度,從此高度開始自動排列
	int startY;
}
@property(nonatomic,retain)UIScrollView *thisScrollView;
@property(nonatomic,retain)NSMutableArray *dataStringArray;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic)int startY;
-(id)initWithDescriptionKey:(NSString*)key;
-(id)initWithDefaultStartY;
-(UILabel*)getTitleLabel:(NSString*)stringText;
-(UILabel*)getContentText:(NSString*)stringText;
-(UIWebView*)getWebView:(NSString*)stringText;
-(void)constructThisPage;
@end