//
//  TextViewCell.m
//  Y-Location
//
//  Created by Chris Yunker on 4/11/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

@synthesize textView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	if (!self) return nil;
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;

	return self;
}

- (void)dealloc
{
	[textView release];
    [super dealloc];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect contentRect = [self.contentView bounds];
	
	if (contentRect.size.width > (kTextViewCellMargin * 2))
	{		
		textView.frame = CGRectMake(contentRect.origin.x + kTextViewCellMargin,
									contentRect.origin.y + kTextViewCellMargin,
									contentRect.size.width - (kTextViewCellMargin * 2),
									contentRect.size.height - (kTextViewCellMargin * 2));
	}
}

- (void)setTextView:(UITextView *)aTextView
{	
	textView = [aTextView retain];
	[self.contentView addSubview:aTextView];
	[self layoutSubviews];
}

@end
