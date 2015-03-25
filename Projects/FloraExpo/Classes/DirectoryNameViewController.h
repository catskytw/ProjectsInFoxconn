//
//  ModifiedDirectoryNameViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 based DirectoryName View Controller
 */
@interface DirectoryNameViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UITextField *directoryNameTextField;
	NSInteger queryType;
	NSString *originKeyString;
}
@property(nonatomic,retain)UITextField *directoryNameTextField;
@property(nonatomic,retain)NSString *originKeyString;
-(id)initWithFavType:(NSInteger)thisQueryType;

@end
