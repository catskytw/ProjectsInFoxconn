//
//  FcPopWindows.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/15.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcPopWindows.h"
#import "NinePatch.h"
#import "FcDrawing.h"
#define kTransitionDuration 0.5
@implementation FcPopWindows
@synthesize windowsView,contentView,closeBtn,frameImage;
-(void)show:(UIView*)parentView{
    //UIViewController *applicationViewController= (UIViewController*)[[UIApplication sharedApplication] delegate];
    [parentView addSubview:self.view];
    [self initialDelayEnded];
}
-(void)initialDelayEnded {
    windowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    windowView.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    windowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}

- (IBAction)touchOutsidePop:(id)sender {
    [self close];
}

- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    windowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    windowView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


-(void)closeThisPopWindow:(NSNotification*)notification{
    [self close];
}
-(IBAction)close{
    //UIViewController *applicationViewController= (UIViewController*)[[UIApplication sharedApplication] delegate];
    //applicationViewController.tabBarController.tabBar.userInteractionEnabled=YES;
    [self.view removeFromSuperview];
    [self release];
}
-(id)initWithInnerFrame:(CGSize)contentSize withPosition:(CGPoint)position  withContentViewController:(UIViewController*)contentController withCloseBtnString:(NSString*)closeString isAllowedClose:(BOOL)allowed{
    if ((self=[super init])) {
        
        _contentController=[contentController retain];
        _closeBtnString=(closeString==nil)?nil:[[NSString stringWithString:closeString]retain];
        _framePosition=position;
        _contentSize=contentSize;
        _allowClose=allowed;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeThisPopWindow:) name:ClosePopWindow object:nil];
    }
    return self;
}
-(id)initWithInnerFrame:(CGSize)contentSize withPosition:(CGPoint)position  withContentViewController:(UIViewController*)contentController withCloseBtnString:(NSString*)closeString isAllowedClose:(BOOL)allowed isMenu:(BOOL)bMenu{
    _isMenu = bMenu;
    if ((self=[super init])) {
        
        [self initWithInnerFrame:contentSize withPosition:position withContentViewController:contentController withCloseBtnString:closeString isAllowedClose:allowed];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_contentController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ClosePopWindow object:nil];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)setMenuFrameimage {
    UIImage *texture=[FcDrawing drawImageWithPattern:@"menubg_material.png" withSize:frameImage.frame.size];
    UIImage *mask=[TUNinePatchCache imageOfSize:frameImage.frame.size forNinePatchNamed:@"menubg_mask"];
    frameImage.image = [TUNinePatchCache imageOfSize:frameImage.frame.size forNinePatchNamed:@"menubg_frame"];
    UIImageView *textureView =  [[UIImageView alloc]initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    textureView.frame = frameImage.frame;
    [frameImage addSubview:textureView];
    [textureView release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [closeBtn setTitle:(_closeBtnString==nil)?@"close":_closeBtnString forState:UIControlStateNormal];
    int btnSpace=55;
    //set size
    CGSize windowSize=CGSizeMake(_contentSize.width,(_allowClose)?_contentSize.height+btnSpace:_contentSize.height);
    [windowView setFrame:CGRectMake(_framePosition.x, _framePosition.y, windowSize.width, windowSize.height)];
    [contentView setFrame:CGRectMake(0, 0, _contentSize.width, _contentSize.height)];
    [frameImage setFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
    
    if (_isMenu) {
        [self setMenuFrameimage];
    }
        
    if(_allowClose){
        CGFloat btnX=(CGFloat)windowSize.width/2 - (CGFloat)closeBtn.frame.size.width/2;
        CGFloat btnY=windowSize.height-50;
        [closeBtn setFrame:CGRectMake(btnX, btnY, closeBtn.frame.size.width, closeBtn.frame.size.height)];
        [closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:closeBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
        [closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:closeBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    }else
        closeBtn.hidden=YES;
    
    [contentView addSubview:_contentController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
