//
//  KeyValueCell.h
//  Y-Location
//
//  Created by Chris Yunker on 4/11/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellKeyFontSize	17
#define kCellValueFontSize	17
#define kCellRightMargin	10
#define kCellLabelSpacing	10

#define kKeyColorRed		0.0f/255.0f
#define kKeyColorGreen		0.0f/255.0f 
#define kKeyColorBlue		0.0f/255.0f
#define kKeyColorAlpha		1.0f

#define kValueColorRed		63.0f/255.0f
#define kValueColorGreen	90.0f/255.0f 
#define kValueColorBlue		141.0f/255.0f
#define kValueColorAlpha	1.0f

@interface KeyValueCell : UITableViewCell
{
	UILabel* keyLabel;
    UILabel* valueLabel;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setKeyText:(NSString *)text;
- (void)setValueText:(NSString *)text;

@end
