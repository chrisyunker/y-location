//
//  ConfirmView.m
//  Y-Location
//
//  Created by Chris Yunker on 4/13/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "ConfirmView.h"

@implementation ConfirmView

@synthesize sendButton;
@synthesize backButton;

- (id)initWithFrame:(CGRect)frame
{	
	self = [super initWithFrame:frame];
	if (!self) return nil;
	
	// Transparent Overlay
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();	
	
    CGContextRef context = CGBitmapContextCreate(NULL,
												 frame.size.width,
												 frame.size.height,
												 8,
												 (frame.size.width * 4),
												 colorSpaceRef,
												 kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpaceRef);
	
	CGContextSetRGBFillColor(context,
							 kConfirmImageColorRed,
							 kConfirmImageColorGreen,
							 kConfirmImageColorBlue,
							 kConfirmImageColorAlpha);
	
	CGContextFillRect(context, frame);
	
	CGImageRef confirmImageRef = CGBitmapContextCreateImage(context);
	self.image = [UIImage imageWithCGImage:confirmImageRef];
	
	CGImageRelease(confirmImageRef);
	CGContextRelease(context);
	
	// Navigation Bar
	UINavigationBar *navBar = [[UINavigationBar alloc]
							   initWithFrame:CGRectMake(0, 20, 320, 44)];
	navBar.barStyle = UIBarStyleDefault;
	
	UINavigationItem *titleItem = [[UINavigationItem alloc]
							  initWithTitle:NSLocalizedString(@"ConfirmViewTitle", @"")];
	
	NSArray *navItems = [[NSArray alloc] initWithObjects:titleItem, nil];
	navBar.items = navItems;
	
	[navItems release];
	[titleItem release];
	
	[self addSubview:navBar];
	[self bringSubviewToFront:navBar];
	[navBar release];
	
	// Toolbar
	UIToolbar *toolbar = [[UIToolbar alloc]
						  initWithFrame:CGRectMake(0, 436, 320, 44)];
	toolbar.barStyle = UIBarStyleDefault;
	
	sendButton = [[UIBarButtonItem alloc]
				  initWithTitle:NSLocalizedString(@"ConfirmButton", @"")
				  style:UIBarButtonItemStyleDone
				  target:nil
				  action:nil];
	
	backButton = [[UIBarButtonItem alloc]
				  initWithTitle:NSLocalizedString(@"BackButton", @"")
				  style:UIBarButtonItemStyleDone
				  target:nil
				  action:nil];
	
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
								 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
								 target:nil
								 action:nil];
	
	NSArray *toolbarItems = [[NSArray alloc] initWithObjects:sendButton, flexItem, backButton, nil];
	toolbar.items = toolbarItems;
	
	[toolbarItems release];
	[flexItem release];
	
	[self addSubview:toolbar];
	[self bringSubviewToFront:toolbar];
	[toolbar release];
	
	self.userInteractionEnabled = YES;
	
    return self;
}

- (void)dealloc
{
	DLog(@"dealloc");
	
	[sendButton release];
	[backButton release];
    [super dealloc];
}

@end
