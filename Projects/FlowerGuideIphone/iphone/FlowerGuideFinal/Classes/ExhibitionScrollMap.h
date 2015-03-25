//
//  ExhibitionScrollMap.h
//  FlowerGuide
//
//  Created by Liao Change on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExhibitionScrollMap : UIView {
	IBOutlet UIScrollView *myScrollMap;
	UINavigationController *parentNavigationController;
}
@property(nonatomic,retain)UIScrollView *myScrollMap;
@property(nonatomic,assign)UINavigationController *parentNavigationController;
-(IBAction)buttonAction:(id)sender;
@end
