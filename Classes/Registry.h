//
//  Registry.h
//  Y-Location
//
//  Created by Chris Yunker on 2/16/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@interface Registry : NSObject
{
	int mapType;
	NSString *subjectString;
	NSString *bodyString;
	NSDictionary *mapCodesForInt;
	NSDictionary *mapUrlCodesForInt;
	NSDictionary *mapNamesForInt;
	UIBarButtonItem *mapModeButton;
}

@property (assign) int mapType;
@property (retain) NSString *subjectString;
@property (retain) NSString *bodyString;
@property (nonatomic, readonly) NSDictionary *mapCodesForInt;
@property (nonatomic, readonly) NSDictionary *mapUrlCodesForInt;
@property (nonatomic, readonly) NSDictionary *mapNamesForInt;

+ (Registry *)sharedRegistry;
- (void)save;
- (void)resetSettings;
- (NSString *)mapCode;
- (NSString *)mapUrlCode;

@end
