//  
//  TransferStatusController.h
//
//  $URL: http://wtclient.googlecode.com/svn/trunk/Examples/MobileWebDAVTransporter/Classes/TransferStatusController.h $
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

@interface TransferStatusController : UIViewController {
    id target;
    SEL abortAction;
    SEL closeAction;
    
    UILabel *progressLabel;
    UILabel *statusLabel;
    UIActivityIndicatorView *activityIndicator;
    UIButton *button;
    
    BOOL active;
}

- (id)initWithTarget:(id)theTarget abortAction:(SEL)anAbortAction closeAction:(SEL)aCloseAction;
- (void)showInView:(UIView *)aView;
- (void)dismiss;

@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL abortAction;
@property (nonatomic, readonly) SEL closeAction;

@property (nonatomic) BOOL active;

@property (nonatomic, readonly) UILabel *progressLabel;
@property (nonatomic, readonly) UILabel *statusLabel;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, readonly) UIButton *button;

@property (nonatomic, copy) NSString *statusMessage;
@property (nonatomic, copy) NSString *progressMessage;


@end
