//
//  SettingView.h
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParametersObject.h"

@interface SettingView : UIViewController <UITextFieldDelegate>{
	BOOL isOpen;
	UITextField *selectedTextField;
	
	IBOutlet UIImageView *arrowImageView;
	ParametersObject *selectedParameters;
	
	IBOutlet UITextField 
	*presidentATotalText,*presidentAEachText,
	*presidentBTotalText,*presidentBEachText,
	*presidentCTotalText,*presidentCEachText,
	*presidentDTotalText,*presidentDEachText;
	
	IBOutlet UITextField
	*managerATotalText,*managerAEachText,
	*managerBTotalText,*managerBEachText,
	*managerCTotalText,*managerCEachText,
	*managerDTotalText,*managerDEachText;
	
	IBOutlet UITextField
	*firstPriceATotalText,*firstPriceAEachText,
	*firstPriceBTotalText,*firstPriceBEachText,
	*firstPriceCTotalText,*firstPriceCEachText,
	*firstPriceDTotalText,*firstPriceDEachText;
	
	IBOutlet UITextField
	*bonusPriceATotalText,*bonusPriceAEachText,
	*bonusPriceBTotalText,*bonusPriceBEachText,
	*bonusPriceCTotalText,*bonusPriceCEachText,
	*bonusPriceDTotalText,*bonusPriceDEachText,*bonusPriceNameText;
	
	
}
@property(nonatomic)BOOL isOpen;
@property(nonatomic,retain)ParametersObject *selectedParameters;
@property(nonatomic,retain)UIImageView *arrowImageView;
@property(nonatomic,retain)UITextField 
*presidentATotalText,*presidentAEachText,
*presidentBTotalText,*presidentBEachText,
*presidentCTotalText,*presidentCEachText,
*presidentDTotalText,*presidentDEachText,
*managerATotalText,*managerAEachText,
*managerBTotalText,*managerBEachText,
*managerCTotalText,*managerCEachText,
*managerDTotalText,*managerDEachText,
*firstPriceATotalText,*firstPriceAEachText,
*firstPriceBTotalText,*firstPriceBEachText,
*firstPriceCTotalText,*firstPriceCEachText,
*firstPriceDTotalText,*firstPriceDEachText,
*bonusPriceATotalText,*bonusPriceAEachText,
*bonusPriceBTotalText,*bonusPriceBEachText,
*bonusPriceCTotalText,*bonusPriceCEachText,
*bonusPriceDTotalText,*bonusPriceDEachText,*bonusPriceNameText;
-(IBAction)touchSlideAction:(id)sender;
-(IBAction)presidenPriceAcquire:(id)sender;
-(IBAction)managerPriceAcquire:(id)sender;
-(IBAction)firstPriceAcquire:(id)sender;
-(IBAction)bonusPriceAcquire:(id)sender;
-(void)slideAnimation;
@end
