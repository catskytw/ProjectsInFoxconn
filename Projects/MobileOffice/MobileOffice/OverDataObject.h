//
//  OverDataObject.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/11/30.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataObjectProtoType.h"
@interface OverDataObject : DataObjectProtoType{
    NSMutableArray *otList; 
}
@property(nonatomic,retain)NSMutableArray *otList;
@end
