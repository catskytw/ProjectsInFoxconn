//
//  RecordViewController.m
//  iPhoneXMPP
//
//  Created by Link Chang on 2011/7/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "RecordViewController.h"

#import "NSData+base64.h"

@implementation RecordViewController
@synthesize playBtn;
@synthesize recBtn;
@synthesize cancelBtn;
@synthesize sendBtn;
//#define TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
@synthesize player;
@synthesize recorder;
//#define TARGET_OS_IPHONE
#endif//TARGET_OS_IPHONE

@synthesize playbackWasInterrupted;
@synthesize targetJid,targetDisplayName,recName;
char *OSTypeToStr(char *buf, OSType t)
{
	char *p = buf;
	char str[4], *q = str;
	*(UInt32 *)str = CFSwapInt32(t);
	for (int i = 0; i < 4; ++i) {
		if (isprint(*q) && *q != '\\')
			*p++ = *q++;
		else {
			sprintf(p, "\\x%02x", *q++);
			p += 4;
		}
	}
	*p = '\0';
	return buf;
}
#pragma mark Playback routines

//#define TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
-(void)stopPlayQueue
{
	player->StopQueue();
	//[lvlMeter_in setAq: nil];
	recBtn.enabled = YES;
}

-(void)pausePlayQueue
{
	player->PauseQueue();
	playbackWasPaused = YES;
}

- (void)stopRecord
{
	// Disconnect our level meter from the audio queue
	//[lvlMeter_in setAq: nil];
	
	recorder->StopRecord();
	
	// dispose the previous playback queue
	player->DisposeQueue(true);
    
	// now create a new queue for the recorded file
	recordFilePath = (CFStringRef)[NSTemporaryDirectory() stringByAppendingPathComponent: recName];
	player->CreateQueueForFile(recordFilePath);
    NSLog(@"play sound file:%@",recordFilePath); 
	// Set the button's state back to "record"
    
	sendBtn.enabled = YES;
    playBtn.enabled = YES;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //bRec = YES;
        //bPlay =NO;
        [self awakeFromNib];
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [recBtn release];
    [cancelBtn release];
    [sendBtn release];
    if (recName!=nil) {
        [recName release];
    }
   
    [playBtn release];
    [super dealloc];
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
    [self setRecBtn:nil];
    [self setCancelBtn:nil];
    [self setSendBtn:nil];
    if (player) {
        delete player;
    }
    if (recorder) {
        delete recorder;
    }
    [self setPlayBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)recUp:(id)sender {
    //if (bRec) {
        if (recorder->IsRunning()) // If we are currently recording, stop and save the file.
        {
            [self stopRecord];
            //bRec = NO;
            //bPlay = YES;
            playBtn.enabled = YES;
            [recBtn setTitle:@"Record" forState:UIControlStateNormal];
        }
        else // If we're not recording, start.
        {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
            
            NSDate *now = [[NSDate alloc] init];
            
            recName = [[NSString alloc]initWithFormat:@"%@.mp4",[format stringFromDate:now]];
            [format release];
            [now release];

            // Set the button's state to "stop"
            [recBtn setTitle:@"Stop" forState:UIControlStateNormal];
            // Start the recorder
            //recorder->StartRecord(CFSTR("recordedFile.wav"));
            recorder->StartRecord((CFStringRef)recName);
            playBtn.enabled = NO;
            //[self setFileDescriptionForFormat:recorder->DataFormat() withName:@"Recorded File"];
            // Hook the level meter up to the Audio Queue for the recorder
            //[lvlMeter_in setAq: recorder->Queue()];
        }	
    //}
}

- (IBAction)cancel:(id)sender {
    if (recorder->IsRunning()) // If we are currently recording, stop and save the file.
    {
        [self stopRecord];
    }
    if (player->IsRunning())
	{
        [self stopPlayQueue];
	}
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendVoice:(id)sender {
    if (recorder->IsRunning()) // If we are currently recording, stop and save the file.
    {
        [self stopRecord];
    }
    if (player->IsRunning())
	{
        [self stopPlayQueue];
	}
    NSData *Content=[NSData dataWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent: recName]];

    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
   
    [dic setValue:recName forKey:@"_message"];
    [dic setValue:[NSTemporaryDirectory() stringByAppendingPathComponent: recName] forKey:@"_path"];
    [dic setValue:targetJid forKey:@"_jid"];
    [dic setValue:[Content base64EncodedString] forKey:@"_base64"];
    //送出sendMessage
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendFileNotification" object:nil userInfo:dic];
    //重新描繪table
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadConversationTable" object:nil userInfo:nil];
}

- (IBAction)play:(id)sender {
    //if(bPlay){
        if (player->IsRunning())
        {
            if (playbackWasPaused) {
                OSStatus result = player->StartQueue(true);
                if (result == noErr)
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
            }
            else
                [self stopPlayQueue];
            recBtn.enabled = YES;
        }
        else
        {		
            recBtn.enabled = NO;
            
            OSStatus result = player->StartQueue(false);
            if (result == noErr)
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
        }
    //}

}

#pragma mark AudioSession listeners
void interruptionListener(	void *	inClientData,
                          UInt32	inInterruptionState)
{
	RecordViewController *THIS = (RecordViewController*)inClientData;
	if (inInterruptionState == kAudioSessionBeginInterruption)
	{
		if (THIS->recorder->IsRunning()) {
			[THIS stopRecord];
		}
		else if (THIS->player->IsRunning()) {
			//the queue will stop itself on an interruption, we just need to update the UI
			[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueStopped" object:THIS];
			THIS->playbackWasInterrupted = YES;
		}
	}
	else if ((inInterruptionState == kAudioSessionEndInterruption) && THIS->playbackWasInterrupted)
	{
		// we were playing back when we were interrupted, so reset and resume now
		THIS->player->StartQueue(true);
		[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:THIS];
		THIS->playbackWasInterrupted = NO;
	}
}

void propListener(	void *                  inClientData,
                  AudioSessionPropertyID	inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
	RecordViewController *THIS = (RecordViewController*)inClientData;
	if (inID == kAudioSessionProperty_AudioRouteChange)
	{
		CFDictionaryRef routeDictionary = (CFDictionaryRef)inData;			
		//CFShow(routeDictionary);
		CFNumberRef reason = (CFNumberRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		SInt32 reasonVal;
		CFNumberGetValue(reason, kCFNumberSInt32Type, &reasonVal);
		if (reasonVal != kAudioSessionRouteChangeReason_CategoryChange)
		{			if (reasonVal == kAudioSessionRouteChangeReason_OldDeviceUnavailable)
        {	
				if (THIS->player->IsRunning()) {
					[THIS pausePlayQueue];
					[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueStopped" object:THIS];
				}		
			}
            
			// stop the queue if we had a non-policy route change
			if (THIS->recorder->IsRunning()) {
				[THIS stopRecord];
			}
		}	
	}
	else if (inID == kAudioSessionProperty_AudioInputAvailable)
	{
		if (inDataSize == sizeof(UInt32)) {
			UInt32 isAvailable = *(UInt32*)inData;
			// disable recording if input is not available
			THIS->recBtn.enabled = (isAvailable > 0) ? YES : NO;
		}
	}
}

#pragma mark Initialization routines
- (void)awakeFromNib
{		
	// Allocate our singleton instance for the recorder & player object
	recorder = new AQRecorder();
	player = new AQPlayer();
    
	OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, self);
	if (error) printf("ERROR INITIALIZING AUDIO SESSION! %d\n", error);
	else 
	{
		UInt32 category = kAudioSessionCategory_PlayAndRecord;	
		error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
		if (error) printf("couldn't set audio category!");
        
		error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener, self);
		if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", error);
		UInt32 inputAvailable = 0;
		UInt32 size = sizeof(inputAvailable);
		
		// we do not want to allow recording if input is not available
		error = AudioSessionGetProperty(kAudioSessionProperty_AudioInputAvailable, &size, &inputAvailable);
		if (error) printf("ERROR GETTING INPUT AVAILABILITY! %d\n", error);
		
		// we also need to listen to see if input availability changes
		error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioInputAvailable, propListener, self);
		if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", error);
        
		error = AudioSessionSetActive(true); 
		if (error) printf("AudioSessionSetActive (true) failed");
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackQueueStopped:) name:@"playbackQueueStopped" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackQueueResumed:) name:@"playbackQueueResumed" object:nil];
    
	UIColor *bgColor = [[UIColor alloc] initWithRed:.39 green:.44 blue:.57 alpha:.5];
	//[lvlMeter_in setBackgroundColor:bgColor];
	//[lvlMeter_in setBorderColor:bgColor];
	[bgColor release];
	
	// disable the play button since we have no recording to play yet
	playbackWasInterrupted = NO;
	playbackWasPaused = NO;
    
    playBtn.enabled = NO;
}

# pragma mark Notification routines
- (void)playbackQueueStopped:(NSNotification *)note
{
	[playBtn setTitle:@"Play" forState:UIControlStateNormal];
    
    recBtn.enabled = YES;
	//[lvlMeter_in setAq: nil];
}

- (void)playbackQueueResumed:(NSNotification *)note
{
	[playBtn setTitle:@"Stop" forState:UIControlStateNormal];
    recBtn.enabled = NO;
	//[lvlMeter_in setAq: player->Queue()];
}
#endif//TARGET_OS_IPHONE

@end
