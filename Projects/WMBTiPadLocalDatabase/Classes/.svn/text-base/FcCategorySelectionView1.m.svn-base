    //
//  CategorySelectionView.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcCategorySelectionView1.h"
#import "AllCategoryObject.h"
#import "Configure.h"
#import "LocalizationSystem.h"
@interface FcCategorySelectionView1 (PrivateMethod)
-(void)resetSubSelectedKey:(NSString*)key;
-(void)resetMainSelectedName:(NSString*)key;
-(void)resetSubSelectedName:(NSString*)key;
@end

@implementation FcCategorySelectionView1
@synthesize searchBtn,cancelBtn,titleLabel,picker,titleBackground,bottomBackground;
@synthesize sCategoryDic,mCategoryDic;
@synthesize contentView;
#pragma mark Developer Override
//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//multi-language
    
	[searchBtn setTitle:AMLocalizedString(@"Search",nil) forState:UIControlStateNormal];
	[cancelBtn setTitle:AMLocalizedString(@"Cancel",nil) forState:UIControlStateNormal];
	[titleLabel setText:AMLocalizedString(@"ProductSearch",nil)];
	[searchBtn setBackgroundImage:[TUNinePatchCache imageOfSize:searchBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
	[cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:searchBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
	[searchBtn setBackgroundImage:[TUNinePatchCache imageOfSize:searchBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
	[cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:searchBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];

	[titleBackground setImage:[UIImage imageNamed:@"content_ui_windows_title_bar.png"]];
	[bottomBackground setImage:[UIImage imageNamed:@"content_ui_windows_title_underbar.png"]];
	
}

-(void)loadAllCategory{
    mCategoryDic=[AllCategoryObject share].m_MDic;
    sCategoryDic=[AllCategoryObject share].m_SDic;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger number=0;
	if(component==0){
		number=[mCategoryDic count];
	}else if([mCategoryDic count]>0){
		NSString *key=[[AllCategoryObject share].orderKeys objectAtIndex:mainSelectedIndex];
		NSDictionary *subDic=(NSDictionary*)[sCategoryDic valueForKey:key];//bug?
		number=[subDic count];
	}
	return number;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString=@"";
	if(component==0){
		NSString *key=[[AllCategoryObject share].orderKeys objectAtIndex:row];
		//thisResponseString=(NSString*)[[mCategoryDic allValues] objectAtIndex:row];
		thisResponseString=[mCategoryDic valueForKey:key];
	}else{
		NSString *key=[[AllCategoryObject share].orderKeys objectAtIndex:mainSelectedIndex];
		NSDictionary *subDic=(NSDictionary*)[sCategoryDic valueForKey:key];
        NSArray *tmpArray=[subDic allKeys];
		NSString *subKey=[tmpArray objectAtIndex:row];
		thisResponseString=(NSString*)[subDic valueForKey:subKey];
	}
	return thisResponseString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	int first=[pickerView selectedRowInComponent:0];
	int second=[pickerView selectedRowInComponent:1];
	
	if(first!=mainSelectedIndex){
		mainSelectedIndex=first;
		second=0;
		[pickerView reloadComponent:1];
		[pickerView selectRow:second inComponent:1 animated:YES]; 
	}
	NSString *mainKey=[[AllCategoryObject share].orderKeys objectAtIndex:mainSelectedIndex];
	NSDictionary *subDictionary= (NSDictionary*)[sCategoryDic valueForKey:mainKey];
	if((NSNull*)subDictionary==[NSNull null])
		NSLog(@"ns null");
    //if([subDictionary count]>0)
        //NSLog(@"subDictionaryKey %@",[[subDictionary allKeys]objectAtIndex:second]);
	NSString *subKey=([subDictionary count]>0)?(NSString*)[[subDictionary allKeys]objectAtIndex:second]:@"";
	
	[self resetSubSelectedKey:subKey];
	[self resetMainSelectedName:(NSString*)[mCategoryDic valueForKey:mainKey]];
	[self resetSubSelectedName:(NSString*)[subDictionary valueForKey:subKey]];
}

-(IBAction)searchAction:(id)sender{
	NSMutableDictionary *notificationDic=[NSMutableDictionary dictionary];
	/*
	 NSString *sKey=(NSString*)[dataDic valueForKey:@"subCategoryKey"];
	 NSNumber *type=(NSNumber*)[dataDic valueForKey:@"sortType"];
	 */
	[notificationDic setValue:subSelectedKey forKey:@"subCategoryKey"];
	[notificationDic setValue:[NSNumber numberWithInt:1] forKey:@"sortType"];
	[notificationDic setValue:mainSelectedName forKey:@"mainName"];
	[notificationDic setValue:subSelectedName forKey:@"subName"];
	[[NSNotificationCenter defaultCenter]postNotificationName:CatalogTemplateNotification object:nil userInfo:notificationDic];
    [[NSNotificationCenter defaultCenter]postNotificationName:dismissPopover object:nil userInfo:nil];
}
#pragma mark -
#pragma mark LifeCycle
-(void)viewDidLoad{
	[super viewDidLoad];
	[self loadAllCategory];
	[self EnvelopSuit];
	mainSelectedIndex=0;
    NSString *initMainKey;
	if([[mCategoryDic allKeys]count]>0){
        initMainKey=(NSString*)[[mCategoryDic allKeys]objectAtIndex:0];
        mainSelectedName=[mCategoryDic valueForKey:initMainKey];
    }
	if([[sCategoryDic allKeys]count]>0){
        NSDictionary *tmpDic=(NSDictionary*)[sCategoryDic valueForKey:initMainKey];
        subSelectedKey=(NSString*)[[tmpDic allKeys]objectAtIndex:0];
		subSelectedName=(NSString*)[tmpDic valueForKey:subSelectedKey];
    }
}
- (void)viewDidUnload {
    [super viewDidUnload];
	if(mainSelectedName!=nil)
		[mainSelectedName release];
	if(subSelectedName!=nil)
		[subSelectedName release];
	if(subSelectedKey!=nil)
		[subSelectedKey release];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark DelegateMethod
-(IBAction)cancel:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:dismissPopover object:nil userInfo:nil];
}
#pragma mark -
#pragma mark PrivateMethod
-(void)resetSubSelectedKey:(NSString*)key{
	if(subSelectedKey!=nil)
		[subSelectedKey release];
	subSelectedKey=[[NSString stringWithFormat:@"%@",key]retain];
}

-(void)resetMainSelectedName:(NSString*)key{
	if(mainSelectedName!=nil)
		[mainSelectedName release];
	mainSelectedName=[[NSString stringWithFormat:@"%@",key]retain];
}
-(void)resetSubSelectedName:(NSString*)key{
	if(subSelectedName!=nil)
		[subSelectedName release];
	subSelectedName=[[NSString stringWithFormat:@"%@",key]retain];
}
#pragma mark -
@end
