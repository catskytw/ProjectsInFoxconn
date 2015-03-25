//
//  CompanySummaryPopup.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanySummaryPopup : UIViewController{
    IBOutlet UIImageView *_logo;
    IBOutlet UILabel *_companyName;
    IBOutlet UILabel *_companyAbstract;
    IBOutlet UIButton *_detailInfo;
    IBOutlet UIButton *_guideRoute;
    
    NSString *_locationId;
    NSString *_mapId;
    UIViewController *parentViewController;
    NSMutableArray *points;
    BOOL _isFacility;
}
@property(nonatomic,retain)UIImageView *_logo;
@property(nonatomic,retain)UILabel *_companyName;
@property(nonatomic,retain)UILabel *_companyAbstract;
@property(nonatomic,retain)UIButton *_detailInfo;
@property(nonatomic,retain)UIButton *_guideRoute;
@property(nonatomic,assign)UIViewController *parentViewController;
-(id)initWithMapId:(NSString*)mapId withLocationId:(NSString*)locationId isFacility:(BOOL)isFacility;
-(IBAction)showDetailInfo:(id)sender; // 顯示廠商明細
-(IBAction)showRouting:(id)sender; //做路徑規畫
@end
