//
//  PlaceConfirmPopWindow.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceConfirmPopWindow.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "LocationInfoObject.h"
#import "LocalizationSystem.h"
@implementation PlaceConfirmPopWindow
@synthesize guideTitle,confirmBtn,correctLabel,qrcodeBtn,place;
-(void)viewDidLoad{
    [super viewDidLoad];
    [confirmBtn setBackgroundImage:[TUNinePatchCache imageOfSize:confirmBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[TUNinePatchCache imageOfSize:confirmBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [qrcodeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:qrcodeBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [qrcodeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:qrcodeBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [place setText:[LocationInfoObject nowPosition].name];
    [guideTitle setText:AMLocalizedString(@"導引起點: 目前位置",nil)];
    //[place setText:AMLocalizedString(@"地點名稱",nil)];
    [correctLabel setText:AMLocalizedString(@"是否正確？",nil)];
    [confirmBtn setTitle:AMLocalizedString(@"是的",nil) forState:UIControlStateNormal];
    [qrcodeBtn setTitle:AMLocalizedString(@"不是,請刷附近QRCode",nil) forState:UIControlStateNormal];
}
-(IBAction)confirmAction:(id)sender{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] postNotificationName:MAKE_ROUTEING object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil userInfo:nil];
}
-(IBAction)qrcodeAction:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:CLEAR_PLACE_CONFIRM_WINDOW object:nil userInfo:nil];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    [dic setValue:@"2" forKey:@"tabIndex"];
    [dic setValue:@"5" forKey:@"functionType"];
    [[NSNotificationCenter defaultCenter]postNotificationName:CHANGE_TAB object:nil userInfo:dic];
}
@end
