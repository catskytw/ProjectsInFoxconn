//
//  ChatingViewCell.m
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ChatingViewCell.h"


@implementation ChatingViewCell
@synthesize playBtn,voiceUrl,playbackWasInterrupted,playbackWasPaused;

#if TARGET_OS_IPHONE
@synthesize player;
#endif//TARGET_OS_IPHONE

@synthesize name,content;


- (IBAction)playvoice:(id)sender {
#if TARGET_OS_IPHONE
    if (player->IsRunning())
    {
        if (playbackWasPaused) {
            OSStatus result = player->StartQueue(true);
            
            if (result == noErr)
                [playBtn setTitle:@"Stop" forState:UIControlStateNormal];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
        }
        else{
            [self stopPlayQueue];
            [playBtn setTitle:@"Play" forState:UIControlStateNormal];
        }
    }
    else
    {		
        player->CreateQueueForFile((CFStringRef)voiceUrl);
        NSLog(@"play sound file:%@",voiceUrl); 
        OSStatus result = player->StartQueue(false);
        
        if (result == noErr)
            [playBtn setTitle:@"Stop" forState:UIControlStateNormal];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
    }
#endif//TARGET_OS_IPHONE

}
-(void)stopPlayQueue
{
#if TARGET_OS_IPHONE
	player->StopQueue();
	//[lvlMeter_in setAq: nil];
	playBtn.enabled = YES;
#endif//TARGET_OS_IPHONE
}

-(void)pausePlayQueue
{
#if TARGET_OS_IPHONE
	player->PauseQueue();
	playbackWasPaused = YES;
#endif//TARGET_OS_IPHONE
}

- (void)dealloc {
    [playBtn release];
#if TARGET_OS_IPHONE
    delete player;
#endif//TARGET_OS_IPHONE
    [super dealloc];
}
void interruptionListenerCell(	void *	inClientData,
                          UInt32	inInterruptionState)
{
#if TARGET_OS_IPHONE
	ChatingViewCell *THIS = (ChatingViewCell*)inClientData;
	if (inInterruptionState == kAudioSessionBeginInterruption)
	{
			if (THIS->player->IsRunning()) {
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
#endif//TARGET_OS_IPHONE
}

#if TARGET_OS_IPHONE
void propListenerCell(	void *                  inClientData,
                  AudioSessionPropertyID	inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
	ChatingViewCell *THIS = (ChatingViewCell*)inClientData;
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

		}	
	}
	else if (inID == kAudioSessionProperty_AudioInputAvailable)
	{
		if (inDataSize == sizeof(UInt32)) {
			UInt32 isAvailable = *(UInt32*)inData;
		}
	}
}
#endif//TARGET_OS_IPHONE

- (void)initVoice{
    
#if TARGET_OS_IPHONE
        // Initialization code
        player = new AQPlayer();
        OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListenerCell, self);
        if (error) printf("ERROR INITIALIZING AUDIO SESSION! %d\n", error);
        else 
        {
            UInt32 category = kAudioSessionCategory_PlayAndRecord;	
            error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
            if (error) printf("couldn't set audio category!");
            
            error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListenerCell, self);
            if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", error);
            UInt32 inputAvailable = 0;
            UInt32 size = sizeof(inputAvailable);
            
            // we do not want to allow recording if input is not available
            error = AudioSessionGetProperty(kAudioSessionProperty_AudioInputAvailable, &size, &inputAvailable);
            if (error) printf("ERROR GETTING INPUT AVAILABILITY! %d\n", error);
            
            // we also need to listen to see if input availability changes
            error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioInputAvailable, propListenerCell, self);
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

#endif//TARGET_OS_IPHONE
}

# pragma mark Notification routines
- (void)playbackQueueStopped:(NSNotification *)note
{
	[playBtn setTitle:@"Play" forState:UIControlStateNormal];
	//[lvlMeter_in setAq: nil];
}

- (void)playbackQueueResumed:(NSNotification *)note
{
	[playBtn setTitle:@"Stop" forState:UIControlStateNormal];
	//[lvlMeter_in setAq: player->Queue()];
}

@end
