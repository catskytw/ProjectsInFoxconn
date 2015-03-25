//
//  UITuneLayout.m
//  WMBT
//
//  Created by link on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "Tools.h"
#import "HealthCareAppDelegate.h"
static UIView *waitView;
@implementation UITuneLayout
//set Navigation bar title font 
+(void) setNaviTitle: (id)controller{
    
    UIViewController *ctrl = (UIViewController*)controller;
    CGSize _stringSize=[Tools estimateStringSize:ctrl.navigationItem.title withFontSize:24.0f withMaxSize:ccs(180, 44)];
    CGRect frame = CGRectMake(0,0, _stringSize.width, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:24.0]];
    label.shadowColor = [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:1];
    
    ctrl.navigationItem.titleView = label;
    

    label.text= ctrl.navigationItem.title;
    [ctrl.navigationController.navigationBar setTintColor:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:0]]; 
}
+(void) setBackground:(id)view{
    //設定背景圖示 [UIImage imageNamed:thumbnailPath]]
    UIImage *img = [UIImage imageNamed:@"bg_blue.png"];
	[view setBackgroundColor:[UIColor colorWithPatternImage:img]];
	//[img release];
}
+(NSString*) getHMTimeString:(NSString*)timestampString{
    NSString *HMTimes = [UITuneLayout getTimestamp:timestampString withKey:@"timestamp"];
    NSTimeInterval _time_double = [HMTimes doubleValue]/1000;
    NSDate *_time=[NSDate dateWithTimeIntervalSince1970:_time_double];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit  fromDate:_time];
    //[[cell textLabel]setText:[NSString stringWithFormat:@"%d年 %d月 %d日", year, month, day]];
    return [NSString stringWithFormat:@"%02d:%02d", [components hour], [components minute]];
    //XXXX : need to transfer timestamp to date format(eg. 2010/01/01) (ps.保留timestamp的格式, 要顯示的時候才轉換格式, 以便傳參數可使用timestamp.)
}
+(NSString*) getDateString:(NSString*)timestampString{
    NSTimeInterval _date_double = [timestampString doubleValue]/1000;
    NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
       NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:_date];
    return[NSString stringWithFormat:@"%d年%d月%d日", [components year],[components month],[components day]];
    }
+(NSString*) getTimestamp:(NSString*)timestampString withKey:(NSString*) skey{
    NSString *dateString = [timestampString substringFromIndex:skey.length+1];
    return [dateString substringToIndex:(dateString.length - 1)];
}
// takes 0x123456
+(UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}
// takes @"#123456"
+(UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}
+(NSString *)getMoneyString:(NSString *)str {
    NSString* returnStr = [NSString stringWithFormat:@"%@: %@",AMLocalizedString(@"money_unit", nil), str];
    return returnStr;
}
+(void)linkTwoLabel:(UILabel*)first fontsize:(int) fsize secondLabel:(UILabel*)second{
    CGSize firstSize = [Tools estimateStringSize:first.text withFontSize:fsize];
    CGRect firstRect = first.frame;
    firstRect.size = firstSize;
    first.frame = firstRect;
    
    CGRect secondRect = second.frame;
    secondRect.origin.x = firstRect.origin.x + firstRect.size.width+15;
    second.frame = secondRect;
}


+(void)runWaitCursor{
    NSAutoreleasePool *cursorPool=[[NSAutoreleasePool alloc] init];
	waitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	[waitView setUserInteractionEnabled:YES];
	[waitView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
	
	UIActivityIndicatorView *waitCursor=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 32, 32)]autorelease];
	[waitCursor setCenter:CGPointMake(160,240)];
	[waitCursor setHidesWhenStopped:YES];
	[waitCursor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[waitCursor startAnimating];
	[waitView addSubview:waitCursor];
	
	UILabel *waitLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)]autorelease];
	[waitLabel setCenter:CGPointMake(160,270)];
	[waitLabel setText:AMLocalizedString(@"PleaseWait",nil)];
	[waitLabel setTextColor:[UIColor whiteColor]];
	[waitLabel setTextAlignment:UITextAlignmentCenter];
	[waitLabel setBackgroundColor:[UIColor clearColor]];
	[waitView addSubview:waitLabel];
	[waitView setTag:1000];
    [(((HealthCareAppDelegate*)[[UIApplication sharedApplication] delegate]).tabBarController).view addSubview:waitView];
	[cursorPool release];
}
+(void)addWaitCursor{
    if(waitView!=nil)
        return;
    [NSThread detachNewThreadSelector:@selector(runWaitCursor) toTarget:[UITuneLayout class] withObject:nil];
}

+(void)delWaitCursor{
	[[(((HealthCareAppDelegate*)[[UIApplication sharedApplication] delegate]).tabBarController).view viewWithTag:1000]removeFromSuperview];	
	[waitView release];
	waitView=nil;
    
}
+(NSString*) checkQueryStr:(NSString*)input{
    if (![input isEqual:[NSNull null]] && [input length]>0 && ![input isEqualToString:@"null"]) {
        NSLog(@"input %@ %d", input, [input length]);
        return input; 
    }else{
        return @"";
    }
}
@end
