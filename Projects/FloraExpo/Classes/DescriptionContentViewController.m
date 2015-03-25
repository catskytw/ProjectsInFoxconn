//
//  DescriptionContentViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DescriptionContentViewController.h"
#import "FloraExpoModel.h"
#import "Vars.h"
@implementation DescriptionContentViewController
@synthesize changeSizeBtn;
@synthesize titleLabel;
@synthesize picImageView;
@synthesize contentText;
@synthesize contentView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization

    }
    return self;
}
 */
-(id)initWithType:(NSInteger)type withKey:(NSString*)key{
	if((self=[super init])){
		switch (type) {
			case ExhibitionInfo:
				thisData=[FloraExpoModel getExpoExhibitionInfo:key];
				break;
			default:
				break;
		}
	}
	return self;
}


- (void)viewWillAppear:(BOOL)animated {
	originTransform=CGAffineTransformMakeScale((CGFloat)1, (CGFloat)1);
	afterTransform=CGAffineTransformMakeScale((CGFloat)2.8,(CGFloat)2.8);
	isBigFlowerImage=NO;
	[self.navigationItem setTitle:thisData.title];
	[titleLabel setText:thisData.brief];
	[contentText setText:thisData.descriptionText];
	[picImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisData.picName]]];
	[self setFlowerImageLocation];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

-(IBAction)changeImageSizeAnimation:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	isBigFlowerImage=!isBigFlowerImage;
	[self setFlowerImageLocation];
	[UIView commitAnimations];
}

-(void)setFlowerImageLocation{
	picImageView.transform=(isBigFlowerImage)?afterTransform:originTransform;
	//計算flowerImage之x位置
	int xPosition=self.view.frame.size.width-picImageView.frame.size.width;
	//計算switchSizeBtn之y位置
	int yPosition=picImageView.frame.size.height-changeSizeBtn.frame.size.height;
	picImageView.frame=CGRectMake(xPosition, 0, picImageView.frame.size.width, picImageView.frame.size.height);	
	
	if(isBigFlowerImage){
		[changeSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgreduce.png"] forState:UIControlStateNormal];
		[changeSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgreduce_i.png"] forState:UIControlStateHighlighted];
		changeSizeBtn.frame=CGRectMake(xPosition, yPosition+1, changeSizeBtn.frame.size.width, changeSizeBtn.frame.size.height);
	}else{
		[changeSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgenlarge.png"] forState:UIControlStateNormal];
		[changeSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgenlarge_i.png"] forState:UIControlStateHighlighted];
		changeSizeBtn.frame=CGRectMake(xPosition, yPosition, changeSizeBtn.frame.size.width, changeSizeBtn.frame.size.height);
	}
}

@end
