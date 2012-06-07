//
//  AppDelegate.m
//  MovieTask
//
//  Created by Omer Janjua on 30/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONSetupHelpers.h"
#import "CustomerViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecordHelpers setupCoreDataStack];  //settig up the initial coredata stack
    [JSONSetupHelpers performFirstTimeSetup];   //initial json import
    self.window.rootViewController = self.tabBarController; //assign the tabbar as the rootviewcontroller at intial launch, so the tab bar is the first thing the user will see
    [self.window makeKeyAndVisible];    //make the window visible
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecordHelpers cleanUp]; //clean up the save queue once the application is terminated.
}

@end
