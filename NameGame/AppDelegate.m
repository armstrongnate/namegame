//
//  AppDelegate.m
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import NameGameKit;

#import "AppDelegate.h"
#import "LearnViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NGPersistenceController *persistenceController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.persistenceController = [[NGPersistenceController alloc] initWithCallback:^{
		[self loadUI];
	}];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[self.persistenceController save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self.persistenceController save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self.persistenceController save];
}

- (void)loadUI
{
	LearnViewController *learn = (LearnViewController *)self.window.rootViewController;
	learn.context = self.persistenceController.managedObjectContext;
}

@end
