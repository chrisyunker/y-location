//
//  HereIAmAppDelegate.m
//  HereIAm
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "HereIAmAppDelegate.h"
#import "MapController.h"


@implementation HereIAmAppDelegate


- (void)applicationDidFinishLaunching:(UIApplication *)application
{	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];	
	MapController *mapController = [[MapController alloc] initWithNibName:@"MapView" bundle:nil];
	
    [window addSubview:mapController.view];
    [window makeKeyAndVisible];	
}


- (void)dealloc
{
    [super dealloc];
}


@end
