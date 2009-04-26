//
//  StatusDisplay.m
//  Y-Location
//
//  Created by Chris Yunker on 4/9/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "StatusDisplay.h"

@interface StatusDisplay (Private)

- (UIImage *)createBgImage;

@end


@implementation StatusDisplay

- (id)init
{
	self = [super initWithFrame:CGRectMake(0, 0, kStatusDisplayWidth, kStatusDisplayHeight)];
	if (!self) return nil;
	
	self.image = [self createBgImage];
	
	activityIndicator = [[UIActivityIndicatorView alloc]
						 initWithFrame:CGRectMake(kActIndicatorX,
												  kActIndicatorY,
												  kActIndicatorWidth,
												  kActIndicatorHeight)];
	activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
										  UIViewAutoresizingFlexibleRightMargin |
										  UIViewAutoresizingFlexibleTopMargin |
										  UIViewAutoresizingFlexibleBottomMargin);
		
	labelCompleteFrame = CGRectMake(kStatusLabelX,
									kStatusLabelY,
									kStatusLabelWidth + kActIndicatorWidth,
									kStatusLabelHeight);
	labelPartialFrame = CGRectMake(kStatusLabelX,
								   kStatusLabelY,
								   kStatusLabelWidth,
								   kStatusLabelHeight);
	
	label = [[UILabel alloc] initWithFrame:labelCompleteFrame];
	label.adjustsFontSizeToFitWidth = YES;
	label.backgroundColor = [UIColor colorWithRed:kBgColorRed
											green:kBgColorGreen
											 blue:kBgColorBlue
											alpha:kBgColorAlpha];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontWithName:kLabelFontType size:kLabelFontSize];
		
	[self addSubview:label];
	
	return self;
}

- (void)dealloc
{
	[label removeFromSuperview];
	[label release];
	[activityIndicator removeFromSuperview];
	[activityIndicator release];
    [super dealloc];
}

- (void)start
{
	label.frame = labelPartialFrame;
	[self addSubview:activityIndicator];
	[activityIndicator startAnimating];
}

- (void)stop
{
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	label.frame = labelCompleteFrame;
}

- (void)updateMessage:(NSString *)message
{
	label.text = message;
}

- (UIImage *)createBgImage;
{
	CGContextRef context = [Util createBitmapContextForWidth:kStatusDisplayWidth
													  height:kStatusDisplayHeight];
	
	CGMutablePathRef pathRef = CGPathCreateMutable();
	[Util drawRoundedRectForPath:pathRef
							rect:CGRectMake(0, 0, kStatusDisplayWidth, kStatusDisplayHeight)
						  radius:kBgCornerRadius];
	CGContextAddPath(context, pathRef);
	
	CGContextSetRGBFillColor(context,
							 kBgColorRed,
							 kBgColorGreen,
							 kBgColorBlue,
							 kBgColorAlpha);
	CGContextFillPath(context);
	
	CGImageRef bgImageRef = CGBitmapContextCreateImage(context);
	UIImage *bgImage = [UIImage imageWithCGImage:bgImageRef];
	
	CGPathRelease(pathRef);
	CGImageRelease(bgImageRef);
	CGContextRelease(context);
	
	return bgImage;
}

@end
