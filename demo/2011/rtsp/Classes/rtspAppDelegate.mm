//
//  rtspAppDelegate.m
//  rtsp
//
//  Created by Felix  Enriquez on 14/07/10.
//  Copyright Generamobile 2010. All rights reserved.
//

#import "rtspAppDelegate.h"
@implementation rtspAppDelegate

@synthesize window;
@synthesize image;
 
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	rawsdp = 0;
	
    [window makeKeyAndVisible];
    
    [VideoDecoder staticInitialize];
    decoder=[[VideoDecoder alloc]initWithCodec:kVCT_H264 colorSpace:kVCS_RGBA32 width:380 height:480 privateData:nil];
		
	
	return YES;
}

- (void)appendText:(NSData *)datos toFile:(NSString *)filePath {
	
		// NSFileHandle won't create the file for us, so we need to check to make sure it exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
		
			// the file doesn't exist yet, so we can just write out the text using the 
			// NSString convenience method
		
         
        BOOL success = [datos writeToFile:filePath atomically:YES ];
        if (!success) {
				// handle the error
            NSLog(@"error");
        }
		
    } else {
		
	 	// the file already exists, so we should append the text to the end
		
			// get a handle to the file
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
		
			// move to the end of the file
        [fileHandle seekToEndOfFile];
		 			// write the data to the end of the file
        [fileHandle writeData:datos];
		
			// clean up
        [fileHandle closeFile];
	  
    }
}

- (NSString *) directorioDocument{
	NSArray			*paths				= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString		*documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}
-(void)threadImage{
    if([decoder isFrameReady])
        [image setImage:[UIImage imageWithData:[decoder getDecodedFrame]]];
}
- (void)didReceiveFrame:(NSData*)frameData presentationTime:(NSDate*)presentationTime{
    [decoder decodeFrame:frameData];
	[self performSelectorOnMainThread:@selector(threadImage) withObject:nil waitUntilDone:NO];
		//	BOOL correcto= [frameData writeToFile:[[self directorioDocument] stringByAppendingString:@"/video.mp4"] atomically:NO];
    
	//[self appendText:frameData toFile:[[self directorioDocument] stringByAppendingString:@"/video.mp4"]];
}

-(IBAction) click2{
	[session play ]; 
	NSLog(@"error: --> %@",[ session getLastErrorString ]);
	[self performSelectorInBackground:@selector(lanzado) withObject:nil ];
	NSLog(@"Lanzado play");
}

-(IBAction) click3{
	 rawsdp = "z" ;
}

-(IBAction) click4{
	[session teardown];
}

-(IBAction) click5{
	[self lanzado];
}

- (void) lanzado {
	session = [[RTSPClientSession alloc] initWithURL:[NSURL URLWithString:@"rtsp://10.62.13.188/sample_h264_1mbit.mp4"]];
	[session setup];
	
	NSLog(@"getSDP: --> %@",[ session getSDP ]);
	
	NSArray *array =  [session getSubsessions];
	for (int i=0; i < [array count]; i++) {
		
		RTSPSubsession *subsession = [array objectAtIndex:i]; 
		
		[session setupSubsession:subsession clientPortNum:0 ];
		subsession.delegate=self;
		[subsession increaseReceiveBufferTo:2000000];
	}
	[session play ];
	[session runEventLoop:rawsdp];
 
}

-(IBAction) click{
 	[self performSelectorInBackground:@selector(lanzado) withObject:nil ];
}

 
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Error %@",[error localizedDescription]);
}

	//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	NSLog(@"Descargando .....  ");
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:4048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	NSLog(@"Finaliza la descarga");
	NSLog(@"=====================================================================================");
	NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
