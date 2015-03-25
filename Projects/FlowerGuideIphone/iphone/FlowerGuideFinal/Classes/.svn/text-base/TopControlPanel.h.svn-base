//
//  TopControlPanel.h
//  FlowerGuide
//
//  Created by Change Liao on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionInfoObject.h"

@interface TopControlPanel : UIViewController <UIActionSheetDelegate>{
	BOOL isOpen,isForwardingMode;
	IBOutlet UIButton *switchBtn,*ptNameBtn,*ptDescBtn,*flowerBtn;
	IBOutlet UIImageView *directionPointer;
	IBOutlet UILabel *distanceLabel;
	IBOutlet UIButton *forwardBtn,*cancelBtn;
	//目前所在點位
	NSInteger nowPositionId;
	ExhibitionInfoObject *tmpDataObject;
}
@property(nonatomic,retain)UIButton *switchBtn,*ptNameBtn,*ptDescBtn,*flowerBtn,*forwardBtn,*cancelBtn;
@property(nonatomic,retain)UIImageView *directionPointer;
@property(nonatomic,retain)UILabel *distanceLabel;
@property(nonatomic)BOOL isForwardingMode;
@property(nonatomic)NSInteger nowPositionId;
-(IBAction)switchPanel:(id)sender;
-(IBAction)openContentView:(id)sender;
-(IBAction)openFlowerArea:(id)sender;
-(IBAction)openTest:(id)sender;
-(IBAction)openFeatureDesc:(id)sender;
-(void)changeDirectionPointer:(NSInteger)direction;
-(void)changeValue:(ExhibitionInfoObject*)dataObject;
-(void)switchContentMode;
-(IBAction)forwardAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(void)setButtonEnable;
-(void)setButtonDisable;
@end
