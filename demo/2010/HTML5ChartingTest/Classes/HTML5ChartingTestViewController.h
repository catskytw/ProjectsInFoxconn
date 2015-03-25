//
//  HTML5ChartingTestViewController.h
//  HTML5ChartingTest
//
//  Created by 廖 晨志 on 2011/1/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTML5ChartingTestViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *testChart1;
}
@property(nonatomic,retain)UIWebView *testChart1;
@end

