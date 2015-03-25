//
//  CompareView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/25.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcProductButtonView1.h"

@interface CompareView : UIViewController {
    @public
    IBOutlet UIView *itemView1;
    IBOutlet UIView *itemView2;
    IBOutlet UIView *itemView3;
    IBOutlet UIView *itemView4;
    IBOutlet UIView *contentView;
    
    @private
    IBOutlet UITextView *itemText1;
    IBOutlet UITextView *itemText2;
    IBOutlet UITextView *itemText3;
    IBOutlet UITextView *itemText4;
    
    IBOutlet UIButton *itemBtn1;
    IBOutlet UIButton *itemBtn2;
    IBOutlet UIButton *itemBtn3;
    IBOutlet UIButton *itemBtn4;
    
    IBOutlet UIImageView *itemImageView1;
    IBOutlet UIImageView *itemImageView2;
    IBOutlet UIImageView *itemImageView3;
    IBOutlet UIImageView *itemImageView4;
    NSMutableArray *dataArray;
    NSMutableArray *viewsArray;
    NSArray *textArray;
}
@property(nonatomic,retain)UIView *itemView1,*itemView2,*itemView3,*itemView4,*contentView;
@property(nonatomic,retain)UITextView *itemText1,*itemText2,*itemText3,*itemText4;
@property(nonatomic,retain)UIButton *itemBtn1,*itemBtn2,*itemBtn3,*itemBtn4;
@property(nonatomic,retain)UIImageView *itemImageView1,*itemImageView2,*itemImageView3,*itemImageView4;

-(IBAction)removeItem1:(id)sender;
-(IBAction)removeItem2:(id)sender;
-(IBAction)removeItem3:(id)sender;
-(IBAction)removeItem4:(id)sender;

-(IBAction)shiftViewPosition;
-(void)addCompareProduct:(NSNotification*)notification;
-(void)refreshComparePanel:(NSInteger)numof;
@end
