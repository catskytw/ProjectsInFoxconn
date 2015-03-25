//
//  CommonContentDescriptionView.h
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DescriptionViewController.h"
#import "ContentObject.h"
#import "BaseViewController.h"
#import "CommonDescriptionViewController.h"
@interface CommonContentDescriptionView : BaseViewController {
	CommonDescriptionViewController *thisContentViewController;
	NSString *titleString;
}
-(id)initWithDataObject:(ContentObject*)dataObject;
@end
