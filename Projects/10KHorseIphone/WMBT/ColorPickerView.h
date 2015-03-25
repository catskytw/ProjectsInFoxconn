//
//  ColorPickerView.h
//  WMBT
//
//  Created by link on 2011/6/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColorPickerView : UIView {
    IBOutlet UILabel *nameLabel;
    IBOutlet UIView *colorView;
    NSString *strColor;
}

@property (nonatomic, retain)  UILabel *nameLabel;
@property (nonatomic, retain)  UIView *colorView;
- (void) setColor:(NSString*)sColor andTitle:(NSString*) sTitle;


@end
