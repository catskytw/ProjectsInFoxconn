//
//  RegisterAccountTableViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "RegisterAccountTableViewController.h"
#import "FcGroupTableCell.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "Tools.h"
#import "RegisterViewController.h"
#define cellCount 2
#define heightDiff 21
@implementation RegisterAccountTableViewController
@synthesize accountTextField,passwordTextField;
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
    //init table
    float tableHeight = GroupCellHeight*cellCount+heightDiff;
    CGSize tablesize= CGSizeMake(274, tableHeight);
    UIImageView *tableBackgroundImg = [UIImageView new];
    [tableBackgroundImg setImage: [TUNinePatchCache imageOfSize:tablesize forNinePatchNamed:@"group_table"]];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, tablesize.width, tableHeight);
    NSLog(@"table height %@", self.view.frame.size.height);
    tableBackgroundImg.frame = CGRectMake(0, 0, self.view.frame.size.width, tableHeight);
    [(UITableView*)self.view setBackgroundView:tableBackgroundImg];

    [tableBackgroundImg release];
    CGSize _stringSize=[Tools estimateStringSize:AMLocalizedString(@"zip",nil) withFontSize:16.0f withMaxSize:ccs(100, 30)];
    CGRect tfRect = CGRectMake(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space, GroupCellLabelY_Font16, GroupCellWidth-(GroupCellLabelDiff_Left+_stringSize.width+GroupCellLabel_Space), 30);
    //init TextField
    accountTextField = [[UITextField alloc] initWithFrame:tfRect];
    [accountTextField setBorderStyle:UITextBorderStyleNone];
    [accountTextField addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [accountTextField addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
	accountTextField.textAlignment = UITextAlignmentLeft;
    [accountTextField setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [accountTextField setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [accountTextField addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEnd];
    accountTextField.tag =0;
    passwordTextField = [[UITextField alloc] initWithFrame:tfRect];
    [passwordTextField setBorderStyle:UITextBorderStyleNone];
    [passwordTextField addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [passwordTextField addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [passwordTextField addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEnd];
    
	passwordTextField.textAlignment = UITextAlignmentLeft;
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [passwordTextField setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    passwordTextField.tag=1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)editingDidBegin:(id)sender{
	//[(UITextField*)sender setTextColor:[UIColor whiteColor]];
	if(sender == accountTextField){
		//NSLog(@"accountTextField editingDidBegin");
        
	}
	
}
-(void)editingDidEndOnExit:(id)sender{
	//[(UITextField*)sender setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
	if(sender == accountTextField){
		NSLog(@"accountTextField editingDidEndOnExit");

	}
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
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
    if (0==indexPath.row) {
        cell.mode =FcGroupTableCellMode_TOP;
    }else if(indexPath.row == cellCount-1){
        cell.mode = FcGroupTableCellMode_BUTTON;
    }else{
        cell.mode = FcGroupTableCellMode_MIDDLE;
    }
    if (0 == indexPath.row) {
        cell.textLabel.text =AMLocalizedString(@"Login_UserName",nil);
        [cell addSubview:accountTextField];
    }else{
        cell.textLabel.text =AMLocalizedString(@"Login_Password",nil);
        [cell addSubview:passwordTextField];
    }
    [cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [cell setLayout];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return GroupCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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
    if (indexPath.row ==0) {
        [passwordTextField setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
        [accountTextField setTextColor:[UIColor whiteColor]];
    }else{
        [accountTextField setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
        [passwordTextField setTextColor:[UIColor whiteColor]];
    }
        
}
- (void)dealloc {
    if (accountTextField) {
        [accountTextField release];
    }
    if (passwordTextField) {
        [passwordTextField release];
    }    
}

@end
