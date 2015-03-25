//
//  Tools.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Tools.h"
#import "Configure.h"
#import "SignInObject.h"
#import "FcPopWindows.h"
#import "LocalizationSystem.h"
static UIView *waitView;
@implementation Tools
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize{
	CGSize maxSize=CGSizeMake(768, fontSize);
	return [examString sizeWithFont:[UIFont fontWithName:DefaultFontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize{
	return [examString sizeWithFont:[UIFont fontWithName:DefaultFontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize withFontName:(NSString*)fontName{
	return [examString sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(NSString*)getProductListString:(NSString*)sKey withSortType:(NSString*)sortString withBrand:(NSString*)brandString withColor:(NSString*)colorString withPrice:(NSString*)priceString{
    //[NSString stringWithFormat:@"%@getProductList?productTypeId=%@&sortType=%@&productBrandId=%@&productColorId=%@&productPrice=%@",ProductServicePrefix,sKey,sortType,brandId,colorId,priceRange]
    NSString *basicProductListString=[[NSString stringWithFormat:@"%@getProductList%@&productTypeId=%@&sortType=%@",ProductServicePrefix,withSessionId,sKey,sortString]retain];
    
    if((NSNull *)brandString!=[NSNull null])
       basicProductListString=[basicProductListString stringByAppendingFormat:@"&productBrandId=%@",brandString];
    if((NSNull *)colorString!=[NSNull null])
        basicProductListString=[basicProductListString stringByAppendingFormat:@"&productColor=%@",colorString];
    if((NSNull *)priceString!=[NSNull null])
        basicProductListString=[basicProductListString stringByAppendingFormat:@"&productPrice=%@",priceString];
    return basicProductListString;
}
+(UIColor*)convertString2UIColor:(NSString*)colorString{
    //the colorString's syntax: #ffffff
    if([colorString isEqualToString:@"-"])
        return [UIColor clearColor];
    unsigned r=0,g=0,b=0;
    NSScanner *scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&r];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&g];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&b];
    return [UIColor colorWithRed:(CGFloat)r/255.0f green:(CGFloat)g/255.0f blue:(CGFloat)b/255.0f alpha:1];
}
+(NSString*)formatMoneyString:(NSString*)moneyString{
    NSString *rString;
    rString=[NSString stringWithFormat:@"%@ %.1f",coinIdentify,[moneyString floatValue]];
    return rString;
}
+(NSString*)urlEncoding:(NSString*)url{
    NSString *r=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return r;
}

+(void)FcMessageWindows:(NSString*)contentString withParentView:(UIView*)parentView{
    UIViewController *_controller=[[UIViewController alloc]init];
    UILabel *contentView=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 260, 200)];
    contentView.text=contentString;
    contentView.textAlignment=UITextAlignmentCenter;
    [contentView setFont:[UIFont fontWithName:DefaultFontName size:18.0f]];
    [contentView setBackgroundColor:[UIColor clearColor]];
    CGSize stringSize=[Tools estimateStringSize:contentString withFontSize:18.0f withMaxSize:contentView.frame.size];
    [contentView setFrame:CGRectMake(20, 20, stringSize.width,stringSize.height)];
    [_controller.view setFrame:CGRectMake(0, 0, 300, stringSize.height+30)];
    [_controller.view addSubview:contentView];
    FcPopWindows *popWin=[[FcPopWindows alloc] initWithInnerFrame:_controller.view.frame.size withPosition:CGPointMake(234,215) withContentViewController:[_controller autorelease] withCloseBtnString:nil isAllowedClose:YES];
    [popWin show:parentView];
    [contentView autorelease];
}
+(void)runWaitCursor{
    NSAutoreleasePool *cursorPool=[[NSAutoreleasePool alloc] init];
	waitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
	[waitView setUserInteractionEnabled:YES];
	[waitView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
	
	UIActivityIndicatorView *waitCursor=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 32, 32)]autorelease];
	[waitCursor setCenter:CGPointMake(384,408)];
	[waitCursor setHidesWhenStopped:YES];
	[waitCursor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[waitCursor startAnimating];
	[waitView addSubview:waitCursor];
	
	UILabel *waitLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)]autorelease];
	[waitLabel setCenter:CGPointMake(384,380)];
	[waitLabel setText:AMLocalizedString(@"PleaseWait",nil)];
	[waitLabel setTextColor:[UIColor whiteColor]];
	[waitLabel setTextAlignment:UITextAlignmentCenter];
	[waitLabel setBackgroundColor:[UIColor clearColor]];
	[waitView addSubview:waitLabel];
	[waitView setTag:1000];
    [((UIViewController*)[[UIApplication sharedApplication] delegate]).tabBarController.view addSubview:waitView];
	[cursorPool release];
}
+(void)addWaitCursor{
    if(waitView!=nil)
        return;
    [NSThread detachNewThreadSelector:@selector(runWaitCursor) toTarget:[Tools class] withObject:nil];
}
+(void)delWaitCursor{
	[[((UIViewController*)[[UIApplication sharedApplication] delegate]).tabBarController.view viewWithTag:1000]removeFromSuperview];	
	[waitView release];
	waitView=nil;
}
@end
