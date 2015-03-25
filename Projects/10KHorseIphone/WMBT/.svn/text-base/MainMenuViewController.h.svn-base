//
//  MainMenuViewController.h
//  WMBT
//
//  Created by link on 2011/2/25.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizationSystem.h"
//請依規格定義下列資料
#pragma mark Developer Override
#define menuIconMarginX 24 //定義icon初始 x
#define menuIconMarginY 13 //定義icon初始 y
#define menuIconWidth 76 //定義icon 寬
#define menuIconHeight 76//定義icon 高
#define menuIconBetweenX 22 //定義icon x 間距
#define menuIconBetweenY 4 //定義icon 與下方文字 間距
#define menuIconCntLine 3 //定義每行icon數
#define menuIconTextFont 14 //定義font的size
#define menuIconTextBetweenY 9 //定義文字與下行icon的間距
#define scrollViewWidth 360 //定義scroll view 寬度
#define scrollViewHeight 480 //定義scroll view 高度

@interface MainMenuViewController : UIViewController {
	IBOutlet UIScrollView *scrollView;
	NSMutableArray *menuArray;
	NSMutableArray *menuPathArray;
    id mainController;
}
@property(nonatomic,retain)id mainNavigation;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)id mainController;
-(void) setUpMenusWithString:(NSArray*)MenuArray andPathArray:(NSArray*)pathArray;
-(void) menuAction:(NSString*) menuName;
-(void) setNaviTitle: (id)controller;
@end

