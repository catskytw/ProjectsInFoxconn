//
//  ActiveAccountController.h
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActiveAccountController : UIViewController {
    
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    UITextField *idText;
    UITextField *phonePasswordText;
    UIButton *activeButton;
    int mode;
    BOOL bMoveUp;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UITextField *idText;
@property (nonatomic, retain) IBOutlet UITextField *phonePasswordText;
@property (nonatomic, retain) IBOutlet UIButton *activeButton;
@property (nonatomic) int mode;
- (IBAction)activeAccount:(id)sender;
-(void) setUIDefault;
-(void)setViewMovedUp:(BOOL)movedUp;
@end
