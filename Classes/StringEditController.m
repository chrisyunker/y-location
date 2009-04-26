//
//  EmailBodyController.m
//  Y-Location
//
//  Created by Chris Yunker on 4/10/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "StringEditController.h"

@interface StringEditController (Private)

- (void)clear;

@end


@implementation StringEditController

@synthesize key;

- (id)initWithStringKey:(NSString *)aKey
{
	self = [super init];
	if (!self) return nil;
		
	self.key = aKey;
	self.title = NSLocalizedString(aKey, @"");
	registry = [[Registry sharedRegistry] retain];
	
	return self;
}

- (void)dealloc
{
	DLog(@"dealloc");

	[key release];
	[registry release];
	configTableView.delegate = nil;
	[configTableView release];
	configTextView.delegate = nil;
	[configTextView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
	ALog(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[configTextView becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	NSInteger length = configTextView.text.length;
	configTextView.selectedRange = NSMakeRange(length, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
		
	[registry setValue:configTextView.text forKey:key];
}

- (void)loadView
{
	[super loadView];
	
	UIBarButtonItem *clearButton = [[[UIBarButtonItem alloc]
									 initWithTitle:NSLocalizedString(@"ClearButton", @"")
									 style:UIBarButtonItemStyleBordered
									 target:self
									 action:@selector(clear)] autorelease];
	self.navigationItem.rightBarButtonItem = clearButton;
	
	configTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    configTextView.textColor = [UIColor blackColor];
    configTextView.font = [UIFont fontWithName:kFontName size:kStringEditFontSize];
    configTextView.delegate = self;
    configTextView.backgroundColor = [UIColor whiteColor];
	configTextView.text = [registry valueForKey:key];
	configTextView.returnKeyType = UIReturnKeyDefault;
	configTextView.keyboardType = UIKeyboardTypeDefault;
	
	configTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]
												   style:UITableViewStyleGrouped];	
	configTableView.delegate = self;
	configTableView.dataSource = self;
	configTableView.autoresizesSubviews = YES;
	self.view = configTableView;
}

- (void)clear
{
	configTextView.text = @"";
}


#pragma mark - UITableViewDelegate methods

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kStringEditCellHeight;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	UITableViewCell *cell = [[[TextViewCell alloc] initWithReuseIdentifier:nil] autorelease];
			
	((TextViewCell *)cell).textView = configTextView;

	return cell;
}

@end
