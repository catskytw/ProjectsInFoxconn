//
//  MyLifeDescriptionViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DescriptionViewController.h"
#import "MyLifeDescriptionObject.h"
@interface MyLifeDescriptionViewController : DescriptionViewController {
	//上層容器的controller
	UIViewController *parentViewController;
	MyLifeDescriptionObject *discountObject;
}
@property(nonatomic,retain)UIViewController *parentViewController;
-(id)initWithDataObject:(MyLifeDescriptionObject*)dataObject;
-(void)addDataArray:(MyLifeDescriptionObject*)dataObject;
@end
