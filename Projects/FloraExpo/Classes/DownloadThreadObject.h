//
//  DownloadThreadObject.h
//  FlowerGuide
//
//  Created by Liao Change on 10/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadThreadObject : NSObject {
	UIImageView *targetImageView;
	UIButton *targetButton;
	NSString *notificationName;
}
@property(nonatomic,retain)NSString *notificationName;
-(void)start:(NSString*)url withTargetView:(UIImageView*)targetView;
-(void)downloadImage:(NSString*)urlString;
-(void)downloadDone:(UIImage*)theImage;
-(void)start:(NSString*)url withTargetButton:(UIButton*)targetBtn;
@end
