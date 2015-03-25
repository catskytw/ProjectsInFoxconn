//
//  NewsDetailInfoViewController.h
//  FloraExpo2010
//
//  Created by Liao Change on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescriptionPageDataObject.h"

@interface NewsDetailInfoViewController : UIViewController {
	IBOutlet UIWebView *mainWebView;
	DescriptionPageDataObject *thisViewData;
}
@property(nonatomic,retain)UIWebView *mainWebView;
-(id)initWithDataObject:(DescriptionPageDataObject*)inputData;
@end
