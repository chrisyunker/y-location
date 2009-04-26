//
//  StatusDisplay.h
//  Y-Location
//
//  Created by Chris Yunker on 4/9/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

#define kStatusDisplayWidth		200.0f
#define kStatusDisplayHeight	28.0f

#define kStatusLabelX			8.0f
#define kStatusLabelY			4.0f
#define kStatusLabelWidth		165.0f
#define kStatusLabelHeight		21.0f

#define kActIndicatorX			176.0f
#define kActIndicatorY			4.0f
#define kActIndicatorWidth		20.0f
#define kActIndicatorHeight		20.0f

#define kBgColorRed				0.0f/255.0f
#define kBgColorGreen			0.0f/255.0f 
#define kBgColorBlue			0.0f/255.0f
#define kBgColorAlpha			1.0f

#define kBgCornerRadius			5.0f
#define kLabelFontType			@"Arial"
#define kLabelFontSize			17

@interface StatusDisplay : UIImageView
{
	UILabel *label;
	UIActivityIndicatorView *activityIndicator;
	CGRect labelCompleteFrame;
	CGRect labelPartialFrame;
}

- (void)start;
- (void)stop;
- (void)updateMessage:(NSString *)message;

@end
