//
//  FcPageController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcPageController.h"

@interface FcPageController (Private)
- (void) updateDots;
@end

@implementation FcPageController
@synthesize imageNormal = mImageNormal;
@synthesize imageCurrent = mImageCurrent;

- (void) dealloc
{
	[mImageNormal release], mImageNormal = nil;
	[mImageCurrent release], mImageCurrent = nil;
	
	[super dealloc];
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
	[super setCurrentPage:currentPage];
	
	// update dot views
	[self updateDots];
}

/** override to update dots */
- (void) updateCurrentPageDisplay
{
	[super updateCurrentPageDisplay];
	
	// update dot views
	[self updateDots];
}

/** Override setImageNormal */
- (void) setImageNormal:(UIImage*)image
{
	[mImageNormal release];
	mImageNormal = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override setImageCurrent */
- (void) setImageCurrent:(UIImage*)image
{
	[mImageCurrent release];
	mImageCurrent = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override to fix when dots are directly clicked */
- (void) endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event 
{
	[super endTrackingWithTouch:touch withEvent:event];
	
	[self updateDots];
}

#pragma mark - (Private)

- (void) updateDots
{
	if(mImageCurrent || mImageNormal)
	{
		// Get subviews
		NSArray* dotViews = self.subviews;
		for(int i = 0; i < dotViews.count; ++i)
		{
			UIImageView* dot = [dotViews objectAtIndex:i];
			// Set image
			dot.image = (i == self.currentPage) ? mImageCurrent : mImageNormal;
		}
	}
}

@end