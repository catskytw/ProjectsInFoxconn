//
//  SettingViewController.m
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/11/1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "CameraURL.h"
#import "DesktopURL.h"
#import "ViewController.h"
@implementation SettingViewController
@synthesize textField1,textField2;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"設定";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(IBAction)settingAction:(id)sender{
    [CameraURL setCameraURL:textField1.text];
    [DesktopURL setDesktopURL:textField2.text];
    
    [self.navigationController pushViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] animated:YES];
}
@end
