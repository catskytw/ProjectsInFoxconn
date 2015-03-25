//
//  ThreeContentViewController.m
//  logistic
//
//  Created by Chang Link on 11/8/10.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ThreeContentViewController.h"
#import "ContentView.h"
#import "ContentXibView.h"
#import "FcContent1View.h"
#import "FcContent2View.h"
#import "FcContent3View.h"
 
@implementation ThreeContentViewController
@synthesize contentViews,arrowScrollView;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    contentPosition = nil;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrowScrollView =[UIScrollView new];
    contentViews = [[NSMutableArray arrayWithObjects:nil]retain];
    arrowDictionary = [[NSMutableDictionary alloc]init];
    if (contentViewsName) {
        for (int nameCnt = 0 ; nameCnt < [contentViewsName count]; nameCnt ++) {
            NSLog(@"load contentView %i",nameCnt);
            if ([[contentViewsName objectAtIndex:nameCnt] length]>0) {
                NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[contentViewsName objectAtIndex:nameCnt]
                                                                  owner:self
                                                                options:nil];
                ContentView *contentView ;
                if(nameCnt ==0){
                    contentView  = [FcContent1View new];
                } else if(nameCnt ==1){
                    contentView  = [FcContent2View new];
                } else if(nameCnt ==2){
                    contentView  = [FcContent3View new];
                }
     
                contentView.superController = self;
                //((ContentXibView*)[nibViews objectAtIndex: 0]).superController = self;
                [contentView addContextXibView:[nibViews objectAtIndex: 0]];
                [contentViews addObject:contentView];
                [contentView release];
            }
        }
        float viewX= 0;
        if ( !contentPosition) {
            for (int i =0; i<[contentViews count]; i++) {
                if ([contentPosition objectAtIndex:i]) {
                    UIView *contentView = [contentViews objectAtIndex:i];
                    if (contentView.frame.size.width>0) {
                        contentView.frame= CGRectMake(viewX, 0, contentView.frame.size.width, contentView.frame.size.height);
                        viewX += contentView.frame.size.width;
                        [self.view addSubview: contentView];
                        [[contentViews objectAtIndex:i] setInfo];
                        [[contentViews objectAtIndex:i] setBackGround];
                    }
                }
            }
        } else{
            for (int i =0; i<[contentViews count]; i++) {
                if ([contentPosition objectAtIndex:i]) {
                    ContentView *contentView = [contentViews objectAtIndex:i];
                    CGRect rect = [[contentPosition objectAtIndex:i] CGRectValue];
                    if (rect.size.width>0) {
                        contentView.frame= rect;
                        [self.view addSubview: contentView];
                        [[contentViews objectAtIndex:i] setInfo];
                        [[contentViews objectAtIndex:i] setBackGround];
                    }
                }
            }
        }
    }
    //[self addArrowImage:@"img_step3_line_triangle.png" withIndex:2];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMoveArrowNotification:) name:@"moveArrow" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMoveArrowNoAnimationNotification:) name:@"moveArrowNoAniamtion" object:nil];
    // Do any additional setup after loading the view from its nib.
}
/*-(void)receiveMoveArrowNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:@"moveArrow"]) {
        [self moveArrow:[(NSNumber*)[notification object] floatValue] withIndex:2];
    }

}
-(void)receiveMoveArrowNoAnimationNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:@"moveArrowNoAniamtion"]) {
        [self moveArrowWithNoAnimation:[(NSNumber*)[notification object] floatValue] withIndex:2];
    }
    
}*/
-(void)initWithXibNames:(NSArray*) nibName{
    if (nibName) 
        contentViewsName = nibName;
}
-(void)initWithXibNames:(NSArray*) nibName withPosition:(NSArray*) nibPosition{
    if(nibName)
        contentViewsName = nibName;
    if(nibPosition)
        contentPosition=nibPosition;
}
/*-(void)addArrowImage:(NSString*) imgUrl withIndex:(int) idx{
    NSString *nsIdx = [NSString stringWithFormat:@"%d",idx];
    UIView *contentView =[contentViews objectAtIndex:idx];

    arrowScrollView = [[UIImageView alloc]init];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgUrl]];
    [arrowScrollView setFrame:CGRectMake(contentView.frame.origin.x-imgView.frame.size.width, contentView.frame.origin.y+scrollShadowY, imgView.frame.size.width, contentView.frame.size.height-ArrowHeight)];

    [imgView setFrame:CGRectMake(0, -imgView.frame.size.height/2, imgView.frame.size.width, imgView.frame.size.height)];
    arrowScrollView.clipsToBounds = YES;
    [arrowScrollView addSubview:imgView];
    [self.view addSubview:arrowScrollView];
    
    [arrowDictionary setObject:imgView forKey:nsIdx];
    [imgView release];
    
    UIImageView *imgScrollMask = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_step3_line_triangle_mask.png"]];
    UIImageView *imgUplineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"step3_white_line.png"]];
    UIImageView *imgDownlineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"step3_white_line.png"]];
    [imgScrollMask setFrame:CGRectMake(arrowScrollView.frame.origin.x, arrowScrollView.frame.origin.y, imgScrollMask.frame.size.width, imgScrollMask.frame.size.height)];
    [imgUplineView setFrame:CGRectMake(arrowScrollView.frame.origin.x+5, arrowScrollView.frame.origin.y-1, arrowScrollView.frame.size.width, 1)];
    [imgDownlineView setFrame:CGRectMake(arrowScrollView.frame.origin.x+5, arrowScrollView.frame.origin.y+arrowScrollView.frame.size.height-0.05, arrowScrollView.frame.size.width, 1)];
    [self.view addSubview:imgUplineView];
    [self.view addSubview:imgDownlineView];
    [self.view addSubview:imgScrollMask];
    [imgScrollMask release];
    [imgUplineView release];
    [imgDownlineView release];
}-(void)moveArrowWithNoAnimation:(float)y withIndex:(int)idx{
    NSString *nsIdx = [NSString stringWithFormat:@"%d",idx];
    UIImageView *imgView =[arrowDictionary objectForKey:nsIdx];
    //NSLog(@"moveArrowWithNoAnimation %f",y);
    if (imgView) {
        //[UIView setAnimationsEnabled:NO];
        imgView.frame = CGRectMake(imgView.frame.origin.x,y-imgView.frame.size.height/2, imgView.frame.size.width, imgView.frame.size.height);
    }
}
-(void)moveArrow:(float)y withIndex:(int)idx{
    NSString *nsIdx = [NSString stringWithFormat:@"%d",idx];
    UIImageView *imgView =[arrowDictionary objectForKey:nsIdx];
    //NSLog(@"moveArrow %f",y);
    if (imgView) {
        //[UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        imgView.frame = CGRectMake(imgView.frame.origin.x,y-imgView.frame.size.height/2, imgView.frame.size.width, imgView.frame.size.height);
        [UIView commitAnimations];
        //[UIView setAnimationsEnabled:NO];
    }
}*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    [contentViews release];
    [arrowDictionary release];
    [arrowImg release];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [arrowScrollView release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
