//
//  SignOffViewController.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/13.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffViewController.h"
#import "FcConfig.h"
#define kOFFSET_FOR_KEYBOARD 350
@implementation SignOffViewController
@synthesize isComment;
#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    contentVC = [[ThreeContentViewController alloc] initWithNibName:nil bundle:nil];
    NSMutableArray *contentViewsName = [[NSMutableArray arrayWithObjects:@"SignOffContent1View", @"SignOffContent2View", @"SignOffContent3View",nil]retain];
    NSArray *contentPosition = [[NSArray arrayWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0,122, 651)],
                                 [NSValue valueWithCGRect:CGRectMake(112, 0, 244, 651)],
                                 [NSValue valueWithCGRect:CGRectMake(355, 0, 663, 651)],nil]retain];
    [contentVC initWithXibNames:contentViewsName withPosition:contentPosition];
    [contentVC.view setFrame:CGRectMake(5, 45, 1014, 651)];
    [self.view addSubview:contentVC.view];
    [contentViewsName release];
    [contentPosition release];
    [self tuneTitleLayout:NO];
    [self.view bringSubviewToFront:self.msgView];
    isSlideForKeyboard = NO;
    isComment = NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startWriteComment:) name:startWriteCommentNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endWriteComment:) name:endWriteCommentNotification object:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void)startWriteComment:(NSNotification*)noti{
    isComment = YES;
}
-(void)endWriteComment:(NSNotification*)noti{
    isComment = NO;
}
-(void)keyBoardDidShow:(NSNotification*)noti{
    if (isSlideForKeyboard==NO && isComment == YES) {
        [self setViewMovedUp:YES];
        isSlideForKeyboard=YES;
    }
}
-(void)keyBoardDidHide:(NSNotification*)noti{
    if (isSlideForKeyboard==YES && isComment == YES) {
        [self setViewMovedUp:NO];
        isSlideForKeyboard=NO;
        isComment = NO;
    }
}

@end
