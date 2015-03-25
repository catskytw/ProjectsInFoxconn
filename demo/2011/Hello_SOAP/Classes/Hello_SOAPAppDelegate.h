//
//  Hello_SOAPAppDelegate.h
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hello_SOAPViewController;

@interface Hello_SOAPAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet Hello_SOAPViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) Hello_SOAPViewController *viewController;

@end

