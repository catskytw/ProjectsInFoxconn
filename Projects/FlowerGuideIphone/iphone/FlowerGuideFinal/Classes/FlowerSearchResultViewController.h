//
//  FlowerSearchResultViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowerSearchViewController.h"
#import "ContentObject.h"
@interface FlowerSearchResultViewController : FlowerSearchViewController{
	ContentObject *dataObject;
}
@property(nonatomic,retain)ContentObject *dataObject;
@end
