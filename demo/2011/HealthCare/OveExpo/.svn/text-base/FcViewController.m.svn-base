//
//  FcViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcViewController.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "FcUIBarButtonItem.h"
#import "Tools.h"
#import "FcDrawing.h"
#import "UITuneLayout.h"
@interface FcViewController(PrivateMethod)
@end
@implementation FcViewController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUIDefault];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [TUNinePatchCache flushCache];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma -

#pragma mark - ActionMethod
-(void)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemAction:(id)sender{
    
}
-(void)leftItemAction:(id)sender{
    
}
#pragma -
#pragma mark - Layout
-(void)setBackItem:(NSString*)btnTitle{
    CGSize _stringSize=[Tools estimateStringSize:btnTitle withFontSize:14.0f withMaxSize:ccs(70, 32)];
    UIImage *normalImage=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_back"];
    UIImage *highLight=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_back_i"];
    UIBarButtonItem *backItem=[UIBarButtonItem backBarItemWithImage:normalImage withHighlightImage:highLight target:self action:@selector(goBack:) withTitle:btnTitle];
    self.navigationItem.leftBarButtonItem=backItem;
}

-(void)setLeftItem:(NSString*)btnTitle{
    CGSize _stringSize=[Tools estimateStringSize:btnTitle withFontSize:14.0f withMaxSize:ccs(70, 32)];
    UIImage *normalImage=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title"];
    UIImage *highLight=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title_i"];
    UIBarButtonItem *backItem=[UIBarButtonItem backBarItemWithImage:normalImage withHighlightImage:highLight target:self action:@selector(leftItemAction:) withTitle:btnTitle];
    self.navigationItem.leftBarButtonItem=backItem;
}

-(void)setRightItemWithPic:(NSString*)normalPic withHighlightPic:(NSString*)highLightPic{
    UIImage *normalImage=[FcDrawing loadUIImage:normalPic withType:@"png"];
    UIImage *highLight=[FcDrawing loadUIImage:highLightPic withType:@"png"];
    
    UIBarButtonItem *backItem=[UIBarButtonItem rightBarItemWithImage:normalImage withHighlightImage:highLight target:self action:@selector(rightItemAction:) withTitle:@""];
    self.navigationItem.rightBarButtonItem=backItem;
}
-(void)setRightItem:(NSString*)btnTitle{
    CGSize _stringSize=[Tools estimateStringSize:btnTitle withFontSize:14.0f withMaxSize:ccs(70, 32)];
    UIImage *normalImage=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title"];
    UIImage *highLight=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title_i"];
    UIBarButtonItem *backItem=[UIBarButtonItem rightBarItemWithImage:normalImage withHighlightImage:highLight target:self action:@selector(rightItemAction:) withTitle:btnTitle];
    self.navigationItem.rightBarButtonItem=backItem;
}
-(void)setRightItem2:(NSString*)btnTitle{
    CGSize _stringSize=[Tools estimateStringSize:btnTitle withFontSize:14.0f withMaxSize:ccs(70, 32)];
    UIImage *normalImage=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title_2"];
    UIImage *highLight=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:@"btn_title_2_i"];
    UIBarButtonItem *backItem=[UIBarButtonItem rightBarItemWithImage:normalImage withHighlightImage:highLight target:self action:@selector(rightItemAction:) withTitle:btnTitle];
    self.navigationItem.rightBarButtonItem=backItem;
}

-(void) setUIDefault{
    self.navigationController.navigationBarHidden=NO;
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
}

-(void)settingBtnStyle:(UIButton*)_targetBtn{
    [_targetBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:_targetBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [_targetBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:_targetBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [_targetBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
}
#pragma -
@end
