//
//  StepViewController.m
//  logistic
//
//  Created by Chang Link on 11/8/8.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "StepViewController.h"
#import "NinePatch.h"
#import "StepView.h"
#import "StepIcon.h"
#import "FcDrawing.h"
#define LeftSpan 23
#define RightSpan 0
#define TopSpan 40

#define StepNoX 0
#define StepNoY 17
#define StepLineY 27
#define StepLineHeight 2

@implementation StepViewController
@synthesize bgImg;
@synthesize scrollView;
@synthesize stepViews,delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    currentStep = 0;
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
-(void)setBackGround{
    UIImage *texture=[FcDrawing drawImageWithPattern:@"step2_material.png" withSize:bgImg.frame.size];
    UIImage *mask=[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"top_step_mask"];
    bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"top_step_frame"];

    UIImageView *textureView =  [[UIImageView alloc]initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    textureView.frame = bgImg.frame;
    [bgImg addSubview:textureView];
    [textureView release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    stepViews = [[NSMutableArray arrayWithObjects:nil]retain];
    stepNoPic = [[NSMutableArray arrayWithObjects:nil]retain];
    [self setBackGround];    
    if (stepViewsName) {
        
        for (int nameCnt = 0 ; nameCnt < [stepViewsName count]; nameCnt ++) {
            NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[stepViewsName objectAtIndex:nameCnt]
                                                          owner:self
                                                        options:nil];
            ((StepView*)[nibViews objectAtIndex: 0]).superController = self;
            ((StepView*)[nibViews objectAtIndex: 0]).iNo = nameCnt;
            [stepViews addObject:[nibViews objectAtIndex: 0]];
            [(StepView*)[nibViews objectAtIndex: 0] setProcessing:(nameCnt==0)];
            [(StepView*)[nibViews objectAtIndex: 0] initLayout];
        }
        float viewX = LeftSpan;
        CGSize scrollSize=CGSizeMake(0,0);
        for (int i =0; i<[stepViews count]; i++) {
             
            //viewX += LeftSpan;
            NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"StepIcon"
                                                              owner:self
                                                            options:nil];
            StepIcon *stepNo =[nibViews objectAtIndex: 0];
            [stepNo setOnOff:(currentStep == i) andNo:i+1];
            [stepNo setFrame:CGRectMake(StepNoX+viewX, StepNoY, stepNo.frame.size.width, stepNo.frame.size.height)];
            
            [stepNoPic addObject:stepNo];
            
            UIView *stepView = [stepViews objectAtIndex:i];
            
            stepView.frame= CGRectMake(viewX, TopSpan, stepView.frame.size.width, stepView.frame.size.height);
            
            
            [scrollView addSubview: stepView];
            
            UIImageView *stepLine=[[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(stepView.frame.size.width,StepLineHeight) forNinePatchNamed:@"line_top_step"]];
            [stepLine setFrame:CGRectMake(stepNo.frame.origin.x, StepLineY,
                                          stepView.frame.size.width, StepLineHeight)];
            [scrollView addSubview:stepLine];
            [scrollView addSubview:stepNo];
            
            viewX = viewX + stepView.frame.size.width+RightSpan;
            scrollSize=CGSizeMake(viewX,stepView.frame.size.height);
            //[stepNo release];
            [stepLine release];
        }
        
        [scrollView setContentSize:scrollSize];
    }
}
-(void)commit:(NSInteger)stepNum withInfo:(NSDictionary*)infoDic{
    @try{
        [[stepNoPic objectAtIndex:currentStep] setOnOff:NO andNo:currentStep+1];
        [[stepNoPic objectAtIndex:stepNum] setOnOff:YES andNo:stepNum+1];
        [[stepViews objectAtIndex:currentStep] setProcessing:NO];
        [[stepViews objectAtIndex:stepNum] setProcessing:YES];
        currentStep = stepNum;
        
        passInfoDic = infoDic;
        if (delegate) {
            [delegate stepCommit:stepNum withInfo:infoDic];
        }

        /*[scrollView scrollRectToVisible:CGRectMake(((StepView*)[stepViews objectAtIndex:stepNum]).frame.origin.x-LeftSpan, 0, 
                                                   scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];*/
    }
    @catch (NSException * e) {
        //NPLogException(e);
        if (delegate) {
            //[delegate stepCommitError:stepNum withError:&e];
        }
    }
    @finally {
    }

}
-(void)moveToStep:(NSInteger)stepNum{
    [scrollView scrollRectToVisible:CGRectMake(((StepView*)[stepViews objectAtIndex:stepNum]).frame.origin.x-LeftSpan, 0, 
                                               scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
}
-(void)initWithXibNames:(NSArray*) nibName{
    if (nibName) {
        stepViewsName = nibName;
    }
}
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setBgImg:nil];
    [super viewDidUnload];
    [stepViews release];
    [stepNoPic release];
    [scrollView release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [scrollView release];
    [bgImg release];
    [super dealloc];
}
@end
