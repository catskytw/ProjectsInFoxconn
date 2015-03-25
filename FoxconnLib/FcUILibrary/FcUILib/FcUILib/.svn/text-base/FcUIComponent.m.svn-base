//
//  FcUIComponent.m
//  FcUILib
//
//  Created by Chang Link on 11/8/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcUIComponent.h"
#import "FcPopWindows.h"
#import "NinePatch.h"
static NSMutableArray *miscArray=nil;
@implementation FcUIComponent
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+(void)showMenu:(UIView*)parentView withTarget:(id)delegete action:(SEL)action withNames:(NSArray*) menuName withIcon:(NSArray*) menuIcon withPoint:(CGPoint) point withWidth:(float) fWidth{
    if (miscArray==nil)
        miscArray=[[NSMutableArray array] retain];
    else
        [miscArray removeAllObjects];
        
    float xSpace =25;
    float startP =34;
    float iconWidth = 75;
    float showdowWidth = 8;
    UIViewController *menu = [[UIViewController alloc]init];
    UIScrollView *menuScrollView = [[UIScrollView alloc]init];
    menu.view.frame = CGRectMake(0, 0, fWidth, 162);
    menuScrollView.frame = CGRectMake(showdowWidth, 0,menu.view.frame.size.width - 2*showdowWidth, 145);
    
    float iconPosition =0 ;
    for(int i=0;i<[menuName count];i++){
        iconPosition = startP+(xSpace+iconWidth)*i;
		UIButton *menuButton=[[UIButton alloc]initWithFrame:CGRectMake(iconPosition, 25, iconWidth, 80)];
        [menuButton setBackgroundImage:[UIImage imageNamed:[menuIcon objectAtIndex:i]] forState:UIControlStateNormal];
		[menuButton.titleLabel setText:[menuName objectAtIndex:i]];
		[menuButton.titleLabel setTextColor:[UIColor clearColor]];
		[menuButton addTarget:delegete action:action forControlEvents:UIControlEventTouchUpInside];
        [menuScrollView addSubview:menuButton];
        [miscArray addObject:menuButton];
		[menuButton release];
        
        UILabel *menulabel = [[UILabel alloc] initWithFrame:CGRectMake(iconPosition, 117, iconWidth, 15)];
        [menulabel setText:[menuName objectAtIndex:i]];
        [menulabel setTextColor:[UIColor whiteColor]];
        [menulabel setTextAlignment:UITextAlignmentCenter];
        [menulabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:12.0]];
        [menulabel setBackgroundColor:[UIColor clearColor]];
        [menuScrollView addSubview:menulabel];
		[menulabel release];
        
	}
    menuScrollView.contentSize = CGSizeMake(iconPosition + iconWidth + startP, 110);
    UIImageView *imgLine = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(menuScrollView.frame.size.width, 1)  forNinePatchNamed:@"menubg_line"]];
    imgLine.frame = CGRectMake(0, 103, menuScrollView.contentSize.width, 1);
    [menuScrollView addSubview:imgLine];
    [menu.view addSubview: menuScrollView];
    
    FcPopWindows *pop=[[FcPopWindows alloc] initWithInnerFrame:menu.view.frame.size withPosition:point withContentViewController:menu withCloseBtnString:@"Cancel" isAllowedClose:NO isMenu:YES];
    [pop show:parentView];
    [menu release];
    
}
+(void)flush{
    if(miscArray!=nil)
        [miscArray release];
}
@end
