//
//  QRCodeScanViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vars.h"
#ifdef QRCODE
#import "ZXingWidgetController.h"
#endif
#import "BaseViewController.h"

@interface QRCodeScanViewController : BaseViewController
#ifdef QRCODE
<ZXingDelegate>
#endif
{

	IBOutlet UIView *picView;
}
@property(nonatomic,retain)IBOutlet UIView *picView;
@end
