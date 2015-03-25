//
//  RegisterInfoTableViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import "FcGroupTableCell.h"
#import "RegisterInfoTableViewController.h"
#import "RegisterViewController.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "Tools.h"

#define cellCount 17
#define heightDiff 21

@implementation RegisterInfoTableViewController
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize nickNameTextField;
@synthesize sexContentLabel;
@synthesize jobTitleTextField;
@synthesize departTextField;
@synthesize companyTextField;
@synthesize countryContentLabel;
@synthesize provinceTextField;
@synthesize cityTextField;
@synthesize addressTextField;
@synthesize zipTextField;
@synthesize telTextField;
@synthesize faxTextField;
@synthesize mobileTextField;
@synthesize emailTextField;
@synthesize websiteTextField;
@synthesize rootController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    labelArray = [[NSArray alloc] initWithObjects:@"firstname",@"lastname",@"nickname", @"sex", @"job", @"depart", @"company", @"country", @"province", @"city", @"address", @"zip", @"tel", @"fax", @"mobile", @"email", @"website",  nil];
    [self initContentField];
    
    float tableHeight = GroupCellHeight*cellCount+heightDiff;
    CGSize tablesize= CGSizeMake(274, tableHeight);
    UIImageView *tableBackgroundImg = [UIImageView new];
    [tableBackgroundImg setImage: [TUNinePatchCache imageOfSize:tablesize forNinePatchNamed:@"group_table"]];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, tablesize.width, tableHeight);
    
    tableBackgroundImg.frame = CGRectMake(0, 0, self.view.frame.size.width, tableHeight);
    [(UITableView*)self.view setBackgroundView:tableBackgroundImg];
    
    [tableBackgroundImg release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//初始化 內容區域 輸入框或跳出picker的Label
-(void) initContentField{
    CGSize _stringSize=[Tools estimateStringSize:AMLocalizedString(@"zip",nil) withFontSize:16.0f withMaxSize:ccs(100, 30)];
    CGRect tfRect = CGRectMake(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space, GroupCellLabelY_Font16, GroupCellWidth-(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space), 30);
    CGRect lblRect = CGRectMake(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space, 0, GroupCellWidth-(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space), GroupCellHeight);
    firstNameTextField = [[UITextField alloc] initWithFrame:tfRect];
    lastNameTextField = [[UITextField alloc] initWithFrame:tfRect];
    nickNameTextField = [[UITextField alloc] initWithFrame:tfRect];
    jobTitleTextField = [[UITextField alloc] initWithFrame:tfRect];
    departTextField = [[UITextField alloc] initWithFrame:tfRect];
    companyTextField = [[UITextField alloc] initWithFrame:tfRect];
    provinceTextField = [[UITextField alloc] initWithFrame:tfRect];
    cityTextField = [[UITextField alloc] initWithFrame:tfRect];
    addressTextField = [[UITextField alloc] initWithFrame:tfRect];
    zipTextField = [[UITextField alloc] initWithFrame:tfRect];
    telTextField = [[UITextField alloc] initWithFrame:tfRect];
    faxTextField = [[UITextField alloc] initWithFrame:tfRect];
    mobileTextField = [[UITextField alloc] initWithFrame:tfRect];
    emailTextField = [[UITextField alloc] initWithFrame:tfRect];
    websiteTextField = [[UITextField alloc] initWithFrame:tfRect];
    countryContentLabel = [[UILabel alloc] initWithFrame:lblRect];
    sexContentLabel  = [[UILabel alloc] initWithFrame:lblRect];
    
    firstNameTextField.tag = 0;
    lastNameTextField.tag = 1;
    nickNameTextField.tag = 2;
    sexContentLabel.tag = 3;
    jobTitleTextField.tag = 4;
    departTextField.tag = 5;
    companyTextField.tag = 6;
    countryContentLabel.tag = 7;
    provinceTextField.tag = 8;
    cityTextField.tag = 9;
    addressTextField.tag = 10;
    zipTextField.tag = 11;
    telTextField.tag = 12;
    faxTextField.tag = 13;
    mobileTextField.tag = 14;
    emailTextField.tag = 15;
    websiteTextField.tag = 16;
    
    contentArray = [[NSArray alloc] initWithObjects:firstNameTextField,lastNameTextField, nickNameTextField, sexContentLabel, jobTitleTextField, departTextField, companyTextField, countryContentLabel, provinceTextField, cityTextField, addressTextField, zipTextField, telTextField, faxTextField, mobileTextField, emailTextField, websiteTextField, nil];
    for (int i=0; i<[contentArray count]; i++) {
        if ([[contentArray objectAtIndex:i] isKindOfClass: [UITextField class]]) {
            UITextField *tf = [contentArray objectAtIndex:i];
            //[tf setBorderStyle:UITextBorderStyleNone];
            [tf addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [tf addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            tf.textAlignment = UITextAlignmentLeft;
            [tf setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
            [tf setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
            
        }else if ([[contentArray objectAtIndex:i] isKindOfClass: [UILabel class]]) {
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
        if ([[contentArray objectAtIndex:i] isKindOfClass: [UITextField class]]) {
            UITextField *tf = [contentArray objectAtIndex:i];
            if (row == tf.tag) {
                [tf setTextColor:[UIColor whiteColor]];
            }else{
                [tf setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
            }
        }else if ([[contentArray objectAtIndex:i] isKindOfClass: [UILabel class]]) {
            UILabel *label = [contentArray objectAtIndex:i];
            if (row == label.tag) {
                [label setTextColor:[UIColor whiteColor]];
            }else{
                [label setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
            }
        }
    }

}
-(void)editingDidBegin:(id)sender{
	
    UITextField* tf = (UITextField*)sender;
    NSIndexPath *indexPath = [(UITableView *)self.view indexPathForCell: (UITableViewCell *)tf.superview];


	NSLog(@"%@ %d",((UITableViewCell *) tf.superview).textLabel.text,indexPath.row);
    currentTextField = tf;
    [rootController setScrollViewPoint:indexPath.row*GroupCellHeight];
}
-(void)editingDidEndOnExit:(id)sender{
	[rootController checkNeededTextField];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FcGroupTableCell";
    
    FcGroupTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[FcGroupTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text= AMLocalizedString([labelArray objectAtIndex: indexPath.row],nil);
    //NSLog(@"cell.textLabel.frame %f",cell.textLabel.frame.origin.x);
    cell.textLabel.frame = CGRectMake(GroupCellLabelDiff_Left, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
     //NSLog(@"cell.textLabel.frame %f",cell.textLabel.frame.origin.x);
    [cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [cell addSubview:[contentArray objectAtIndex: indexPath.row]];
    if (0==indexPath.row) {
        cell.mode =FcGroupTableCellMode_TOP;
    }else if(indexPath.row == cellCount-1){
        cell.mode = FcGroupTableCellMode_BUTTON;
    }else{
        cell.mode = FcGroupTableCellMode_MIDDLE;
    }
    [cell setLayout];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return GroupCellHeight;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    //國家
    if (indexPath.row ==7) {
        rootController.pickerType = PICKER_COUNTRY;
        [rootController showPicker];
        [rootController setScrollViewPoint:indexPath.row*GroupCellHeight];
    }else if(indexPath.row ==3){
        rootController.pickerType = PICKER_SEX;
        [rootController showPicker];
        [rootController setScrollViewPoint:indexPath.row*GroupCellHeight];
    }
    [self setSelectedRowColor:indexPath.row];
    [currentTextField resignFirstResponder];
}

	
- (void)dealloc {
    if (firstNameTextField) {
        [firstNameTextField release];
    }
    if (lastNameTextField) {
        [lastNameTextField release];
    }
    if (nickNameTextField) {
        [nickNameTextField release];
    }
    if (sexContentLabel) {
        [sexContentLabel release];
    }  
    if (jobTitleTextField) {
        [jobTitleTextField release];
    }
    if (departTextField) {
        [departTextField release];
    }  
    if (companyTextField) {
        [companyTextField release];
    }
    if (countryContentLabel) {
        [countryContentLabel release];
    }  
    if (cityTextField) {
        [cityTextField release];
    }
    if (addressTextField) {
        [addressTextField release];
    }  
    if (zipTextField) {
        [zipTextField release];
    }
    if (telTextField) {
        [telTextField release];
    }  
    if (faxTextField) {
        [faxTextField release];
    }
    if (mobileTextField) {
        [mobileTextField release];
    }  
    if (emailTextField) {
        [emailTextField release];
    }
    if (websiteTextField) {
        [websiteTextField release];
    }  
    [labelArray release];
    [contentArray release];
    [super dealloc];
}
@end
