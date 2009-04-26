//
//  ErrorImageView.m
//  Y-Location
//
//  Created by Chris Yunker on 4/14/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "ErrorImageView.h"

@implementation ErrorImageView

- (id)initWithErrorMessage:(NSString *)message
{	
	self = [self initWithFrame:CGRectMake(0, 0, kMapWidth, kMapHeight)];
	if (!self) return nil;
	
	CGContextRef context = [Util createBitmapContextForWidth:kErrorWidth
													  height:kErrorHeight];
	
	CGMutablePathRef pathRef = CGPathCreateMutable();
	[Util drawRoundedRectForPath:pathRef
							rect:CGRectMake(0, 0, kErrorWidth, kErrorHeight)
						  radius:kErrorCornerRadius];
	CGContextAddPath(context, pathRef);
	
	CGContextSetRGBFillColor(context,
							 kErrorColorRed,
							 kErrorColorGreen,
							 kErrorColorBlue,
							 kErrorColorAlpha);
	CGContextFillPath(context);
	
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(((kMapWidth - kErrorWidth)/2),
																			((kMapHeight - kErrorHeight)/2),
																			kErrorWidth,
																			kErrorHeight)] autorelease];
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	imageView.image = [UIImage imageWithCGImage:imageRef];
	[self addSubview:imageView];
	
	CGPathRelease(pathRef);
	CGImageRelease(imageRef);
	CGContextRelease(context);
		
	float textViewWidth = kErrorWidth - (2 * kErrorMargin);
	float textViewHeight = kErrorHeight - (2 * kErrorMargin);
	
	UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectMake(((kMapWidth - textViewWidth)/2),
																		((kMapHeight - textViewHeight)/2),
																		textViewWidth,
																		textViewHeight)] autorelease];
	textView.backgroundColor = [UIColor clearColor];
	textView.text = message;
	textView.textAlignment = UITextAlignmentCenter;
	textView.editable = NO;
	textView.textColor = [UIColor whiteColor];
	textView.font = [UIFont fontWithName:kErrorFontType size:kErrorFontSize];
	
	[self addSubview:textView];
	
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
