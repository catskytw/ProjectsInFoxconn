//
//  BottomControlPanel.h
//  FlowerGuide
//
//  Created by Liao Change on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionInfoObject.h"
@interface BottomControlPanel : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
	BOOL isOpen;
	IBOutlet UIButton *switchBtn;
	IBOutlet UITableView *contentTable;
	NSMutableArray *exhibitionDataArray;
	
	NSString *destinationString;
}
@property(nonatomic,retain)UIButton *switchBtn;
@property(nonatomic,retain)UITableView *contentTable;
@property(nonatomic)BOOL isOpen;
-(IBAction)switchBtn:(id)sender;
-(void)changeValue:(ExhibitionInfoObject*)dataObject;

-(void)setButtonEnable;
-(void)setButtonDisable;
@end
