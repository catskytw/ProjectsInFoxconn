//
//  GameConfig.h
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright foxconn 2011. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationCCDirector


#endif // __GAME_CONFIG_H