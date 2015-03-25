//
//  ContentViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"
#import "GoFutureModel.h"
#import "CommonDescriptionObject.h"
#import "DescriptionObject.h"
#import "Vars.h"
#import "ToolsFunction.h"
@implementation ContentViewController
@synthesize featureImageView;
-(id)initWithAreaId:(NSString*)areaId{
	if((self=[super init])){
		//下方編排之設定參數
		startY=212;//高度依miki給的圖算出來的
		startX=14;
		textWidth=262;
		
		uiArray=[[NSMutableArray arrayWithObjects:nil]retain];
		dataStringArray=[[NSMutableArray arrayWithObjects:nil]retain];
		thisAreaInfoObject=[GoFutureModel getAreaInfo:areaId];
		for(CommonDescriptionObject *thisContentObject in thisAreaInfoObject.descList){
			DescriptionObject *subject=[DescriptionObject new];
			subject.descriptionType=DescriptionTypeSubject;
			subject.textString=[NSString stringWithString:thisContentObject.subject];
			DescriptionObject *content=[DescriptionObject new];
			content.descriptionType=DescriptionTypeContent;
			content.textString=[NSString stringWithString:thisContentObject.content];
			
			[dataStringArray addObject:subject];
			[dataStringArray addObject:content];
			
			[subject release];
			[content release];
		}
	}
	return self;
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	titleString=thisAreaInfoObject.title;
	//TODO 取得影像
	[featureImageView setBackgroundColor:[UIColor whiteColor]];
	[ToolsFunction getImageFromURL:thisAreaInfoObject.picURL withTargetUIImageView:featureImageView];
    [super viewDidLoad];
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

-(IBAction)closeContentView:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}
@end
