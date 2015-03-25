//
//  RegisterInfoVeiwController.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "RegisterRecInfoVeiwController.h"
#import "QueryPattern.h"
#import "DummyData.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "FcGroupTableCell.h"
#import "FcConfig.h"
#import "Tools.h"
#import "NinePatch.h"

#define cellCount 8
#define heightDiff 0
@implementation RegisterRecInfoVeiwController
@synthesize recordId;
@synthesize dataTable;
@synthesize hospitalContentLabel;
@synthesize timeContentLabel;
@synthesize AMPMContentLabel;
@synthesize departContentLabel;
@synthesize doctorContentLabel;
@synthesize numberContentLabel;
@synthesize roomContentLabel;
@synthesize progressContentLabel;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveResetRegisterRecInfoNotification:) name:RESET_REGISTERREC_INFO object:nil];
    [self setUIDefault];
    [self initContentField];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [self initData];
    [dataTable reloadData];
}

- (void)viewDidUnload
{
    [self setDataTable:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    if (dataArray) {
        [dataArray release];
        dataArray = nil;
    }
    if (labelArray) {
        [labelArray release];
        labelArray = nil;
    }
    if (hospitalContentLabel) {
        [hospitalContentLabel release];
        hospitalContentLabel = nil;
    }
    if (timeContentLabel) {
        [timeContentLabel release];
        timeContentLabel = nil;
    }
    if (AMPMContentLabel) {
        [AMPMContentLabel release];
        AMPMContentLabel = nil;
    }
    if (departContentLabel) {
        [departContentLabel release];
        departContentLabel = nil;
    }
    if (roomContentLabel) {
        [roomContentLabel release];
        roomContentLabel = nil;
    }
    if (doctorContentLabel) {
        [doctorContentLabel release];
        doctorContentLabel = nil;
    }
    if (doctorContentLabel) {
        [doctorContentLabel release];
        doctorContentLabel = nil;
    }
    if (numberContentLabel) {
        [numberContentLabel release];
        numberContentLabel = nil;
    }
    if (progressContentLabel) {
        [progressContentLabel release];
        progressContentLabel = nil;
    }
    [dataTable release];
    [super dealloc];
}

#pragma -
#pragma mark -  DelegateMethod

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *m_CellIdentifier = @"FcGroupTableCell";
    
    FcGroupTableCell *m_cell = [tableView dequeueReusableCellWithIdentifier:m_CellIdentifier];
    if (m_cell == nil) {
        m_cell = [[[FcGroupTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:m_CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    m_cell.textLabel.text= AMLocalizedString([labelArray objectAtIndex: indexPath.row],nil);
    //NSLog(@"cell.textLabel.frame %f",cell.textLabel.frame.origin.x);
    m_cell.textLabel.frame = CGRectMake(GroupCellLabelDiff_Left, m_cell.textLabel.frame.origin.y, m_cell.textLabel.frame.size.width, m_cell.textLabel.frame.size.height);
    //NSLog(@"cell.textLabel.frame %f",cell.textLabel.frame.origin.x);
    [m_cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [m_cell addSubview:[contentArray objectAtIndex: indexPath.row]];
    if (0==indexPath.row) {
        m_cell.mode =FcGroupTableCellMode_TOP;
    }else if(indexPath.row == cellCount-1){
        m_cell.mode = FcGroupTableCellMode_BUTTON;
    }else{
        m_cell.mode = FcGroupTableCellMode_MIDDLE;
    }
    [m_cell setLayout];
    [m_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return m_cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return GroupCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self setSelectedRowColor:indexPath.row];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    for(UILabel *label in contentArray){
        [label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    }
     */
}
#pragma -
#pragma mark -  PrivateMethod

-(void)initData{
    [DummyData setRegisterRecInfoData:contentArray];
}
-(void) setUIDefault{
    self.title = AMLocalizedString(@"registerRec",nil);
    [super setUIDefault];
    self.navigationItem.hidesBackButton = YES;
    labelArray = [[NSArray alloc] initWithObjects:@"Register_Hospital",@"Register_Time",@"Register_AMPM", @"Register_Depart", @"Register_Room", @"Register_Doctor", @"Register_Number", @"Register_Progress", nil];
    float tableHeight = GroupCellHeight*cellCount+heightDiff;
    CGSize tablesize= CGSizeMake(274, tableHeight);
    UIImageView *tableBackgroundImg = [UIImageView new];
    [tableBackgroundImg setImage: [TUNinePatchCache imageOfSize:tablesize forNinePatchNamed:@"group_table"]];
    dataTable.frame = CGRectMake(24, 15, tablesize.width, tableHeight);
    
    tableBackgroundImg.frame = CGRectMake(0, 0, dataTable.frame.size.width, tableHeight);
    [dataTable setBackgroundView:tableBackgroundImg];
    [tableBackgroundImg release];

}

-(void) initContentField{
    CGSize _stringSize=[Tools estimateStringSize:AMLocalizedString(@"Register_Hospital",nil) withFontSize:16.0f withMaxSize:ccs(100, 30)];
    CGRect lblRect = CGRectMake(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space, 0, GroupCellWidth-(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space), GroupCellHeight);
    
    hospitalContentLabel = [[UILabel alloc] initWithFrame:lblRect];
    timeContentLabel  = [[UILabel alloc] initWithFrame:lblRect];
    AMPMContentLabel = [[UILabel alloc] initWithFrame:lblRect];
    departContentLabel  = [[UILabel alloc] initWithFrame:lblRect];
    roomContentLabel = [[UILabel alloc] initWithFrame:lblRect];
    doctorContentLabel  = [[UILabel alloc] initWithFrame:lblRect];
    numberContentLabel = [[UILabel alloc] initWithFrame:lblRect];
    progressContentLabel  = [[UILabel alloc] initWithFrame:lblRect];
    
    hospitalContentLabel.tag = 0;
    timeContentLabel.tag = 1;
    AMPMContentLabel.tag = 2;
    departContentLabel.tag = 3;
    roomContentLabel.tag = 4;
    doctorContentLabel.tag = 5;
    numberContentLabel.tag = 6;
    progressContentLabel.tag = 7;
        
    contentArray = [[NSArray alloc] initWithObjects:hospitalContentLabel,timeContentLabel, AMPMContentLabel, departContentLabel, roomContentLabel, doctorContentLabel, numberContentLabel, progressContentLabel, nil];
    for (int i=0; i<[contentArray count]; i++) {
        if ([[contentArray objectAtIndex:i] isKindOfClass: [UILabel class]]) {
            UILabel *label = [contentArray objectAtIndex:i];
            [label setBackgroundColor:[UIColor clearColor]];
            label.textAlignment = UITextAlignmentLeft;
            [label setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
            [label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
        }
    }
}

-(void)setSelectedRowColor:(int)row{
    for (int i=0; i<[contentArray count]; i++) {
        if ([[contentArray objectAtIndex:i] isKindOfClass: [UILabel class]]) {
            UILabel *label = [contentArray objectAtIndex:i];
            if (row == label.tag) {
                [label setTextColor:[UIColor whiteColor]];
            }else{
                [label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
            }
        }
    }
}
-(void)receiveResetRegisterRecInfoNotification:(NSNotification*)notification{
    for(UILabel *label in contentArray){
        [label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    }
}
@end
