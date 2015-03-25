//  
//  MobileWebDAVTransporterAppDelegate.h
//
//  $URL: http://wtclient.googlecode.com/svn/trunk/Examples/MobileWebDAVTransporter/Classes/MobileWebDAVTransporterAppDelegate.h $
//
//  $Revision: 16 $
//  $LastChangedDate: 2009-02-08 04:23:23 +0800 (Sun, 08 Feb 2009) $
//  $LastChangedBy: alex.chugunov $
//
//  This part of source code is distributed under MIT Licence
//  Copyright (c) 2009 Alex Chugunov
//  http://code.google.com/p/wtclient/
//


#import <UIKit/UIKit.h>

@class TestController;

@interface MobileWebDAVTransporterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestController *testController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

