//
//  AboutUsViewCtrl.m
//  OveExpo
//
//  Created by  on 11/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AboutUsViewCtrl.h"

#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "FcDrawing.h"

@implementation AboutUsViewCtrl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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
- (void)prepareData
{
    if (MY_TEST == YES) {
        content = @"關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們關於我們";
    }
    else
    {
        QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        LoginDataObject *_login = [LoginDataObject sharedInstance];
        [query prepareDic:getAboutUs(_login.sessionId)];
        @try {
            if (([[query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                title = [query getValueFromNodeString:@"aboutUs.title"];
                content = [query getValueFromNodeString:@"aboutUs.content"];
                
            }else{
                NSLog(@"reponse err %@", [query getValue:@"response" withIndex:0]);
            }
            
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
            [query release];
            
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)leftItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self prepareData];
    [self.navigationController setNavigationBarHidden:NO];
    [self setTitle:AMLocalizedString(@"AbountUs",nil)];
    [UITuneLayout setNaviTitle:self];
    [contentTitleLabel setText:AMLocalizedString(@"會場展覽",nil)];
    CGSize contentSize = [content sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16] constrainedToSize:CGSizeMake(contentLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
    [contentLabel setText:content];
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentSize.width, contentSize.height)];
    [baseScroll setContentSize:CGSizeMake(contentSize.width, contentSize.height + contentTitleLabel.frame.size.height + 150)];
}

@end
