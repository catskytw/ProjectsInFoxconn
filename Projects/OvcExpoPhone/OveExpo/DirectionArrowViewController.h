//
//  DirectionArrowViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface DirectionArrowViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>{
	IBOutlet UIView *mainView;
	NSDictionary *arrowContentArray;
    
    IBOutlet UIView *selectTargetView;
    IBOutlet UIButton *cancelSelectBtn;
    IBOutlet UIButton *completeSelectBtn;
    IBOutlet UIImageView *selectTitleImageView;
    IBOutlet UIPickerView *pointPicker;
    IBOutlet UIImageView *personView;
    BOOL allowArrowTouch;
    
    //datastruct
    NSMutableArray *pickerData;
    BOOL isOpenSelectView;
    NSInteger selectedIndex;
    MapViewController *_preMapViewController;
}
@property(nonatomic,retain)UIView *mainView,*selectTargetView;
@property(nonatomic,retain)UIButton *cancelSelectBtn,*completeSelectBtn;
@property(nonatomic,retain)UIImageView *selectTitleImageView,*personView;
@property(nonatomic,retain)UIPickerView *pointPicker;
@property(nonatomic,assign)MapViewController *_preMapViewController;
-(void)drawDirectionArrow:(CGRect)rangRect withStandingPosition:(CGPoint)standPoint;
-(IBAction)closeThisView:(id)sender;
-(IBAction)pressArrow:(id)sender;
-(IBAction)cancelAction:(id)sender;
-(IBAction)completeAction:(id)sender;
@end
