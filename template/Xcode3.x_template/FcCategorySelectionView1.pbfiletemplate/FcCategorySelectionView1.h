//
//  CategorySelectionView.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcCategorySelectionView1 : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>{
	IBOutlet UILabel *titleLabel;
	IBOutlet UIPickerView *picker;
	IBOutlet UIButton *searchBtn;
	IBOutlet UIButton *cancelBtn;
	IBOutlet UIImageView *titleBackground;
	IBOutlet UIImageView *bottomBackground;
}
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *searchBtn,*cancelBtn;
@property(nonatomic,retain)UIPickerView *picker;
@property(nonatomic,retain)UIImageView *bottomBackground,*titleBackground;
-(void)EnvelopSuit;
-(IBAction)searchAction:(id)sender;
-(IBAction)cancel:(id)sender;
@end
