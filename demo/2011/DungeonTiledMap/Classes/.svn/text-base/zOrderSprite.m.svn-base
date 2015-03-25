//
//  zOrderSprite.m
//  TiledmapDemo
//
//  Created by 廖 晨志 on 2011/2/24.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "zOrderSprite.h"


@implementation zOrderSprite
-(void) draw
{
	glEnable(GL_ALPHA_TEST);
	glAlphaFunc( GL_GREATER, 0 );
	[super draw];
	glDisable(GL_ALPHA_TEST);
}
@end
