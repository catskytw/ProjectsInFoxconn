//
//  FlowerSearchResultBaseController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FlowerSearchResultViewController.h"
@interface FlowerSearchResultBaseController : BaseViewController {
	FlowerSearchResultViewController *flowerSearchContentView;
}
-(id)initWithFlowerName:(NSString*)flowerName;

@end
