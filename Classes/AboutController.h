//
//  AboutController.h
//  Y-Location
//
//  Created by Chris Yunker on 4/12/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewCell.h"

#define kAboutCellHeight		150
#define kAboutFontType			@"Helvetica"
#define kAboutFontSize			18

@interface AboutController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UITableView *aboutTableView;
	UITextView *aboutTextView;
}

@end
