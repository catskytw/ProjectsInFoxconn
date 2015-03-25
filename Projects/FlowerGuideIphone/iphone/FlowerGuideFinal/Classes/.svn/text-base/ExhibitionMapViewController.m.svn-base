//
//  ExhibitionMapViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionMapViewController.h"
#import "LocalizationSystem.h"
#import "AreaListObject.h"
#import "DrawFunctions.h"
#import "ToolsFunction.h"
#import "UserInfoButton.h"
@implementation ExhibitionMapViewController
@synthesize exhibitionDataArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
		if(myMap==nil){
			NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ExhibitionScrollMap" owner:self options:nil];
			for(id currentObject in  nib){
				if([currentObject isKindOfClass:[ExhibitionScrollMap class]]){
					myMap=(ExhibitionScrollMap*)currentObject;
					[myMap retain];
					break;
				}
			}
		}
    }
    return self;
}

- (void)dealloc {
	[myMap release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[titleLabel setText:AMLocalizedString(@"ExhibitIntro",nil)];
	[rightBtn setHidden:NO];
	[rightUpBtn setHidden:NO];
	[rightUpBtn setTitle:AMLocalizedString(@"ListInfo",nil) forState:UIControlStateNormal];
	
	for(AreaListObject *thisDataObject in exhibitionDataArray){
		UserInfoButton *thisExhibitionButton=[UserInfoButton buttonWithType:UIButtonTypeCustom];
		[thisExhibitionButton setBackgroundColor:[UIColor clearColor]];
		[thisExhibitionButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
		CGSize thisButtonSize=[ToolsFunction getContentTextSize:thisDataObject.name withWidth:76 withFontSize:12];
		thisExhibitionButton.userinfo=[NSString stringWithString:thisDataObject.areaId];
		[thisExhibitionButton setFrame:CGRectMake(thisDataObject.x, thisDataObject.y, thisButtonSize.width+6, thisButtonSize.height+6)];
		[thisExhibitionButton setTitle:thisDataObject.name forState:UIControlStateNormal];
		CGImageRef buttonImageRef=[DrawFunctions createMessageBk:thisButtonSize];
		UIImage *buttonBackgroundImage=[UIImage imageWithCGImage:buttonImageRef];
		[thisExhibitionButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
		[thisExhibitionButton addTarget:myMap action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
		[myMap.myScrollMap addSubview:thisExhibitionButton];
		
		CGImageRelease(buttonImageRef);
	}
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	myMap.parentNavigationController=self.navigationController;
	[myMap.myScrollMap setScrollEnabled:YES];
	[myMap.myScrollMap setContentSize:CGSizeMake(693,343)];
	[viewPortView addSubview:myMap.myScrollMap];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(IBAction)rightUpBtnAction:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
@end
