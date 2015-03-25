//
//  Tools.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tools : NSObject {

}
+(UIViewController*)lastSecondUIViewController:(UINavigationController*)inputController;
+(NSString*)replaceSpaceToPlus:(NSString*)inputTextString;
+(void)addWaitCursor;
+(void)delWaitCursor;
+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView;

@end
