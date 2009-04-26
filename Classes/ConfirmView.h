//
//  ConfirmView.h
//  Y-Location
//
//  Created by Chris Yunker on 4/13/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kConfirmImageColorRed		130.0f/255.0f
#define kConfirmImageColorGreen		130.0f/255.0f 
#define kConfirmImageColorBlue		130.0f/255.0f
#define kConfirmImageColorAlpha		0.4f

@interface ConfirmView : UIImageView
{
	UIBarButtonItem *sendButton;
	UIBarButtonItem *backButton;
}

@property (nonatomic, readonly) UIBarButtonItem *sendButton;
@property (nonatomic, readonly) UIBarButtonItem *backButton;

@end
