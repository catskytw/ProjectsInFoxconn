//
//  FcPopWindows.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/15.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ClosePopWindow @"ClosePopWindow"

@interface FcPopWindows : UIViewController {
    IBOutlet UIView *windowView;
    IBOutlet UIView *contentView;
    IBOutlet UIButton *closeBtn;
    IBOutlet UIImageView *frameImage;
    
    @private
    UIViewController *_contentController;
    CGSize _contentSize;
    CGPoint _framePosition;
    NSString *_closeBtnString;
    BOOL _allowClose;
    BOOL _isMenu;
}
@property(nonatomic,retain)UIView *windowsView,*contentView;
@property(nonatomic,retain)UIButton *closeBtn;
@property(nonatomic,retain)UIImageView *frameImage;

-(IBAction)close;
-(id)initWithInnerFrame:(CGSize)contentSize withPosition:(CGPoint)position  withContentViewController:(UIViewController*)contentController withCloseBtnString:(NSString*)closeString isAllowedClose:(BOOL)allowed;
-(id)initWithInnerFrame:(CGSize)contentSize withPosition:(CGPoint)position  withContentViewController:(UIViewController*)contentController withCloseBtnString:(NSString*)closeString isAllowedClose:(BOOL)allowed isMenu:(BOOL)bMenu;
-(void)show:(UIView*)parentView;
-(void)initialDelayEnded ;
- (IBAction)touchOutsidePop:(id)sender;
- (void)setMenuFrameimage;
@end
