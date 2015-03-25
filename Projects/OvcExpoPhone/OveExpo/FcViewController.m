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
@interface FcViewController(PrivateMethod)

@end
@implementation FcViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [TUNinePatchCache flushCache];
    // Release any cached data, images, etc that aren't in use.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
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

-(void)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemAction:(id)sender{
    
}
-(void)leftItemAction:(id)sender{
    
}
@end
