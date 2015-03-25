//
//  HomeButtonDataObject.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeButtonDataObject : NSObject{
    NSString *title,*imgFileName;
    NSInteger tag;
}
@property(nonatomic,retain)NSString *title,*imageFileName;
@property(nonatomic)NSInteger tag;
- (id)initWithTitle:(NSString*)_title withImage:(NSString*)fileName withTag:(NSInteger)_tag;
@end
