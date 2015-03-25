//
//  FcTabUIComponent.h
//  FcTabUIComponent
//
//  Created by 廖 晨志 on 2011/5/17.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "NinePatch.h"
#define FontSize 17.0f
#define PADDINGSPACE 20.0f
@interface FcTabUIComponent : UIViewController {
    @private
    NSArray *_titleStrings;
    NSArray *_titleViews;
    CGRect _contentRect;
    NSMutableArray *_btns;
    
    UIImageView *_lineView;
    UIView *mainContainer;
    
    NSInteger selectedIndex;
    @public
    //設定為public,方便外部於runtime可抽換不同tab之內容
    NSMutableArray *_tabViews;
}
-(id)initWithTabStrings:(NSArray*)titles withRect:(CGRect)rect withContainerViews:(NSArray*)containers;
-(id)initWithViews:(NSArray*)views withRect:(CGRect)rect withContainerViews:(NSArray*)containers;
@end
