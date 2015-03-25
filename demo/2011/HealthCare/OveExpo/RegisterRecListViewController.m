//
//  RegisterListViewController.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "RegisterRecListViewController.h"
#import "QueryPattern.h"
#import "DummyData.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "RegisterRecListDataObject.h"
#import "RegisterRecListCell.h"
#import "RegisterRecInfoVeiwController.h"
#define cellHeight 72

@implementation RegisterRecListViewController
@synthesize dataTable;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDataTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [self initData];
    [dataTable reloadData];
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
    [dataTable release];
    [super dealloc];
}

#pragma -
#pragma mark -  DelegateMethod

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RegisterRecListCell *m_cell = (RegisterRecListCell *)[tableView dequeueReusableCellWithIdentifier:@"RegisterRecListCell"];
    if (m_cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RegisterRecListCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        m_cell = [topLevelObjects objectAtIndex:0];
        
	}
    
    [m_cell setUIDefault];
    [m_cell setDAO:(RegisterRecListDataObject *)[dataArray objectAtIndex:indexPath.row]];
    
	return m_cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    RegisterRecListDataObject *m_rdo = (RegisterRecListDataObject *)[dataArray objectAtIndex:indexPath.row];
    RegisterRecInfoVeiwController *m_info = [RegisterRecInfoVeiwController new];
    m_info.recordId = m_rdo.recordId;
    [m_info setBackItem:AMLocalizedString(@"back",nil)];
    [[self navigationController] pushViewController:m_info animated:YES];
}

#pragma -
#pragma mark -  PrivateMethod

-(void)initData{
    if(!dataArray)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];
    [DummyData addRegisterRecData:dataArray];
}
-(void) setUIDefault{
    self.title = AMLocalizedString(@"registerRec",nil);
    [super setUIDefault];
    self.navigationItem.hidesBackButton = YES;
}


@end
