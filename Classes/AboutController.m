//
//  AboutController.m
//  Y-Location
//
//  Created by Chris Yunker on 4/12/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "AboutController.h"

@implementation AboutController

- (id)init
{
    self = [super init];
	if (!self) return nil;
		
	self.title =  NSLocalizedString(@"AboutTitle", @"");
	
    return self;
}

- (void)dealloc
{
	DLog(@"dealloc");

	aboutTableView.delegate = nil;
	[aboutTableView release];
	[aboutTextView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
	ALog(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
}

- (void)loadView
{
	[super viewDidLoad];
			
	aboutTextView = [[UITextView alloc] initWithFrame:CGRectZero];
	aboutTextView.textColor = [UIColor blackColor];
	aboutTextView.backgroundColor = [UIColor whiteColor];
	aboutTextView.font = [UIFont fontWithName:kAboutFontType size:kAboutFontSize];
	aboutTextView.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"AboutText", @"")];
	aboutTextView.editable = NO;
	
	aboutTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]
												   style:UITableViewStyleGrouped];	
	aboutTableView.delegate = self;
	aboutTableView.dataSource = self;
	aboutTableView.autoresizesSubviews = YES;
	aboutTableView.scrollEnabled = NO;
	self.view = aboutTableView;							 
}


#pragma mark - UITableViewDelegate methods

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kAboutCellHeight;
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
	
	((TextViewCell *)cell).textView = aboutTextView;
	
	return cell;
}

@end
