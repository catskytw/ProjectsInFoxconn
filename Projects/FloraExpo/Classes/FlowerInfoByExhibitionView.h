//
//  FlowerInfoByExhibitionView.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExhibitionTableView.h"

@interface FlowerInfoByExhibitionView : ExhibitionTableView <UISearchBarDelegate>{
	UISearchBar *thisSearchBar;
	NSInteger tableStartY;
}

@end
