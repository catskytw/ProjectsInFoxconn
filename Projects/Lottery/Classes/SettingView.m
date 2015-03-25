    //
//  SettingView.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "SettingView.h"
#import "GameConfig.h"
#import "DataModel.h"
#import "ParametersObject.h"
#import "NSMutableArray+Queue.h"
#import "Tools.h"
@interface  SettingView (PrivateMethod)

-(NSMutableArray*)createTicketsArray:(NSInteger)totalCount withEachCount:(NSInteger)eachCount;
-(void)sendInfo2MainScene:(NSString*)priceString withParameter:(ParametersObject*)object;
@end

@implementation SettingView
@synthesize isOpen;
@synthesize selectedParameters,arrowImageView;
@synthesize 
presidentATotalText,presidentAEachText,
presidentBTotalText,presidentBEachText,
presidentCTotalText,presidentCEachText,
presidentDTotalText,presidentDEachText,
managerATotalText,managerAEachText,
managerBTotalText,managerBEachText,
managerCTotalText,managerCEachText,
managerDTotalText,managerDEachText,
firstPriceATotalText,firstPriceAEachText,
firstPriceBTotalText,firstPriceBEachText,
firstPriceCTotalText,firstPriceCEachText,
firstPriceDTotalText,firstPriceDEachText,
bonusPriceATotalText,bonusPriceAEachText,
bonusPriceBTotalText,bonusPriceBEachText,
bonusPriceCTotalText,bonusPriceCEachText,
bonusPriceDTotalText,bonusPriceDEachText,bonusPriceNameText;
#pragma mark LifeCycle
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	isOpen=NO;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
    return YES;
	else return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
	[DataModel destoryPriceParameters];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if(selectedParameters!=nil){
		[selectedParameters release];
		selectedParameters=nil;
	}
    [super dealloc];
}

#pragma mark -
#pragma mark DelegateAction
- (void)textFieldDidBeginEditing:(UITextField *)textField{
	selectedTextField=textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	/*
	@try {
		NSLog(@"%@",textField.text);
		NSInteger testValue=[textField.text intValue];
		if(testValue>0 && ![textField isEqual:bonusPriceNameText])
			[textField resignFirstResponder];
		else if([textField isEqual:bonusPriceNameText])
			[textField resignFirstResponder];
	}
	@catch (NSException * e) {
		//TODO maybe a UIAlter?
	}*/
	[textField resignFirstResponder];
	return YES;
}
-(IBAction)touchSlideAction:(id)sender{
	[self slideAnimation];
}

-(IBAction)presidenPriceAcquire:(id)sender{
	//TODO acquire value from UI components
	ParametersObject *currentObject=[ParametersObject new];
	
	[currentObject.ticketOfA addObjectsFromArray:
	 [self createTicketsArray:[presidentATotalText.text intValue] withEachCount:[presidentAEachText.text intValue]]];
	[currentObject.ticketOfB addObjectsFromArray:
	 [self createTicketsArray:[presidentBTotalText.text intValue] withEachCount:[presidentBEachText.text intValue]]];
	[currentObject.ticketOfC addObjectsFromArray:
	 [self createTicketsArray:[presidentCTotalText.text intValue] withEachCount:[presidentCEachText.text intValue]]];
	[currentObject.ticketOfD addObjectsFromArray:
	 [self createTicketsArray:[presidentDTotalText.text intValue] withEachCount:[presidentDEachText.text intValue]]];
	
	currentObject.priceName=PresidentPrcieName;
	if(selectedParameters!=nil){
		[selectedParameters release];
		selectedParameters=nil;
	}
	selectedParameters=currentObject;
	[self sendInfo2MainScene:[NSString stringWithFormat:@"%@%@",currentObject.priceName,AClassName] withParameter:selectedParameters];
	[self slideAnimation];
}

-(IBAction)managerPriceAcquire:(id)sender{	
	ParametersObject *currentObject=[ParametersObject new];
	[currentObject.ticketOfA addObjectsFromArray:
	 [self createTicketsArray:[managerATotalText.text intValue] withEachCount:[managerAEachText.text intValue]]];
	[currentObject.ticketOfB addObjectsFromArray:
	 [self createTicketsArray:[managerBTotalText.text intValue] withEachCount:[managerBEachText.text intValue]]];
	[currentObject.ticketOfC addObjectsFromArray:
	 [self createTicketsArray:[managerCTotalText.text intValue] withEachCount:[managerCEachText.text intValue]]];
	[currentObject.ticketOfD addObjectsFromArray:
	 [self createTicketsArray:[managerDTotalText.text intValue] withEachCount:[managerDEachText.text intValue]]];
	
	currentObject.priceName=ManagerPriceName;

	if(selectedParameters!=nil){
		[selectedParameters release];
		selectedParameters=nil;
	}
	selectedParameters=currentObject;
	[self sendInfo2MainScene:[NSString stringWithFormat:@"%@%@",currentObject.priceName,AClassName] withParameter:selectedParameters];
	[self slideAnimation];
}

-(IBAction)firstPriceAcquire:(id)sender{
	ParametersObject *currentObject=[ParametersObject new];
	[currentObject.ticketOfA addObjectsFromArray:
	 [self createTicketsArray:[firstPriceATotalText.text intValue] withEachCount:[firstPriceAEachText.text intValue]]];
	[currentObject.ticketOfB addObjectsFromArray:
	 [self createTicketsArray:[firstPriceBTotalText.text intValue] withEachCount:[firstPriceBEachText.text intValue]]];
	[currentObject.ticketOfC addObjectsFromArray:
	 [self createTicketsArray:[firstPriceCTotalText.text intValue] withEachCount:[firstPriceCEachText.text intValue]]];
	[currentObject.ticketOfD addObjectsFromArray:
	 [self createTicketsArray:[firstPriceDTotalText.text intValue] withEachCount:[firstPriceDEachText.text intValue]]];
	
	currentObject.priceName=FirstPriceName;

	if(selectedParameters!=nil){
		[selectedParameters release];
		selectedParameters=nil;
	}
	selectedParameters=currentObject;
	[self sendInfo2MainScene:[NSString stringWithFormat:@"%@%@",currentObject.priceName,AClassName] withParameter:selectedParameters];
	[self slideAnimation];
}
-(IBAction)bonusPriceAcquire:(id)sender{
	ParametersObject *currentObject=[ParametersObject new];
	[currentObject.ticketOfA addObjectsFromArray:
	 [self createTicketsArray:[bonusPriceATotalText.text intValue] withEachCount:[bonusPriceAEachText.text intValue]]];
	[currentObject.ticketOfB addObjectsFromArray:
	 [self createTicketsArray:[bonusPriceBTotalText.text intValue] withEachCount:[bonusPriceBEachText.text intValue]]];
	[currentObject.ticketOfC addObjectsFromArray:
	 [self createTicketsArray:[bonusPriceCTotalText.text intValue] withEachCount:[bonusPriceCEachText.text intValue]]];
	[currentObject.ticketOfD addObjectsFromArray:
	 [self createTicketsArray:[bonusPriceDTotalText.text intValue] withEachCount:[bonusPriceDEachText.text intValue]]];
	
	currentObject.priceName=BonusPriceName;
	if(selectedParameters!=nil){
		[selectedParameters release];
		selectedParameters=nil;
	}
	selectedParameters=currentObject;
	[self sendInfo2MainScene:[NSString stringWithFormat:@"%@%@",currentObject.priceName,AClassName] withParameter:selectedParameters];
	[self slideAnimation];
}
#pragma mark -
#pragma mark Private
-(void)slideAnimation{
	if(selectedTextField!=nil)
		[selectedTextField resignFirstResponder];
	
	CGPoint movingPoint;
	movingPoint=(isOpen)?CGPointZero:CGPointMake(0, settingViewFoldHeight);
	CGFloat angle;
	angle=(isOpen)?0.0f:3.14f;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView animateWithDuration:2.0f animations:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	CGAffineTransform transform = CGAffineTransformMakeTranslation(movingPoint.x, movingPoint.y);
	self.view.transform = transform;
	CGAffineTransform angleTransform=CGAffineTransformMakeRotation(angle);
	self.arrowImageView.transform=angleTransform;
	
	[UIView commitAnimations];
	isOpen=!isOpen;
}

-(NSMutableArray*)createTicketsArray:(NSInteger)totalCount withEachCount:(NSInteger)eachCount{
	NSMutableArray *returnArray=[NSMutableArray new];
	if(eachCount<=totalCount && (totalCount>0 && eachCount >0)){
		int last=totalCount%eachCount;
		int num=floor((double)((CGFloat)totalCount/(CGFloat)eachCount));
		for(int i=0;i<num;i++){
			[returnArray enqueue:[NSNumber numberWithInt:eachCount]];
		}
		if (last!=0) {
			[returnArray enqueue:[NSNumber numberWithInt:last]];
		}
	}
	return [returnArray autorelease];
}

-(void)sendInfo2MainScene:(NSString*)priceString withParameter:(ParametersObject*)object{
	NSString *priceLabelString=[Tools caculatePriceString:object];
 	NSMutableDictionary *dataDic=[NSMutableDictionary dictionaryWithObject:priceLabelString forKey:@"priceString"];
	[dataDic setValue:object forKey:@"parameters"];
	
	int aTotal=0;
	int bTotal=0;
	int cTotal=0;
	int dTotal=0;
	
	for(NSNumber *eachNumber in object.ticketOfA)
		aTotal+=[eachNumber intValue];
	for(NSNumber *eachNumber in object.ticketOfB)
		bTotal+=[eachNumber intValue];
	for(NSNumber *eachNumber in object.ticketOfC)
		cTotal+=[eachNumber intValue];
	for(NSNumber *eachNumber in object.ticketOfD)
		dTotal+=[eachNumber intValue];
	
	[dataDic setValue:[NSNumber numberWithInt:aTotal] forKey:@"aTotal"];
	[dataDic setValue:[NSNumber numberWithInt:bTotal] forKey:@"bTotal"];
	[dataDic setValue:[NSNumber numberWithInt:cTotal] forKey:@"cTotal"];
	[dataDic setValue:[NSNumber numberWithInt:dTotal] forKey:@"dTotal"];
	
	[[NSNotificationCenter defaultCenter]postNotificationName:@"ChangePriceName" object:nil userInfo:dataDic];
}
#pragma mark -
@end
