//
//  PopoverContentTemplate1.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/4/12.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopoverContentTemplate1Delegate
-(void)priceSelected:(NSString*)price;
-(void)colorSelected:(NSString*)color;
-(void)brandSelected:(NSString*)brand;
@end

@interface PopoverContentTemplate1 : UITableViewController {
    NSMutableArray *dataArray;
    NSInteger filterEnum;
    id<PopoverContentTemplate1Delegate>_delegate;
}
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,assign)id<PopoverContentTemplate1Delegate>delegate;
@property(nonatomic)NSInteger filterEnum;
-(id)initWithDataArray:(NSMutableArray*)sourceData;
@end
