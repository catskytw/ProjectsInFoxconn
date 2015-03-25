//
//  NoCameraViewController.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface NoCameraViewController : FcViewController{
    IBOutlet UILabel *nocamera;
}
@property(nonatomic,retain)UILabel *nocamera;
@end
