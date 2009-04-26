//
//  TextViewCell.h
//  Y-Location
//
//  Created by Chris Yunker on 4/11/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTextViewCellMargin 8.0

@interface TextViewCell : UITableViewCell
{
	UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
