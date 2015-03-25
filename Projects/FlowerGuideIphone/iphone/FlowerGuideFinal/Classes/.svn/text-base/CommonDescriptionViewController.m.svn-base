//
//  CommonDescriptionViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommonDescriptionViewController.h"


@implementation CommonDescriptionViewController
@synthesize photoImage,photoBackgroundImage,hasPhoto;
-(id)initWithTextWidth:(NSInteger)width hasPhoto:(BOOL)contentHasPhoto{
	if((self=[super init])){
		startX=15;
		hasPhoto=contentHasPhoto;
		startY=(hasPhoto)?230:15;
		textWidth=290;
		uiArray=[[NSMutableArray arrayWithObjects:nil]retain];
		thisScrollView=[[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 342)]autorelease];
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"CommonDescriptionViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(void)constructThisPage{
	[super constructThisPage];
	
	[photoImage setHidden:(hasPhoto==YES)?NO:YES];
	[photoBackgroundImage setHidden:(hasPhoto==YES)?NO:YES];
	
	if(hasPhoto==YES){
		photoBackgroundImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_bg_photoframe.png"]];
		[photoBackgroundImage setFrame:CGRectMake(20, 15, 279, 200)];
		
		[photoImage setFrame:CGRectMake(28, 23, 260, 180)];
		[thisScrollView addSubview:photoBackgroundImage];
		[thisScrollView addSubview:photoImage];
		[photoBackgroundImage release];
	}
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


- (void)dealloc {
    [super dealloc];
}


@end
