//
//  RootViewController.m
//  FcWebDavDemo
//
//  Created by 廖 晨志 on 2011/7/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "RootViewController.h"
#import "FMWebDAVRequest.h"
#define defaultURL @"http://10.62.13.31:8080/repository/default/"
#define USERNAME @"admin"
#define PASSWORD @""

//#define CREATEDIR
//#define UPLOAD
//#define COPY
//#define DOWNLOAD
//#define DELETEFILE
//#define DELETEDIR
#define MOVE
@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    waitingOnAuthentication=YES;
    //fetch dir
    FMWebDAVRequest *request= [FMWebDAVRequest requestToURL:NSStringToURL(defaultURL)  delegate:self
                      endSelector:@selector(requestDidFetchDirectoryListingAndTestAuthenticationDidFinish:)
                      contextInfo:nil];
    request.username=USERNAME;
    request.password=PASSWORD;
    [request fetchDirectoryListing];
    
    NSRunLoop * currentRunLoop = [NSRunLoop currentRunLoop];
    while (waitingOnAuthentication && [currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
        // Empty
    }

#ifdef CREATEDIR
    //create dir
    NSString *dirURL = [defaultURL stringByAppendingFormat:@"changeDir/"];
    FMWebDAVRequest *createDir = [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous] createDirectory];
#endif
#ifdef UPLOAD
    //put data
    NSString *dirURL=[defaultURL stringByAppendingFormat:@"changeDir/audioAAC.mp4"];
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"audio_0003" ofType:@"mp4"];
    NSData *fileData=[NSData dataWithContentsOfFile:filePath];
    [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous] putData:fileData];
#endif
#ifdef COPY
    NSString *originURL=[defaultURL stringByAppendingFormat:@"testfolder/"];
    NSString *copyToURL =[defaultURL stringByAppendingString:@"testfolder1/"];
    
    [[[FMWebDAVRequest requestToURL:NSStringToURL(originURL)] synchronous] copyToDestinationURL:NSStringToURL(copyToURL)];
#endif
#ifdef DOWNLOAD    
    NSString *dirURL=[defaultURL stringByAppendingFormat:@"changeDir/audioAAC.mp4"];
    NSData *getData= [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous] get].responseData;
    [getData writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent: @"audio.mp4"] atomically:YES];
    //TODO play this audio?
    NSInteger length=[getData length];
    NSLog(@"Downdload file's size: %i bytes",length);
#endif
    
#ifdef DELETEFILE
    NSString *dirURL=[defaultURL stringByAppendingFormat:@"changeDir/audioAAC.mp4"];
    [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous] delete];
#endif
    
#ifdef DELETEDIR
    NSString *dirURL=[defaultURL stringByAppendingFormat:@"changeDir"];
    [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous] delete];
#endif
    
#ifdef MOVE
    NSString *dirURL=[defaultURL stringByAppendingFormat:@"changeDir/audioAAC.mp4"];
    NSString *targetURL=[defaultURL stringByAppendingFormat:@"testfolder/audioAAC.mp4"];
    [[[FMWebDAVRequest requestToURL:NSStringToURL(dirURL) delegate:self endSelector:nil contextInfo:nil] synchronous]moveToDestinationURL:NSStringToURL(targetURL)];
#endif
}
- (void)requestDidFetchDirectoryListingAndTestAuthenticationDidFinish:(FMWebDAVRequest*)req {
    
    NSArray *directoryListing = [req directoryListing];
    
    for (NSString *file in directoryListing) {
        NSLog(@"file: %@", file);
    }
    waitingOnAuthentication=NO;
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

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    return cell;
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
