//
//  Registry.m
//  Y-Location
//
//  Created by Chris Yunker on 2/16/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "Registry.h"

@interface Registry (Private)

- (void)load;

@end

@implementation Registry

@synthesize mapType;
@synthesize subjectString;
@synthesize bodyString;
@synthesize mapCodesForInt;
@synthesize mapUrlCodesForInt;
@synthesize mapNamesForInt;

static Registry *registry = NULL;

+ (Registry *)sharedRegistry
{
	if (!registry)
	{
		registry = [[Registry alloc] init];
	}
	return registry;
}

- (id)init
{	
	if (!registry)
	{
		registry = [super init];
	
		NSArray *mapCodes = [NSArray
							 arrayWithObjects:@"G_NORMAL_MAP",
							 @"G_SATELLITE_MAP",
							 @"G_HYBRID_MAP",
							 @"G_PHYSICAL_MAP",
							 nil];
		NSArray *mapUrlCodes = [NSArray
							 arrayWithObjects:@"m",
							 @"k",
							 @"h",
							 @"p",
							 nil];
		NSArray *mapNames = [NSArray
							 arrayWithObjects:@"Normal Map",
							 @"Satellite Map",
							 @"Hybrid Map",
							 @"Physical Map",
							 nil];
		NSArray *keys = [NSArray
						 arrayWithObjects:[NSNumber numberWithInt:0],
						 [NSNumber numberWithInt:1],
						 [NSNumber numberWithInt:2],
						 [NSNumber numberWithInt:3],
						 nil];
		
		mapCodesForInt = [[NSDictionary dictionaryWithObjects:mapCodes forKeys:keys] retain];
		mapUrlCodesForInt = [[NSDictionary dictionaryWithObjects:mapUrlCodes forKeys:keys] retain];
		mapNamesForInt = [[NSDictionary dictionaryWithObjects:mapNames forKeys:keys] retain];
		
		[self load];
	}
	return registry;
}

- (void)dealloc
{
	[subjectString release];
	[bodyString release];
	[mapCodesForInt release];
	[mapUrlCodesForInt release];
	[mapNamesForInt release];
	[mapModeButton release];
	[super dealloc];
}

- (NSString *)mapCode
{	
	NSString *mapCode = [mapCodesForInt objectForKey:[NSNumber numberWithInt:mapType]];
	if (mapCode != nil)
	{
		return mapCode;
	}
	else
	{
		ALog(@"Failed to get map code for mapType:[%d]", mapType);
		return @"G_NORMAL_MAP";
	}
}

- (NSString *)mapUrlCode
{	
	NSString *mapUrlCode = [mapUrlCodesForInt objectForKey:[NSNumber numberWithInt:mapType]];
	if (mapUrlCode != nil)
	{
		return mapUrlCode;
	}
	else
	{
		ALog(@"Failed to get map URL code for mapType:[%d]", mapType);
		return @"n";
	}
}

- (void)load
{
	DLog(@"Registry:load");
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	bool savedDefaults = [defaults boolForKey:kKeySavedDefaults];
	if (savedDefaults)
	{
		mapType = [defaults integerForKey:kKeyMapType];
		subjectString = [defaults stringForKey:kSubjectString];
		bodyString = [defaults stringForKey:kBodyString];
	}
	else
	{
		mapType = kMapTypeDefault;
		subjectString = NSLocalizedString(@"DefaultSubjectString", @"");
		bodyString = NSLocalizedString(@"DefaultBodyString", @"");
	}
}

- (void)save
{
	DLog(@"Registry:save");

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:YES forKey:kKeySavedDefaults];
	[defaults setInteger:mapType forKey:kKeyMapType];
	[defaults setObject:subjectString forKey:kSubjectString];
	[defaults setObject:bodyString forKey:kBodyString];
	[defaults synchronize];	
}

- (void)resetSettings
{
	self.mapType = kMapTypeDefault;
	self.subjectString = NSLocalizedString(@"DefaultSubjectString", @"");
	self.bodyString = NSLocalizedString(@"DefaultBodyString", @"");
}


@end
