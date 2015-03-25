//
//  DownloadThreadObject.m
//  FlowerGuide
//
//  Created by Liao Change on 10/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DownloadThreadObject.h"


@implementation DownloadThreadObject
@synthesize notificationName;
-(id)init{
	if((self=[super init])){
		targetImageView=nil;
		targetButton=nil;
		notificationName=nil;
	}
	return self;
}
-(id)initWithNotificationName:(NSString*)thisNotificationName{
	if((self=[super init])){
		targetImageView=nil;
		targetButton=nil;
		notificationName=[[NSString stringWithString:thisNotificationName]retain];
	}
	return self;
}
-(void)start:(NSString*)url withTargetView:(UIImageView*)targetView{
	//若遇到url為NSNull,返回
	if((id)url==[NSNull null] || url==nil)
		return;
	targetImageView=targetView;
	[NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:url];
}
-(void)start:(NSString*)url withTargetButton:(UIButton*)targetBtn{
	if((id)url==[NSNull null] || url==nil)
		return;
	targetButton=targetBtn;
	[NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:url];
}
-(void)downloadImage:(NSString*)urlString{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
	NSURL *url=[NSURL URLWithString:urlString];
	NSData *data=[NSData dataWithContentsOfURL:url];
	if(data!=nil){
		UIImage *img=[UIImage imageWithData:data];
		[self performSelectorOnMainThread:@selector(downloadDone:) withObject:img waitUntilDone:NO];
	}
	[pool drain];
}

-(void)downloadDone:(UIImage*)theImage{
	if(targetImageView!=nil){
		//[targetImageView setFrame:CGRectMake(targetImageView.frame.origin.x, targetImageView.frame.origin.y, theImage.size.width, theImage.size.height)];
		[targetImageView setImage:theImage];
	}
	else if(targetButton!=nil){
		[targetButton setBackgroundImage:theImage forState:UIControlStateNormal];
	}
	
	if(notificationName!=nil){
		[[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:nil userInfo:nil];
	}
}

-(void)dealloc{
	if(notificationName!=nil)
		[notificationName release];
	[super dealloc];
}
@end
