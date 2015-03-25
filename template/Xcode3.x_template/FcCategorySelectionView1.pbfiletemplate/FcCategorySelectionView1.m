    //
//  CategorySelectionView.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcCategorySelectionView1.h"
@interface FcCategorySelectionView1 (PrivateMethod)

@end

@implementation FcCategorySelectionView1
@synthesize searchBtn,cancelBtn,titleLabel,picker,titleBackground,bottomBackground;
#pragma mark Developer Override
//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//multi-language
	[searchBtn setTitle:AMLocalizedString(<#填入字串#>,nil) forState:UIControlStateNormal];
	[cancelBtn setTitle:AMLocalizedString(<#填入字串#>,nil) forState:UIControlStateNormal];
	[titleLabel setText:AMLocalizedString(<#填入字串#>,nil)];
	[searchBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[cancelBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[searchBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
	[cancelBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];

	[titleBackground setImage:[UIImage imageNamed:<#填入圖片名稱#>]];
	//[bottomBackground setImage:[UIImage imageNamed:@""]];
	
}

-(void)loadAllCategory{
	//fill your accquiring data process.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return <#滾輪段數#>;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return <#每段中擁有幾個選擇個數#>;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return <#每個選擇回應之文字#>;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	//process after you doing selecting.
}

-(IBAction)searchAction:(id)sender{
	//fill your searching process.
	[self cancel:sender];
}
#pragma mark -
#pragma mark LifeCycle
-(void)viewDidLoad{
	[super viewDidLoad];
	mCategoryDic=[[NSMutableDictionary alloc]init];
	sCategoryDic=[[NSMutableDictionary alloc]init];
	[self loadAllCategory];
	[self EnvelopSuit];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark DelegateMethod
-(IBAction)cancel:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}
#pragma mark -
#pragma mark PrivateMethod
//write your own method here.
#pragma mark -
@end
