//
//  ExhibitorAddToPSViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorAddToPSViewController.h"
#import "LoginDataObject.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "FcDrawing.h"
#import <EventKit/EventKit.h>
#define cellHeight 42
#define cellWidth 274
#define cellCount 2
#define cellLabel_1_x 8
#define cellLabel_1_y 10
#define cellLabel_1_width 39
#define cellLabel_1_height 21
#define cellLabel_2_x cellLabel_1_x+cellLabel_1_width+6
#define cellLabel_2_y 11
#define cellLabel_2_width cellWidth-cellLabel_2_x
#define cellLabel_2_height 21

@implementation ExhibitorAddToPSViewController
@synthesize exhibitorId;
@synthesize datePicker;
@synthesize inputBgImg;
@synthesize endBtn;
@synthesize startBtn;
@synthesize endDataLabel;
@synthesize selectIntervalLabel;
@synthesize startDataLabel;
@synthesize endLabel;
@synthesize startLabel;
@synthesize titleLabel;
@synthesize iconImg;
@synthesize exhibitorName;
@synthesize area;
@synthesize iconUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*-(void)setArea:(NSString *)_area{
    area= _area;
}
-(NSString*)area{
    return [area copy];
}*/
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
    [self setUIDefault];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [self setIconImg:nil];
    [self setTitleLabel:nil];
    [self setStartLabel:nil];
    [self setEndLabel:nil];
    [self setStartDataLabel:nil];
    [self setSelectIntervalLabel:nil];
    [self setEndDataLabel:nil];
    [self setStartBtn:nil];
    [self setEndBtn:nil];

    [self setDatePicker:nil];
    [self setInputBgImg:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)endTouchDown:(id)sender {
    [endLabel setHighlighted:YES];
    [endDataLabel setHighlighted:YES];
}

- (IBAction)endDragEnter:(id)sender {
    [endLabel setHighlighted:YES];
    [endDataLabel setHighlighted:YES];
}

- (IBAction)endDragout:(id)sender {
    [endLabel setHighlighted:NO];
    [endDataLabel setHighlighted:NO];
}

- (IBAction)startTouchDown:(id)sender {
    [startLabel setHighlighted:YES];
    [startDataLabel setHighlighted:YES];
}

- (IBAction)startDragEnter:(id)sender {
    [startLabel setHighlighted:YES];
    [startDataLabel setHighlighted:YES];
}

- (IBAction)startDragOut:(id)sender {
    [startLabel setHighlighted:NO];
    [startDataLabel setHighlighted:NO];
}

- (IBAction)selectStartDate:(id)sender {
     mode = 0;
    [startLabel setHighlighted:NO];
    [startDataLabel setHighlighted:NO];
    [picker slideUp:YES];

    //datePicker.hidden = NO;
    
}

- (IBAction)selectEndDate:(id)sender {
     mode = 1;
    [endLabel setHighlighted:NO];
    [endDataLabel setHighlighted:NO];
    [picker slideUp:YES];

    //datePicker.hidden = NO;
}

/*- (IBAction)datePickerValueChanged:(id)sender {
    datePicker.hidden = YES;
    if (1==mode ) {
        endDate = [datePicker.date copy];
        currentDate.endTime = [NSString stringWithFormat:@"%.f", [datePicker.date timeIntervalSince1970]*1000];
        endDataLabel.text = [DateUtilty dateStringFull:currentDate.endTime withFormat:@"yyyy/MM/dd E HH:mm"];
        
        
    }else{
        startDate = [datePicker.date copy];
        currentDate.startTime = [NSString stringWithFormat:@"%.f", [datePicker.date timeIntervalSince1970]*1000];
        startDataLabel.text = [DateUtilty dateStringFull:currentDate.startTime withFormat:@"yyyy/MM/dd E HH:mm"];
        
    }

}*/

-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"exhibitor_AddPersonalSchedule",nil);
    titleLabel.text = exhibitorName;
    if ([iconUrl length]>1) {
        QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        [Query uiValueBinding:iconImg withValue:picUrl(iconUrl)];
        [Query release];
    }
    
    startLabel.text = AMLocalizedString(@"exhibitor_PS_Start",nil);
    endLabel.text = AMLocalizedString(@"exhibitor_PS_End",nil);
    selectIntervalLabel.text = AMLocalizedString(@"exhibitor_booking_selectetInterval",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [startDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [endDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [UITuneLayout linkTwoLabel:startLabel fontsize:16 secondLabel:startDataLabel];
    [UITuneLayout linkTwoLabel:endLabel fontsize:16 secondLabel:endDataLabel];
    //[self addBackButton];
    //[self addEditButton];
    [self setBackItem:AMLocalizedString(@"back",nil)];
    [self setRightItem2:AMLocalizedString(@"done",nil)];
    [self setGroupStyleButton];
    currentDate = [DateUtilty new];
    
    //set picker
    picker  = [FcPickerController new];
    [picker isDatePicker];
    picker.delegate = self;
    [self.view addSubview:picker.view];
    picker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif, picker.view.frame.size.width, picker.view.frame.size.height);
}  
-(void) setGroupStyleButton{
    CGRect inputBgRect = CGRectMake(inputBgImg.frame.origin.x, inputBgImg.frame.origin.y, cellWidth, cellHeight*cellCount);
    inputBgImg.frame = inputBgRect;
    [inputBgImg setImage:[TUNinePatchCache imageOfSize:inputBgRect.size forNinePatchNamed:@"group_table"]];
    CGSize btnSize = CGSizeMake(cellWidth, cellHeight);
    UIImage *texture=[FcDrawing drawImageWithPattern:@"group_table_i.png" withSize:btnSize];
    
    CGSize firstSize = [Tools estimateStringSize:startLabel.text withFontSize:16];
    CGSize secondSize = [Tools estimateStringSize:endLabel.text withFontSize:16];
    
    float labelWidth = firstSize.width;
    if (secondSize.width>labelWidth) {
        labelWidth = secondSize.width;
    }

    
    NSMutableArray *btnArray = [NSMutableArray new];
    [btnArray addObject:startBtn];
    [btnArray addObject:endBtn];
    
    NSMutableArray *label1Array = [NSMutableArray new];
    [label1Array addObject:startLabel];
    [label1Array addObject:endLabel];
    
    NSMutableArray *label2Array = [NSMutableArray new];
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
            groupline.frame = CGRectMake(0, i*cellHeight, groupline.frame.size.width, groupline.frame.size.height);
            [inputBgImg addSubview:groupline];
            [groupline release];
        }
    }
    [btnArray release];
    [label1Array release];
    [label2Array release];
}
- (void)viewWillAppear:(BOOL)animated{
    [self clearInputData];
}
-(void)initData{
}
-(void) clearInputData{
    mode =0;
    startDataLabel.text = @"";
    endDataLabel.text =@"";
    if (currentDate) {
        currentDate.startTime=@"";
        currentDate.endTime=@"";
    }
}
-(void)rightItemAction:(id)sender{
    
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
    NSString *sd = currentDate.startTime;
    
    NSString *ed = currentDate.endTime;
    //NSLog(@"sd %@ ,ed %@",sd,ed);
    [Query prepareDic:addExhibitorToPersonalEvent(loginDO.sessionId, exhibitorId,sd,ed )];
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    EKEvent *myEvent=[EKEvent eventWithEventStore:eventStore];
    myEvent.calendar=[eventStore defaultCalendarForNewEvents];
    myEvent.startDate=startDate;
    myEvent.endDate=endDate;
    myEvent.title=titleLabel.text;
    NSLog(@"area %@", self.area);
    myEvent.location=self.area;
    //myEvent.notes=@"光谷測試 備註";
    //myEvent.recurrenceRule=[ProjectTool recurrenceRuleForType:repeatIndex];
    [myEvent setAlarms:[NSArray arrayWithObjects:[EKAlarm alarmWithRelativeOffset:-30],nil]];
    
    //[myEvent release];
    NSError *error=nil;
    EKSpan span=EKSpanThisEvent;
    [eventStore saveEvent:myEvent span:span error:&error];
    [eventStore release];
    //EKEvent eventWithEventStore:
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"revert_ok_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"revert_ok_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
        }else{
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"revert_err_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", [Query getValue:@"message" withIndex:0]]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [Query release];
        
    }	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}

/*-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"selected color %@", [colorArray objectAtIndex:row]);
    datePicker.hidden = YES;
    if (1==mode ) {
        endDate = [datePicker.date copy];
        currentDate.endTime = [NSString stringWithFormat:@"%.f", [datePicker.date timeIntervalSince1970]*1000];
        endDataLabel.text = [DateUtilty dateStringFull:currentDate.endTime withFormat:@"yyyy/MM/dd E HH:mm"];
        
        
    }else{
        startDate = [datePicker.date copy];
        currentDate.startTime = [NSString stringWithFormat:@"%.f", [datePicker.date timeIntervalSince1970]*1000];
        startDataLabel.text = [DateUtilty dateStringFull:currentDate.startTime withFormat:@"yyyy/MM/dd E HH:mm"];
        
    }

    //datePicker.date
    //NSLog(@"selected storeDo %@", storeDo.name);
}*/

- (void) pickerSubmit{
    if (1==mode ) {
        endDate = [picker.datePicker.date copy];
        currentDate.endTime = [NSString stringWithFormat:@"%.f", [picker.datePicker.date timeIntervalSince1970]*1000];
        endDataLabel.text = [DateUtilty dateStringFull:currentDate.endTime];
        
    }else{
        startDate = [picker.datePicker.date copy];
        currentDate.startTime = [NSString stringWithFormat:@"%.f", [picker.datePicker.date timeIntervalSince1970]*1000];
        startDataLabel.text = [DateUtilty dateStringFull:currentDate.startTime];

    }
}
- (void) pickerCancel{
    
}
- (void)dealloc {
    if (startDate) {
        [startDate release];
    }
    if (endDate) {
        [endDate release];
    }
    if (picker) {
        [picker release];
    }
    [iconImg release];
    [iconImg release];
    [titleLabel release];
    [startLabel release];
    [endLabel release];
    [startDataLabel release];
    [selectIntervalLabel release];
    [endDataLabel release];
    [startBtn release];
    [endBtn release];

    [datePicker release];
    [inputBgImg release];
    [currentDate release];
    [super dealloc];
}
@end
