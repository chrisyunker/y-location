//
//  Util.h
//  Y-Location
//
//  Created by Chris Yunker on 3/1/09.
//  Copyright 2009 chrisyunker.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Constants.h"

@interface Util : NSObject {}

+ (BOOL)checkConnectivity;
+ (CGContextRef)createBitmapContextForWidth:(float)width height:(float)height;
+ (void)drawRoundedRectForPath:(CGMutablePathRef)path rect:(CGRect)rect radius:(float)radius;

@end
