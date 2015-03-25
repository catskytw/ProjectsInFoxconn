//
//  MRTDescriptionViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusDescriptionViewController.h"

@interface MRTDescriptionViewController :  BusDescriptionViewController<UIAlertViewDelegate>{
}
-(id)initWithKey:(NSString*)key;
@end
