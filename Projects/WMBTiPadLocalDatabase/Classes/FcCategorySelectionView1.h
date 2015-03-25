//
//  CategorySelectionView.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcCategorySelectionView1 : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>{
	IBOutlet UIView *contentView;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIPickerView *picker;
	IBOutlet UIButton *searchBtn;
	IBOutlet UIButton *cancelBtn;
	IBOutlet UIImageView *titleBackground;
	IBOutlet UIImageView *bottomBackground;
	
	NSMutableDictionary *mCategoryDic;
	NSMutableDictionary *sCategoryDic;
	
	//output message
	NSInteger mainSelectedIndex;
	NSString *subSelectedKey;
	NSString *mainSelectedName;
	NSString *subSelectedName;
}
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *searchBtn,*cancelBtn;
@property(nonatomic,retain)UIPickerView *picker;
@property(nonatomic,retain)UIImageView *bottomBackground,*titleBackground;
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,retain)NSMutableDictionary *mCategoryDic,*sCategoryDic;
-(void)EnvelopSuit;
-(IBAction)searchAction:(id)sender;
-(IBAction)cancel:(id)sender;
@end
