//
//  Attendance1View.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentXibView.h"
@interface Attendance1View : ContentXibView<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    BOOL firstView;
}
@end
