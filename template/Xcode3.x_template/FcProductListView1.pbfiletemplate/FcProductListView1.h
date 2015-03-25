//
//  ProductListView.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FcProductListView1 : UIViewController {
	NSInteger startIndexInQueryPattern;
	id dataSource;
}
@property(nonatomic,retain)id dataSource;
-(id)initWithProductNumber:(NSInteger)number withStartIndex:(NSInteger)index;

@end
