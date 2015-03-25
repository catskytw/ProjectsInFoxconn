//
//  MRTInfoStationCellObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MRTInfoStationCellObject : UITableViewCell {
	IBOutlet UIImageView *linePass;
	IBOutlet UIImageView *lineIcon;
	IBOutlet UILabel *stationName;
	IBOutlet UIImageView *aTrans;
	IBOutlet UIImageView *bTrans;
	IBOutlet UIImageView *tTrans;
	IBOutlet UIImageView *hTrans;
}
@property(nonatomic,retain)UIImageView *linePass;
@property(nonatomic,retain)UIImageView *lineIcon;
@property(nonatomic,retain)UILabel *stationName;
@property(nonatomic,retain)UIImageView *aTrans;
@property(nonatomic,retain)UIImageView *tTrans;
@property(nonatomic,retain)UIImageView *hTrans;
@property(nonatomic,retain)UIImageView *bTrans;
@end
