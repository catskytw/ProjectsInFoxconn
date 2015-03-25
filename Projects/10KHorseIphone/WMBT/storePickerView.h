//
//  storePickerView.h
//  WMBT
//
//  Created by link on 2011/6/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface storePickerView : UIView {
    
    IBOutlet UILabel *storeName;
}
@property (nonatomic, retain)  UILabel *storeName;
- (void) setName:(NSString*)name;
@end
