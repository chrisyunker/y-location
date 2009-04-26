//
//  ErrorImageView.h
//  Y-Location
//
//  Created by Chris Yunker on 4/14/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "Constants.h"

#define kErrorWidth				280
#define kErrorHeight			80
#define kErrorMargin			7

#define kErrorColorRed			51.0f/255.0f
#define kErrorColorGreen		51.0f/255.0f 
#define kErrorColorBlue			51.0f/255.0f
#define kErrorColorAlpha		1.0f

#define kErrorCornerRadius		5.0f

#define kErrorFontType			@"Arial"
#define kErrorFontSize			20

@interface ErrorImageView : UIView
{
}

- (id)initWithErrorMessage:(NSString *)message;

@end
