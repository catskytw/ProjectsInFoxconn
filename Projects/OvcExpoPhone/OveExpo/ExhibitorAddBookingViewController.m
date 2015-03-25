//
//  ExhibitorAddBookingViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorAddBookingViewController.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "FcDrawing.h"
#import "LoginDataObject.h"
#define cellHeight 42
#define cellWidth 274
#define cellCount 3
#define cellLabel_1_x 8
#define cellLabel_1_y 10
#define cellLabel_1_width 39
#define cellLabel_1_height 21
#define cellLabel_2_x cellLabel_1_x+cellLabel_1_width+6
#define cellLabel_2_y 11
#define cellLabel_2_width cellWidth-cellLabel_2_x
#define cellLabel_2_height 21
#define date20111102Since1970 1320192000
#define onedaySec 60*60*24
#define remarkMoveY    160
@implementation ExhibitorAddBookingViewController
@synthesize remarkTextField;
@synthesize remarkImg;
@synthesize remarkLabel;
@synthesize inputBgImg;
@synthesize endBtn;
@synthesize dateBtn;
@synthesize startBtn;
@synthesize dateLabel;
@synthesize startLabel;
@synthesize endLabel;
@synthesize endDataLabel;
@synthesize startDataLabel;
@synthesize dateDataLabel;
@synthesize picker;
@synthesize selectedIntervalLabel;

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
    [self initData];
    [self setUIDefault];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSelectedIntervalLabel:nil];
    [self setInputBgImg:nil];
    [self setEndBtn:nil];
    [self setDateBtn:nil];
    [self setStartBtn:nil];
    [self setDateLabel:nil];
    [self setStartLabel:nil];
    [self setEndLabel:nil];
    [self setEndDataLabel:nil];
    [self setStartDataLabel:nil];
    [self setDateDataLabel:nil];
    [self setPicker:nil];
    [self setRemarkLabel:nil];
    [self setRemarkImg:nil];
    [self setRemarkTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)viewWillAppear:(BOOL)animated{
    [self clearInputData];
}
-(void) clearInputData{
    mode =0;
    startDataLabel.text = @"";
    endDataLabel.text =@"";
    dateDataLabel.text = @"";
    //remarkLabel.text = @"";
    remarkTextField.text = @"";
    if (selectTime) {
        selectTime.startTime=@"";
        selectTime.endTime=@"";
    }
}
- (void)dealloc {
    if (selectTime) {
        [selectTime release];
    }
    if (fcPicker) {
        [fcPicker release];
        fcPicker = nil;
    }
    [selectedIntervalLabel release];
    [inputBgImg release];
    [endBtn release];
    [dateBtn release];
    [startBtn release];
    [dateLabel release];
    [startLabel release];
    [endLabel release];
    [endDataLabel release];
    [startDataLabel release];
    [dateDataLabel release];
    [picker release];
    if(backButton){
        [backButton release];
        backButton = nil;
    }
    if(editButton){
        [editButton release];
        editButton = nil;
    }
    [remarkLabel release];
    [remarkImg release];
    [remarkTextField release];
       [super dealloc];
}

- (IBAction)remarkEditingDidBegin:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    self.view.frame = ccRectShift(self.view.frame, CGPointMake(0, -remarkMoveY));
     [UIView commitAnimations];
}

- (IBAction)remarkEditingDidEnd:(id)sender {
    
}

- (IBAction)remarkDidEndOnExit:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    self.view.frame = ccRectShift(self.view.frame, CGPointMake(0, remarkMoveY));
    [remarkTextField resignFirstResponder];
    [UIView commitAnimations];
}

- (IBAction)selectEndTime:(id)sender {
    [endLabel setHighlighted:NO];
    [endDataLabel setHighlighted:NO];
    if ([dateDataLabel.text length]==0) {
        return;
    }
    
    mode = 2;
    [fcPicker.datePicker setDatePickerMode:UIDatePickerModeTime];
    
    [self setDefaultLableColor:endLabel];
    [fcPicker slideUp:YES];
    
}

- (IBAction)selectDate:(id)sender {
    mode = 0;
    [dateLabel setHighlighted:NO];
    [dateDataLabel setHighlighted:NO];
     [fcPicker.datePicker setDatePickerMode:UIDatePickerModeDate];
    fcPicker.datePicker.date = [NSDate dateWithTimeIntervalSince1970:date20111102Since1970];
    [fcPicker.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:date20111102Since1970]];
    [fcPicker.datePicker setMaximumDate:[NSDate dateWithTimeIntervalSince1970:date20111102Since1970+onedaySec*3]];
    [fcPicker slideUp:YES];
    [self setDefaultLableColor:dateLabel];
}

- (IBAction)selectStartTime:(id)sender {
    [startLabel setHighlighted:NO];
    [startDataLabel setHighlighted:NO];
    if ([dateDataLabel.text length]==0) {
        return;
    }
    mode = 1;
    [fcPicker.datePicker setDatePickerMode:UIDatePickerModeTime];
    //picker.hidden = NO;
    [fcPicker slideUp:YES];
    [self setDefaultLableColor:startLabel];
}

- (IBAction)pickerValueChanged:(id)sender {
    //picker.hidden = YES;
    [fcPicker slideUp:NO];
    //NSLog(@"mode %d date %f %@", mode , [picker.date timeIntervalSince1970], [picker.date description]);
    if (mode ==0) {
        selectTime.startTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        dateDataLabel.text =  [DateUtilty dateString:selectTime.startTime];
        
    }else if(mode ==1){
        selectTime.startTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        startDataLabel.text = [DateUtilty dateString:selectTime.startTime];
    }else{
        selectTime.endTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        endDataLabel.text = [DateUtilty dateString:selectTime.endTime];
    }
}


- (IBAction)touchDown:(id)sender {
    if ([sender isEqual:dateBtn]) {
        [dateLabel setHighlighted:YES];
        [dateDataLabel setHighlighted:YES];
    }else if([sender isEqual:startBtn]){
        [startLabel setHighlighted:YES];
        [startDataLabel setHighlighted:YES];
    }else if([sender isEqual:endBtn]){
        [endLabel setHighlighted:YES];
        [endDataLabel setHighlighted:YES];
    }
}

- (IBAction)dragEnter:(id)sender {
    if ([sender isEqual:dateBtn]) {
        [dateLabel setHighlighted:YES];
        [dateDataLabel setHighlighted:YES];
    }else if([sender isEqual:startBtn]){
        [startLabel setHighlighted:YES];
        [startDataLabel setHighlighted:YES];
    }else if([sender isEqual:endBtn]){
        [endLabel setHighlighted:YES];
        [endDataLabel setHighlighted:YES];
    }
}

- (IBAction)dragOut:(id)sender {
    if ([sender isEqual:dateBtn]) {
        [dateLabel setHighlighted:NO];
        [dateDataLabel setHighlighted:NO];
    }else if([sender isEqual:startBtn]){
        [startLabel setHighlighted:NO];
        [startDataLabel setHighlighted:NO];
    }else if([sender isEqual:endBtn]){
        [endLabel setHighlighted:NO];
        [endDataLabel setHighlighted:NO];
    }
}

-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"exhibitorBooking_addReserve",nil);
    dateLabel.text = AMLocalizedString(@"date",nil);
    startLabel.text = AMLocalizedString(@"exhibitor_PS_Start",nil);
    endLabel.text = AMLocalizedString(@"exhibitor_PS_End",nil);
    selectedIntervalLabel.text = AMLocalizedString(@"exhibitor_booking_selectetInterval",nil);
    remarkLabel.text = AMLocalizedString(@"exhibitor_booking_remark",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [startDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [endDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [dateDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [remarkImg setImage:[TUNinePatchCache imageOfSize:remarkImg.frame.size forNinePatchNamed:@"group_table"]];

    
    [UITuneLayout linkTwoLabel:startLabel fontsize:16 secondLabel:startDataLabel];
    [UITuneLayout linkTwoLabel:endLabel fontsize:16 secondLabel:endDataLabel];
    [UITuneLayout linkTwoLabel:dateLabel fontsize:16 secondLabel:dateDataLabel];
    
    [self setDefaultLableColor:dateLabel];
    [self setDefaultLableColor:startLabel];
    [self setDefaultLableColor:endLabel];

    isEdit = YES;
    [self setBackItem:AMLocalizedString(@"back",nil)];
    [self setRightItem2:AMLocalizedString(@"done",nil)];
    
    [self setGroupStyleButton];
    if (!selectTime) {
        selectTime = [DateUtilty new];
    }
    
    //set picker
    fcPicker  = [FcPickerController new];
    fcPicker.delegate = self;
    fcPicker.pickerdelegate = self;
    [fcPicker isDatePicker];
    [self.view addSubview:fcPicker.view];
    fcPicker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif, fcPicker.view.frame.size.width, fcPicker.view.frame.size.height);
}  
-(void)rightItemAction:(id)sender{
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];

    NSString *sd = selectTime.startTime;
    NSString *ed =selectTime.endTime;
    [Query prepareDic:[addReservation(loginDO.sessionId,sd, ed,remarkTextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    @try {
       if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
           NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"done",nil)]; 
           NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"add_ps_msg",nil)]; 
           NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"login_alert_ok", nil)]; 
           UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
           [alert show];
           
       }else{
           NSLog(@"reponse err %@", [Query getValue:@"response" withIndex:0]);
       }
       
   }
   @catch (NSException * e) {
       //NPLogException(e);
   }
   @finally {
       [Query release];
       
   }
    
}
-(void) setGroupStyleButton{
    CGRect inputBgRect = CGRectMake(inputBgImg.frame.origin.x, inputBgImg.frame.origin.y, cellWidth, cellHeight*cellCount);
    inputBgImg.frame = inputBgRect;
    [inputBgImg setImage:[TUNinePatchCache imageOfSize:inputBgRect.size forNinePatchNamed:@"group_table"]];
    CGSize btnSize = CGSizeMake(cellWidth, cellHeight);
    UIImage *texture=[FcDrawing drawImageWithPattern:@"group_table_i.png" withSize:btnSize];
    
    CGSize firstSize = [Tools estimateStringSize:dateLabel.text withFontSize:16];
    CGSize secondSize = [Tools estimateStringSize:startLabel.text withFontSize:16];
    CGSize thirdSize = [Tools estimateStringSize:endLabel.text withFontSize:16];
    
    float labelWidth = firstSize.width;
    if (secondSize.width>labelWidth) {
        labelWidth = secondSize.width;
    }
    if (thirdSize.width>labelWidth) {
        labelWidth = thirdSize.width;
    }
    
    NSMutableArray *btnArray = [NSMutableArray new];
    [btnArray addObject:dateBtn];
    [btnArray addObject:startBtn];
    [btnArray addObject:endBtn];
 
    NSMutableArray *label1Array = [NSMutableArray new];
    [label1Array addObject:dateLabel];
    [label1Array addObject:startLabel];
    [label1Array addObject:endLabel];
    
    NSMutableArray *label2Array = [NSMutableArray new];
    [label2Array addObject:dateDataLabel];
    [label2Array addObject:startDataLabel];
    [label2Array addObject:endDataLabel];
    
    for (int i=0; i<cellCount; i++) {
        UIImage *mask;
        if (i==0) {
            mask=[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"group_table_top_mask"];
            [(UIButton*)[btnArray objectAtIndex:i] setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture] forState:UIControlStateHighlighted];
            

        }else if(i==cellCount-1){
            mask=[TUNinePatchCache imageOfSize:btnSize forNinePatchNamed:@"group_table_down_mask"];
            [(UIButton*)[btnArray objectAtIndex:i] setImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture] forState:UIControlStateHighlighted];
            
        }else {
            [(UIButton*)[btnArray objectAtIndex:i] setImage:texture forState:UIControlStateHighlighted];
            

        }
        CGRect cellFrame = CGRectMake(inputBgRect.origin.x, inputBgRect.origin.y+i*cellHeight, cellWidth, cellHeight);
        [(UIButton*)[btnArray objectAtIndex:i] setFrame:cellFrame];
        
        CGRect cellLabel1Frame = CGRectMake(inputBgRect.origin.x+cellLabel_1_x, inputBgRect.origin.y+i*cellHeight+cellLabel_1_y, labelWidth, cellLabel_1_height);
        [(UIButton*)[label1Array objectAtIndex:i] setFrame:cellLabel1Frame];
        float cellLabel2X = inputBgRect.origin.x+cellLabel_1_x+cellLabel1Frame.size.width+GroupCellLabel_Space;
        CGRect cellLabel2Frame = CGRectMake(cellLabel2X, inputBgRect.origin.y+i*cellHeight+cellLabel_2_y, GroupCellWidth-cellLabel2X+inputBgRect.origin.x, cellLabel_2_height);
        [(UIButton*)[label2Array objectAtIndex:i] setFrame:cellLabel2Frame];
        
        //add seperate line
        if (i!=0) {
            UIImageView *groupline = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(cellWidth, 1) forNinePatchNamed:@"group_table_line"]];
            groupline.frame = CGRectMake(0, cellHeight*i, groupline.frame.size.width, groupline.frame.size.height);
            [inputBgImg addSubview:groupline];
            [groupline release];
        }
    }
    [btnArray release];
    [label1Array release];
    [label2Array release];
}
-(void)setDefaultLableColor:(UILabel*)lbl{
    [lbl setTextColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1]];
}

-(void)initData{
    
    
}

-(void)pickerSubmit{
    if (mode ==0) {
        selectTime.startTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        dateDataLabel.text =  [DateUtilty dateString:selectTime.startTime];
        
    }else if(mode ==1){
        selectTime.startTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        startDataLabel.text = [DateUtilty timeString:selectTime.startTime];
    }else{
        selectTime.endTime = [NSString stringWithFormat:@"%.f", [fcPicker.datePicker.date timeIntervalSince1970]*1000];
        endDataLabel.text = [DateUtilty timeString:selectTime.endTime];
    }

}

@end
