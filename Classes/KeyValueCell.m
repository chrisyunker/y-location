//
//  KeyValueCell.m
//  Y-Location
//
//  Created by Chris Yunker on 4/11/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "KeyValueCell.h"

@implementation KeyValueCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	if (!self) return nil;
	
	keyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	keyLabel.textColor = [UIColor colorWithRed:kKeyColorRed
										 green:kKeyColorGreen
										  blue:kKeyColorBlue
										 alpha:kKeyColorAlpha];
	keyLabel.font = [UIFont boldSystemFontOfSize:kCellKeyFontSize];
	keyLabel.textAlignment = UITextAlignmentLeft;
	keyLabel.adjustsFontSizeToFitWidth = NO;
	keyLabel.lineBreakMode = UILineBreakModeTailTruncation;
	[self.contentView addSubview:keyLabel];
	
	valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	valueLabel.textColor = [UIColor colorWithRed:kValueColorRed
										   green:kValueColorGreen
											blue:kValueColorBlue
										   alpha:kValueColorAlpha];
	valueLabel.font = [UIFont systemFontOfSize:kCellValueFontSize];
	valueLabel.textAlignment = UITextAlignmentRight;
	valueLabel.adjustsFontSizeToFitWidth = NO;
	valueLabel.lineBreakMode = UILineBreakModeTailTruncation;
	[self.contentView addSubview:valueLabel];

	return self;
}

- (void)dealloc
{
	[keyLabel release];
	[valueLabel release];
    [super dealloc];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
		
	[keyLabel sizeToFit];
	[valueLabel sizeToFit];
	
	float maxWidth = self.contentView.frame.size.width;
	
	// Size Key Label
	CGRect frame = keyLabel.frame;
	frame.origin.x = self.contentView.frame.origin.x;
	frame.origin.y = floor((self.contentView.frame.size.height - frame.size.height) / 2);
	frame.size.width = MIN(frame.size.width, (maxWidth - kCellRightMargin));
	keyLabel.frame = frame;
	
	// Size Value Label
	frame = valueLabel.frame;
	frame.origin.x = (keyLabel.frame.origin.x + keyLabel.frame.size.width) + kCellLabelSpacing;
	frame.origin.y = floor((self.contentView.frame.size.height - frame.size.height) / 2);
	frame.size.width = maxWidth - kCellRightMargin - frame.origin.x;
	if (frame.size.width < 0)
	{
		frame.size.width = 0;
	}
	valueLabel.frame = frame;
}

- (void)setKeyText:(NSString *)text
{
	keyLabel.text = text;
}

- (void)setValueText:(NSString *)text
{
	valueLabel.text = text;
}

@end
