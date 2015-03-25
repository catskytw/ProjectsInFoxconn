#import "RootViewController.h"
#import "SettingsViewController.h"
#import "iPhoneXMPPAppDelegate.h"

#import "XMPP.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPUserCoreDataStorageObject.h"
#import "XMPPResourceCoreDataStorageObject.h"
#import "XMPPvCardAvatarModule.h"
#import "ChattingViewController.h"
#import "DDLog.h"
#import "MessageQueue.h"
// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation RootViewController
@synthesize inputBox,isLoading;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Accessors
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream
{
	return [[self appDelegate] xmppStream];
}

- (XMPPRoster *)xmppRoster
{
	return [[self appDelegate] xmppRoster];
}

- (XMPPRosterCoreDataStorage *)xmppRosterStorage
{
	return [[self xmppRoster] xmppRosterStorage];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewDidLoad{
    isLoading = TRUE;
    accountDic=[[NSMutableDictionary dictionary] retain];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.numberOfLines = 1;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = UITextAlignmentCenter;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableNotification:) name:@"reloadContactListNotification" object:nil];
    
    if ([[self appDelegate] connect]) 
    {
        titleLabel.text = [[[[self appDelegate] xmppStream] myJID] bare];
    } else
    {
        titleLabel.text = @"No JID";
        //[self.navigationController presentModalViewController:[[self appDelegate] settingsViewController] animated:YES];
    }
    
    self.navigationItem.titleView = titleLabel;
    
    [titleLabel release];
}

-(void)viewDidUnload{
    [[self appDelegate] disconnect];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadContactListNotification" object:nil];    
    [[[self appDelegate] xmppvCardTempModule] removeDelegate:self];
    [accountDic release];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.toolbar setHidden:NO];
    [self.tableView reloadData];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Core Data
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSManagedObjectContext *)managedObjectContext
{
	if (managedObjectContext == nil)
	{
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		
		NSPersistentStoreCoordinator *psc = [[self xmppRosterStorage] persistentStoreCoordinator];
		[managedObjectContext setPersistentStoreCoordinator:psc];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
		                                         selector:@selector(contextDidSave:)
		                                             name:NSManagedObjectContextDidSaveNotification
		                                           object:nil];
	}
	
	return managedObjectContext;
}

- (void)contextDidSave:(NSNotification *)notification
{
	NSManagedObjectContext *sender = (NSManagedObjectContext *)[notification object];
	
	if (sender != managedObjectContext &&
      [sender persistentStoreCoordinator] == [managedObjectContext persistentStoreCoordinator])
	{
		DDLogError(@"%@: %@", THIS_FILE, THIS_METHOD);
		
		[managedObjectContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
		                                       withObject:notification
		                                    waitUntilDone:NO];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSFetchedResultsController
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSFetchedResultsController *)fetchedResultsController
{
	if (fetchedResultsController == nil)
	{
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject"
		                                          inManagedObjectContext:[self managedObjectContext]];
		
		NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"sectionNum" ascending:YES];
		NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
		
		NSArray *sortDescriptors = [NSArray arrayWithObjects:sd1, sd2, nil];
		
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:entity];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[fetchRequest setFetchBatchSize:10];
		
		fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                managedObjectContext:[self managedObjectContext]
                sectionNameKeyPath:@"sectionNum"
                cacheName:nil];
		[fetchedResultsController setDelegate:self];
		
		[sd1 release];
		[sd2 release];
		[fetchRequest release];
		
		NSError *error = nil;
		if (![fetchedResultsController performFetch:&error])
		{
			NSLog(@"Error performing fetch: %@", error);
		}
        
	}
	
	return fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[[self tableView] reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITextInputDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [textField resignFirstResponder];
    [self appDelegate].inputBox = textField.text;
    return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableViewCell helpers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)configurePhotoForCell:(UITableViewCell *)cell user:(id <XMPPUser>)user
{
  // XMPPRoster will cache photos as they arrive from the xmppvCardAvatarModule, we only need to
  // ask the avatar module for a photo, if the roster doesn't have it.
  if (user.photo != nil)
  {
    cell.imageView.image = user.photo;
  } 
  else
  {
    NSData *photoData = [[[self appDelegate] xmppvCardAvatarModule] photoDataForJID:user.jid];
    
    if (photoData != nil) {
      cell.imageView.image = [UIImage imageWithData:photoData];
    } else {
      cell.imageView.image = [UIImage imageNamed:@"defaultPerson"];
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[[self fetchedResultsController] sections] count];
}

- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
{
	NSArray *sections = [[self fetchedResultsController] sections];
	
	if (sectionIndex < [sections count])
	{
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:sectionIndex];
        
		int section = [sectionInfo.name intValue];
		switch (section)
		{
			case 0  : return @"Available";
			case 1  : return @"Away";
			default : return @"Offline";
		}
	}
	
	return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
	NSArray *sections = [[self fetchedResultsController] sections];
	
	if (sectionIndex < [sections count])
	{
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:sectionIndex];
		return sectionInfo.numberOfObjects;
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
		                               reuseIdentifier:CellIdentifier] autorelease];
	}
	
	XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    //NSLog(@"%@ unreadCnt %d ",[user.jid user], [[[MessageQueue shareUnreadDic]objectForKey:[user.jid user]] intValue]);
    if ([[[MessageQueue shareUnreadDic]objectForKey:[user.jid user]] intValue]>0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)",user.displayName,[[[MessageQueue shareUnreadDic]objectForKey:[user.jid user]] intValue]];
    }
    else
        cell.textLabel.text = user.displayName;
    [accountDic setValue:user.jid forKey:user.displayName];
    [self configurePhotoForCell:cell user:user];
  
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *thisCell=[tableView cellForRowAtIndexPath:indexPath];
    XMPPJID *_jid=(XMPPJID*)[accountDic valueForKey:[self getName:thisCell.textLabel.text]];
    
   // NSLog(@"didSelect  jid:%@ getNamem:%@", [_jid user], [self getName:thisCell.textLabel.text]);
    
    ((iPhoneXMPPAppDelegate*)[[UIApplication sharedApplication]delegate]).selectedJID=_jid;
    [((iPhoneXMPPAppDelegate*)[[UIApplication sharedApplication]delegate]) chatWithFriend];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Actions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)settings:(id)sender {
    [[self appDelegate]disconnect];
    [accountDic release];
    accountDic=[[NSMutableDictionary dictionary] retain];
    [self reloadInputViews];
  [self.navigationController presentModalViewController:[[self appDelegate] settingsViewController] animated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Init/dealloc
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc
{
	[super dealloc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Notification
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)reloadTableNotification:(NSNotification*)notification{
    [self.tableView reloadData];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Extracts the the real name from the given name.
 * If name is nil, or has no (, an empty string is returned.
 * 
 * Examples:
 * "Link(1)" -> "link"
 * "Link" -> "Link"
 * "node" -> ""
 * nil -> ""
 **/
-(NSString *)getName:(NSString *)name
{
	if (name)
	{
		NSRange range = [name rangeOfString:@"("];
		
		if (range.length != 0)
		{
			return [name substringToIndex:range.location-1];
		}
        return name;
	}
	return @"";
}

@end
