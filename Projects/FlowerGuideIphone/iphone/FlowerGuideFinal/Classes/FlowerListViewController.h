//
//  FlowerListViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowerSearchViewController.h"
#import "ContentObject.h"
@interface FlowerListViewController : FlowerSearchViewController {
	ContentObject *dataObject;
}
@property(nonatomic,assign)ContentObject *dataObject;
@end
