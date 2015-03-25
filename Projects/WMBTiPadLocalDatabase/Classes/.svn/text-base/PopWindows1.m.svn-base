    //
//  PopWindows1.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/27.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "PopWindows1.h"
#import "LocalizationSystem.h"
#import "Tools.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "NinePatch.h"
@interface PopWindows1 (PrivateMethod)
-(void)adjustLayout;
-(void)addImages:(NSArray*)imageUrls;
@end

@implementation PopWindows1
@synthesize titleLabel,slogonLabel,rightCommentLabel,titleBackgroundView,mainAreaBackgroundView,contentScrollView,closeBtn;
@synthesize placeLabel,contentLabel,briefLabel;
#pragma mark Developer Override
-(void)EnvelopSuit{
	[titleBackgroundView setImage:[UIImage imageNamed:@"content_bg_pop_windows_title.png"]];
	[mainAreaBackgroundView setImage:[UIImage imageNamed:@"content_bg_pop_windows.png"]];
	// use 9-patch
	[closeBtn setTitle:AMLocalizedString(@"close",nil) forState:UIControlStateNormal];
	CGSize fontSize=[Tools estimateStringSize:closeBtn.titleLabel.text withFontSize:14.0];
	int width=(fontSize.width<72)?72:fontSize.width;
	int height=36;
	[closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(width, height) forNinePatchNamed:@"button_normal"]
						forState:UIControlStateNormal];
	[closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(width, height) forNinePatchNamed:@"button_active"]
						forState:UIControlStateHighlighted];
	/*
	[closeBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button.png"] forState:UIControlStateNormal];
	[closeBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button_i.png"] forState:UIControlStateHighlighted];
	 */
	[closeBtn setTitle:AMLocalizedString(@"close",nil) forState:UIControlStateNormal];
	[titleLabel setText:AMLocalizedString(@"ActionDescription",nil)];
	[briefLabel setText:[NSString stringWithFormat:@"%@:",
	 AMLocalizedString(@"ActionBrief",nil)]];
}
-(void)loadData:(NSString*)key{
	//For FcDeveloper: You should load your data here by your way.
	QueryPattern *query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	[query prepareDic:searchPromotionDetailInfo(key)];
	
	[rightCommentLabel setText:[NSString stringWithFormat:@"%@: %@",
                                AMLocalizedString(@"time", nil),
                                [query getValueUnderNode:@"promotionEventInfo" withKey:@"eventDate" withIndex:0]]];

	[slogonLabel setText:[query getValueUnderNode:@"promotionEventInfo" withKey:@"title" withIndex:0]];
	[placeLabel setText:[NSString stringWithFormat:@"%@: %@",
						 AMLocalizedString(@"place",nil),
						 [query getValueUnderNode:@"promotionEventInfo" withKey:@"place" withIndex:0]]];
	[contentLabel setText:[query getValueUnderNode:@"promotionEventInfo" withKey:@"content" withIndex:0]];
	//adjust content's size
	
	CGSize maxSize=CGSizeMake(494, 20000);
	CGSize labelSize=[Tools estimateStringSize:contentLabel.text withFontSize:14.0 withMaxSize:maxSize];
	[contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, labelSize.width, labelSize.height)];
	startYPosition=contentLabel.frame.origin.y+contentLabel.frame.size.height;
	
	//TODO: load all images
	//[self addImages:imageUrls];
	[query release];
}
#pragma mark -

#pragma mark LifeCycle
-(id)initWithKey:(NSString*)key{
	if((self=[super init])){
		myKey=[[NSString stringWithString:key]retain];
	}
	return self;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self EnvelopSuit];
	[self adjustLayout];
	[self loadData:myKey];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myKey release];
    [super dealloc];
}
#pragma mark -
#pragma mark DelegateMethod
-(IBAction)closeBtnAction:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}
#pragma mark -

#pragma mark PrivateMethod
-(void)adjustLayout{
	CGSize maxSize=CGSizeMake(150, 26);
	CGSize actureSize=[Tools estimateStringSize:AMLocalizedString(@"close",nil) withFontSize:14 withMaxSize:maxSize];
	int width=actureSize.width+30;
	//btn的末端xPosition要保持在644
	[closeBtn setFrame:CGRectMake(644-width, closeBtn.frame.origin.y, width, closeBtn.frame.size.height)];
    NSLog(@"font name %@",[contentLabel.font fontName]);
}
-(void)addImages:(NSArray*)imageUrls{
	int space=15;//每張圖間隔15
	for (NSString *imageUrl in imageUrls) {
		UIImageView *thisImageView=[UIImageView new];
		QueryPattern *imageQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
		[imageQuery uiValueBinding:thisImageView withValue:imageUrl];
		[thisImageView setFrame:CGRectMake(15, startYPosition, thisImageView.frame.size.width, thisImageView.frame.size.height)];		
		startYPosition+=thisImageView.frame.size.height+space;
		[contentScrollView addSubview:thisImageView];
		
		[thisImageView release];
		[imageQuery release];
	}
}
#pragma mark -
@end
