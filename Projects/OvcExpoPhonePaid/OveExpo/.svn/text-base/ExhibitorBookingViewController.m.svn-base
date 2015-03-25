//
//  ExhibitorBookingViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorBookingViewController.h"
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
#define cellCount 2
#define cellLabel_1_x 8
#define cellLabel_1_y 12
#define cellLabel_1_width 39
#define cellLabel_1_height 21
#define cellLabel_2_x cellLabel_1_x+cellLabel_1_width+6
#define cellLabel_2_y 10
#define cellLabel_2_width cellWidth-cellLabel_2_x
#define cellLabel_2_height 21
@implementation ExhibitorBookingViewController


@synthesize intervalDataLabel;
@synthesize dateDataLabel;
@synthesize intervalLabel;
@synthesize dateLabel;
@synthesize intervalBtn;
@synthesize dateBtn;
@synthesize picker;
@synthesize iconImg;
@synthesize exhibitorLabel;
@synthesize selectIntervalLabel;
@synthesize reverseBtn;
@synthesize seperateImg;
@synthesize btnBgImg;
@synthesize inputBgImg;
@synthesize exhibitorName;
@synthesize iconUrl;
@synthesize exhibitorId;

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
    currentDateIdx = 0;
    currentDateId = @"";
    [self setUIDefault];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [self clearInputData];
}
-(void) clearInputData{
    mode =0;
    dateDataLabel.text = @"";
    intervalDataLabel.text =@"";
    [remarkLabel setText:AMLocalizedString(@"exhibitor_booking_remark",nil)];
    if (currentDate) {
        currentDate.startTime=@"";
        currentDate.endTime=@"";
    }
}
-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"exhibitor_booking",nil);
    exhibitorLabel.text = exhibitorName;
    //NSLog(@"exhibitorName %@",exhibitorName);
    
    if ([iconUrl length]>1) {
        QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        [Query uiValueBinding:iconImg withValue:picUrl(iconUrl)];
        [Query release];
    }
    
    selectIntervalLabel.text = AMLocalizedString(@"exhibitor_booking_selectetInterval",nil);
    intervalLabel.text = AMLocalizedString(@"exhibitor_booking_Interval",nil);
    dateLabel.text = AMLocalizedString(@"exhibitor_booking_date", nil);
    [reverseBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:reverseBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [reverseBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:reverseBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [reverseBtn setTitle:AMLocalizedString(@"exhibitor_booking_reverse",nil) forState:UIControlStateNormal];
     [reverseBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [remarkLabel setText:AMLocalizedString(@"exhibitor_booking_remark",nil)];
    
    [seperateImg setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    
    [btnBgImg setImage:[TUNinePatchCache imageOfSize:btnBgImg.frame.size forNinePatchNamed:@"bg_black"]];
    
    [self setGroupStyleButton];        
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [dateDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [intervalDataLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [UITuneLayout linkTwoLabel:dateLabel fontsize:16 secondLabel:dateDataLabel];
    [UITuneLayout linkTwoLabel:intervalLabel fontsize:16 secondLabel:intervalDataLabel];
    //[self addBackButton];
    [self setBackItem:AMLocalizedString(@"back",nil)];
    //set picker
    fcPicker  = [FcPickerController new];
    fcPicker.delegate = self;
    fcPicker.pickerdelegate = self;
    fcPicker.dataSource = self;
    [self.view addSubview:fcPicker.view];
    fcPicker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif, fcPicker.view.frame.size.width, fcPicker.view.frame.size.height);

}   
-(void) setGroupStyleButton{
    CGRect inputBgRect = CGRectMake(inputBgImg.frame.origin.x, inputBgImg.frame.origin.y, cellWidth, cellHeight*cellCount);
    inputBgImg.frame = inputBgRect;
    [inputBgImg setImage:[TUNinePatchCache imageOfSize:inputBgRect.size forNinePatchNamed:@"group_table"]];
    CGSize btnSize = CGSizeMake(cellWidth, cellHeight);
    UIImage *texture=[FcDrawing drawImageWithPattern:@"group_table_i.png" withSize:btnSize];
    
    NSMutableArray *btnArray = [NSMutableArray new];
    [btnArray addObject:dateBtn];
    [btnArray addObject:intervalBtn];
    
    NSMutableArray *label1Array = [NSMutableArray new];
    [label1Array addObject:dateLabel];
    [label1Array addObject:intervalLabel];
    
    NSMutableArray *label2Array = [NSMutableArray new];
    [label2Array addObject:dateDataLabel];
    [label2Array addObject:intervalDataLabel];

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
        
        CGRect cellLabel1Frame = CGRectMake(inputBgRect.origin.x+cellLabel_1_x, inputBgRect.origin.y+i*cellHeight+cellLabel_1_y, cellLabel_1_width, cellLabel_1_height);
        NSLog(@"cellLabel1Frame y %f", cellLabel1Frame.origin.y);
        [(UIButton*)[label1Array objectAtIndex:i] setFrame:cellLabel1Frame];
        
        CGRect cellLabel2Frame = CGRectMake(inputBgRect.origin.x+cellLabel_2_x, inputBgRect.origin.y+i*cellHeight+cellLabel_2_y, cellLabel_2_width, cellLabel_2_height);
        NSLog(@"cellLabel2Frame y %f", cellLabel2Frame.origin.y);
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


-(void)initData{
    if (!sectionArray) {
        sectionArray  = [NSMutableArray new]; 
    }
    if (!dataArray) {
        dataArray = [NSMutableArray new];        
    }
    //getOpenReservationListByExhibitorId(x,y)
    NSMutableArray *array = [NSMutableArray new];
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getOpenReservationListByExhibitorId(loginDO.sessionId, exhibitorId)];
    //{"response":"0","reservationList":[{"children":[{"id":"A356E3AD-66F6-4353-BA55-86594BE99647","startDate":"Timestamp(1320199200000)","endDate":"Timestamp(1320206400000)","notes":"測試資料01"},{"id":"7E9E9FAB-994D-4981-A58D-8B75B8BB9DA9","startDate":"Timestamp(1320213600000)","endDate":"Timestamp(1320217200000)","notes":"測試資料02"}],"date":"Date(1320163200000)"}]}
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            //NSLog(@"number %d",[Query getNumberForKey:@"children"]);
            int number = [Query getNumberForKey:@"children"];
            for (int i=0; i< number  ; i++) {
                DateUtilty *Datedao = [DateUtilty new];
                Datedao.startTime = [UITuneLayout getTimestamp:[Query getValue:@"date" withIndex:i] withKey:@"date"];
                [sectionArray addObject:Datedao];
                [Datedao release];
                //id childrennode= [Query getObjectUnderNode:@"children" withIndex:i];
                int idCount = [[Query getObjectUnderNode:@"children" withIndex:i] count];
                NSMutableArray *dataInfoArray = [NSMutableArray new];
                for (int j=0; j< idCount  ; j++) {
                    DateUtilty *dao = [DateUtilty new];
                    dao.dateId = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].id" ,i,j]];
                    
                    dao.note = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].notes" ,i,j]];
                    dao.startTime = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].startDate" ,i,j]] withKey:@"timestamp"];
                    dao.endTime = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].endDate" ,i,j]] withKey:@"timestamp"];
                    [dataInfoArray addObject:dao];
                    NSLog(@"start %@ end  %@",dao.startTime,dao.endTime);
                    [dao release];
                }
                //NSLog(@"idCount %d", idCount);
                [dataArray addObject:dataInfoArray];
                [dataInfoArray release];
            }
            
        }else{
            
        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [Query release];
        
    }

    /*[dateArray addObject:@"2011年11月2日(三)"];
    [dateArray addObject:@"2011年11月3日(四)"];
    [dateArray addObject:@"2011年11月4日(五)"];
    [dateArray addObject:@"2011年11月5日(六)"];
    
    [intervalArray addObject:@"10:00 - 11:00"];
    [intervalArray addObject:@"11:00 - 12:00"];
    [intervalArray addObject:@"13:00 - 14:00"];
    [intervalArray addObject:@"14:00 - 15:00"];
    [intervalArray addObject:@"15:00 - 16:00"];
    [intervalArray addObject:@"16:00 - 17:00"];*/
}
- (void)viewDidUnload
{
    [self setSeperateImg:nil];
    [self setBtnBgImg:nil];
    [self setPicker:nil];

    [self setIconImg:nil];
    [self setExhibitorLabel:nil];
    [self setSelectIntervalLabel:nil];
    [remarkLabel release];
    remarkLabel = nil;
    [self setDateBtn:nil];
    [self setIntervalBtn:nil];
    [self setDateLabel:nil];
    [self setIntervalLabel:nil];
    [self setDateDataLabel:nil];
    [self setIntervalDataLabel:nil];
    [self setReverseBtn:nil];
    [self setInputBgImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)datePicker:(id)sender {
    [dateLabel setHighlighted:NO];
    [dateDataLabel setHighlighted:NO];
    if ([sectionArray count]) {
        mode = 0;
        [fcPicker.picker reloadAllComponents];
        [fcPicker slideUp:YES];
        //[picker reloadAllComponents];
        //picker.hidden = NO;
        
    }
}

- (IBAction)intervalPicker:(id)sender {
    [intervalLabel setHighlighted:NO];
    [intervalDataLabel setHighlighted:NO];
    if ([dateDataLabel.text length]>0&&[dataArray count]>0&&[[dataArray objectAtIndex:currentDateIdx]count]) {
        mode =1 ;
        [fcPicker.picker reloadAllComponents];
        [fcPicker slideUp:YES];
        //[picker reloadAllComponents];
        //picker.hidden = NO;
    }
}

- (IBAction)reverse:(id)sender {
    if ([currentDateId length]>0) {
        QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        LoginDataObject *loginDO = [LoginDataObject sharedInstance];
        [Query prepareDic:reserveExhibitor(loginDO.sessionId, exhibitorId,currentDateId)];

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
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (1==mode ) {
        return [[dataArray objectAtIndex:currentDateIdx ] count];
    }else{
        return [sectionArray count];
    }

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (1==mode ) {
        return [[[dataArray objectAtIndex:currentDateIdx ] objectAtIndex:row] timeSectionString];
    }else{
        return [[sectionArray objectAtIndex:row] dateString];
    }

    
}

-(void)linkTwoLabel:(UILabel*)first fontsize:(int) fsize secondLabel:(UILabel*)second{
    CGSize firstSize = [Tools estimateStringSize:first.text withFontSize:fsize];
    CGRect firstRect = first.frame;
    firstRect.size = firstSize;
    first.frame = firstRect;
    
    CGRect secondRect = second.frame;
    secondRect.origin.x = firstRect.origin.x + firstRect.size.width;
    second.frame = secondRect;
}

/*-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"selected color %@", [colorArray objectAtIndex:row]);
    pickerView.hidden = YES;
    if (1==mode ) {
        //NSLog(@"interval  %@", [intervalArray objectAtIndex:row]);
        DateUtilty* dao = [[dataArray objectAtIndex:currentDateIdx]objectAtIndex:row];
        intervalDataLabel.text = [dao timeSectionString];
        currentDateId = dao.dateId;
        remarkLabel.text = dao.note;
        currentDate = dao;
        //NSLog(@"remarkLabel.frame.size.width%f", remarkLabel.frame.size.width);
        CGSize infoSize = [remarkLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14] constrainedToSize:CGSizeMake(remarkLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
        //NSLog(@"infoSize.size.width%f", infoSize.width);
        remarkLabel.frame = CGRectMake(remarkLabel.frame.origin.x, remarkLabel.frame.origin.y, remarkLabel.frame.size.width, infoSize.height);
    }else{
        //NSLog(@"date  %@", [dateArray objectAtIndex:row]);
        dateDataLabel.text = [[sectionArray objectAtIndex:row] dateString];
        int i =0;
        for (NSMutableArray* arr in dataArray) {
            if ( [[sectionArray objectAtIndex:row] isEqualeToDate: ((DateUtilty*)[arr objectAtIndex:0]).startTime]) {
                currentDateIdx = i;
                
                break;
            }
            i++;
        }
    }

    //NSLog(@"selected storeDo %@", storeDo.name);
}*/

- (void) pickerSubmit{
    int row = [fcPicker.picker selectedRowInComponent:0];
    if (1==mode ) {
        //NSLog(@"interval  %@", [intervalArray objectAtIndex:row]);
        DateUtilty* dao = [[dataArray objectAtIndex:currentDateIdx]objectAtIndex:row];
        
        intervalDataLabel.text = [dao timeSectionString];
        currentDateId = dao.dateId;
        remarkLabel.text = dao.note;
        currentDate = dao;
        //NSLog(@"remarkLabel.frame.size.width%f", remarkLabel.frame.size.width);
        CGSize infoSize = [remarkLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14] constrainedToSize:CGSizeMake(remarkLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
        //NSLog(@"infoSize.size.width%f", infoSize.width);
        remarkLabel.frame = CGRectMake(remarkLabel.frame.origin.x, remarkLabel.frame.origin.y, remarkLabel.frame.size.width, infoSize.height);
        
        
    }else{
        //NSLog(@"date  %@", [dateArray objectAtIndex:row]);
        dateDataLabel.text = [[sectionArray objectAtIndex:row] dateString];
        currentDateIdx = row;
        intervalDataLabel.text =@"";
        [remarkLabel setText:AMLocalizedString(@"exhibitor_booking_remark",nil)];
        /*int i =0;
        for (NSMutableArray* arr in dataArray) {
            if ( [[sectionArray objectAtIndex:row] isEqualeToDate: ((DateUtilty*)[arr objectAtIndex:0]).startTime]) {
                currentDateIdx = i;
                
                break;
            }
            i++;
        }*/
    }
}
- (void) pickerCancel{
    
}
- (void)dealloc {

    if (fcPicker) {
        [fcPicker release];
        fcPicker = nil;
    }
    [seperateImg release];
    [btnBgImg release];
    [picker release];
    [iconImg release];
    [exhibitorLabel release];
    [selectIntervalLabel release];
    [remarkLabel release];
    [dateBtn release];
    [intervalBtn release];
    [dateLabel release];
    [intervalLabel release];
    [dateDataLabel release];
    [intervalDataLabel release];
    [reverseBtn release];
    [inputBgImg release];
    [super dealloc];
}
- (IBAction)dateBtnTouchDown:(id)sender {
    [dateLabel setHighlighted:YES];
    [dateDataLabel setHighlighted:YES];
}

- (IBAction)dateBtnDragEnter:(id)sender {
    [dateLabel setHighlighted:YES];
    [dateDataLabel setHighlighted:YES];
}

- (IBAction)dateBtnDragOutside:(id)sender {
    [dateLabel setHighlighted:NO];
    [dateDataLabel setHighlighted:NO];
}

- (IBAction)intervalBtnDragOutside:(id)sender {
    [intervalLabel setHighlighted:NO];
    [intervalDataLabel setHighlighted:NO];
}


- (IBAction)intervalBtnTouchDown:(id)sender {
    [intervalLabel setHighlighted:YES];
    [intervalDataLabel setHighlighted:YES];
}



- (IBAction)intervalBtnDragEnter:(id)sender {
    [dateLabel setHighlighted:YES];
    [dateDataLabel setHighlighted:YES];
}


@end
