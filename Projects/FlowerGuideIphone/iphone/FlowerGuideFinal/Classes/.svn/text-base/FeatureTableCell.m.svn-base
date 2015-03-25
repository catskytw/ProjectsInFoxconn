//
//  FutureTableCell.m
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeatureTableCell.h"
#import "ContentObject.h"
#import "CommonContentDescriptionView.h"
#import "AboutFutureModel.h"
#import "Vars.h"
@implementation FeatureTableCell
@synthesize title1,title2,title3,button1,button2,button3,currentNavigationController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


-(IBAction)buttonAction:(id)sender{
	UIButton *thisButton=(UIButton*)sender;
	NSString *key=thisButton.titleLabel.text;
	ContentObject *dataObject=[AboutFutureModel getFeatureContent:key];
	CommonContentDescriptionView *nextController=[[CommonContentDescriptionView alloc]initWithDataObject:dataObject];
	[currentNavigationController pushViewController:nextController animated:YES];
	[nextController release];
}
@end
