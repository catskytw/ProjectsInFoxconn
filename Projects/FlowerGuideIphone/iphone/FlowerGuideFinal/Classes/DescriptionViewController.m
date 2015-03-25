//
//  DescriptionViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DescriptionViewController.h"
#import "DescriptionObject.h"
#import "Vars.h"

@implementation DescriptionViewController
@synthesize thisScrollView,titleLabel;
@synthesize dataStringArray;
@synthesize startX,startY,textWidth;
@synthesize titleString;

-(id)initWithYValue:(NSInteger)yValue withXValue:(NSInteger)xValue withTextWidth:(NSInteger)width{
	if((self=[super init])){
		startX=xValue;
		startY=yValue;
		textWidth=width;
		uiArray=[[NSMutableArray arrayWithObjects:nil]retain];
		thisScrollView=[[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 342)]autorelease];
	}
	return self;
}
-(id)initWithDefaultStartY{
	if((self=[super init])){
		startX=14;
		startY=15;
		textWidth=262;
		uiArray=[[NSMutableArray arrayWithObjects:nil]retain];
	}
	return self;
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:@"DescriptionViewController" bundle:nibBundleOrNil]) {
//        // Custom initialization
//    }
//    return self;
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[titleLabel setText:titleString];
	[self constructThisPage];
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
	[dataStringArray release];
	[uiArray release];
	
    [super dealloc];
}

/**
 製作title之uilabel
 */
-(UILabel*)getTitleLabel:(NSString*)stringText{	
	CGSize maxSize = { textWidth, 50 };
	CGSize actualSize=[stringText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];

	UILabel *tmpLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, actualSize.width, actualSize.height)];
	[tmpLabel setNumberOfLines:2];
	[tmpLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
	[tmpLabel setText:stringText];
	[tmpLabel setTextColor:[UIColor colorWithRed:(CGFloat)0/256 green:(CGFloat)68/256 blue:(CGFloat)87/256 alpha:1]];
	[tmpLabel setBackgroundColor:[UIColor clearColor]];
	[tmpLabel setTag:DescriptionTypeSubject];
	return [tmpLabel autorelease];
}

/**
 製作textview
 */
-(UILabel*)getContentText:(NSString*)stringText{
	CGSize maxSize = { textWidth, 100000 };
	CGSize actualSize=[stringText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	UILabel *tmpLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, actualSize.width, actualSize.height)];
	UIFont *thisLabelFont=[UIFont fontWithName:@"Helvetica" size:16];
	[tmpLabel setFont:thisLabelFont];
	[tmpLabel setText:stringText];
	[tmpLabel setBackgroundColor:[UIColor clearColor]];
	[tmpLabel setNumberOfLines:0];
	[tmpLabel setTag:DescriptionTypeContent];
	return [tmpLabel autorelease];
}

/**
 建構整組頁面
 */
-(void)constructThisPage{
	int space=15;
	BOOL isTitle;
	for(DescriptionObject *thisObject in dataStringArray){
		if(thisObject.descriptionType==DescriptionTypeSubject){
			//加入titleLabel
			[uiArray addObject:[self getTitleLabel:thisObject.textString]];
		}else if(thisObject.descriptionType==DescriptionTypeContent){
			//加入contentText
			[uiArray addObject:[self getContentText:thisObject.textString]];
		}
	}
	
	for(UILabel *element in uiArray){
		isTitle=(element.tag==DescriptionTypeSubject)?YES:NO;
		if(isTitle){
			UILabel *thisLabel=(UILabel*)element;
			[thisLabel setFrame:CGRectMake(30, startY, thisLabel.frame.size.width, thisLabel.frame.size.height)];

			UIImageView *titleIcon=[[UIImageView alloc]initWithFrame:CGRectMake(startX, startY, 7, thisLabel.frame.size.height)];
			[titleIcon setImage:[UIImage imageNamed:@"contentui_icon_title_stretchstrip.png"]];
			[thisScrollView addSubview:titleIcon];
			[titleIcon release];
		}else{
			UILabel *thisView=(UILabel*)element;
			[thisView setFrame:CGRectMake(startX, startY, thisView.frame.size.width, thisView.frame.size.height)];
		}
		startY+=element.frame.size.height+space;
		[thisScrollView addSubview:element];
	}
	[thisScrollView setContentSize:CGSizeMake(textWidth,startY)];
	[thisScrollView setContentMode:UIViewContentModeTop];
	[thisScrollView setScrollsToTop:YES];
	[thisScrollView setContentOffset:CGPointZero];
}
@end
