//
//  EmailBodyController.h
//  Y-Location
//
//  Created by Chris Yunker on 4/10/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewCell.h"
#import "Registry.h"

#define kFontName				@"Arial"
#define kStringEditFontSize		18.0
#define kStringEditCellHeight	150.0

@interface StringEditController : UIViewController <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
	NSString *key;
	Registry *registry;
	UITableView *configTableView;
	UITextView *configTextView;
}

@property (nonatomic, retain) NSString *key;

- (id)initWithStringKey:(NSString *)aKey;

@end
