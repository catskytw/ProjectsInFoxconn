//
//  ExhibitionIntroViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface ExhibitionIntroViewController : BaseTableViewController{
	NSArray *areaDataArray;
}
-(id)initwithAreaKey:(NSString*)areaKey;
@end
