//
//  Y_LocAppDelegate.m
//  Y-Location
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright Chris Yunker 2009. All rights reserved.
//

#import "Y_LocAppDelegate.h"
#import "MapController.h"

@implementation Y_LocAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	registry = [Registry sharedRegistry];
	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	MapController *mapController = [[MapController alloc] init];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mapController];
	navController.navigationBar.barStyle = UIBarStyleDefault;
	
	[mapController release];

	[window addSubview:navController.view];
	[window makeKeyAndVisible];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationWillTerminate:(UIApplication *)application
{	
	[registry save];
}

@end
