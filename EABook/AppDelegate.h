//
//  AppDelegate.h
//  EABook
//
//  Created by gdlab on 12/10/26.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "GamePoint.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    GamePoint *_EAGamePoint;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) GamePoint *EAGamePoint;

@end
