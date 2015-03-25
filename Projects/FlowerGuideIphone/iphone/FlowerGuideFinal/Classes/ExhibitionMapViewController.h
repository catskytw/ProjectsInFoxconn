//
//  ExhibitionMapViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ExhibitionScrollMap.h"
@interface ExhibitionMapViewController : BaseViewController {
	ExhibitionScrollMap *myMap;
	NSArray *exhibitionDataArray;
}
@property(nonatomic,retain)NSArray *exhibitionDataArray;
@end
