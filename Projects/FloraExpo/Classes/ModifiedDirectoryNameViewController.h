//
//  ModifiedDirectoryNameViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectoryNameViewController.h"

@interface ModifiedDirectoryNameViewController : DirectoryNameViewController {
	NSString *folderName;
}
@property(nonatomic,retain)NSString *folderName;
@end
