//
//  ConfigController.m
//  Y-Location
//
//  Created by Chris Yunker on 3/21/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "ConfigController.h"

@interface ConfigController (Private)

- (void)resetSettings;
- (void)confirmResetSettings;
- (void)changeMapType;

@end


@implementation ConfigController

@synthesize configTableView;
@synthesize mapTypeControl;

enum TableSections
{
	kMapTypeSection = 0,
	kCustomEmailSection,
	kResetSection,
	kAboutSection
};

static NSString *idMapTypeCell = @"IDMapTypeCell";
static NSString *idKeyValueCell = @"IDKeyValueCell";
static NSString *idResetCell = @"IDResetCell";
static NSString *idAboutCell = @"IDAboutCell";

- (id)initWithMapController:(MapController *)aMapController
{
	self = [super init];
	if (!self) return nil;
	
	self.title = NSLocalizedString(@"ConfigureTitle", @"");
	
	registry = [[Registry sharedRegistry] retain];
	mapController = [aMapController retain];
	
	return self;
}

- (void)dealloc
{
	DLog(@"dealloc");

	configTableView.delegate = nil;
	[configTableView release];
	[mapTypeControl release];
	[mapController release];
	[registry release];
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
	
	[configTableView reloadData];
}

- (void)changeMapType
{
	int newMapType = [mapTypeControl selectedSegmentIndex];
	
	registry.mapType = newMapType;
		
	[mapController updateMapType];
		
	[self dismissModalViewControllerAnimated:YES];
}

- (void)createMapTypeMenu
{
	NSArray *items = [NSArray arrayWithObjects:NSLocalizedString(@"MapButton", @""),
					  NSLocalizedString(@"SatelliteButton", @""),
					  NSLocalizedString(@"HybridButton", @""),
					  NSLocalizedString(@"PhysicalButton", @""),
					  nil];
	mapTypeControl = [[UISegmentedControl alloc] initWithItems:items];
	mapTypeControl.segmentedControlStyle = UISegmentedControlStylePlain;
	mapTypeControl.momentary = NO;
	
	[mapTypeControl setFrame:CGRectMake(9.0f, 0.0f, 302.0f, 45.0f)];	
	[mapTypeControl setSelectedSegmentIndex:registry.mapType];
	[mapTypeControl addTarget:self
					   action:@selector(changeMapType)
			 forControlEvents:UIControlEventValueChanged];
}

- (void)loadView
{	
	// create and configure the table view
	configTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];	
	configTableView.delegate = self;
	configTableView.dataSource = self;
	configTableView.autoresizesSubviews = YES;
	configTableView.scrollEnabled = NO;
	self.view = configTableView;
	
	[self createMapTypeMenu];
}

- (void)resetSettings
{
	DLog(@"resetSettings");
	
	UIActionSheet *confirmMenu = [[UIActionSheet alloc]
								  initWithTitle:NSLocalizedString(@"ConfirmResetTitle", @"")
								  delegate:self
								  cancelButtonTitle:NSLocalizedString(@"CancelButton", @"")
								  destructiveButtonTitle:NSLocalizedString(@"ResetButton", @"")
								  otherButtonTitles:nil];
	[confirmMenu setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[confirmMenu showInView:[self.view window]];
	[confirmMenu release];
}

- (void)confirmResetSettings
{
	DLog(@"confirmResetSettings");

	[registry resetSettings];
	[mapTypeControl setSelectedSegmentIndex:registry.mapType];
	[configTableView reloadData];
}


#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	if (buttonIndex == 0)
	{
		[self confirmResetSettings];
	}
}


#pragma mark - UITableViewDelegate methods

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section)
	{
		case kCustomEmailSection:
		{
			return UITableViewCellAccessoryDisclosureIndicator;
		}
		case kResetSection:
		{
			return UITableViewCellAccessoryNone;
		}
		case kAboutSection:
		{
			return UITableViewCellAccessoryDisclosureIndicator;
		}
		default:
		{
			return UITableViewCellAccessoryNone;
		}
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	
	switch (indexPath.section)
	{
		case kCustomEmailSection:
		{
			if (row == 0)
			{
				[[self navigationController] pushViewController:[[[StringEditController alloc]
																  initWithStringKey:kSubjectString] autorelease] animated:YES];
				[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
			}
			else if (row == 1)
			{
				[[self navigationController] pushViewController:[[[StringEditController alloc]
																  initWithStringKey:kBodyString] autorelease] animated:YES];
				[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
			}
			
			break;
		}
		case kResetSection:
		{
			[self resetSettings];
			[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

			break;
		}
		case kAboutSection:
		{
			[[self navigationController] pushViewController:[[[AboutController alloc] init] autorelease] animated:YES];
			[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
			
			break;
		}
	}
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	switch (section)
	{
		case kMapTypeSection:		return 1;
		case kCustomEmailSection:	return 2;
		case kResetSection:			return 1;
		case kAboutSection:			return 1;
		default:					return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{	
	switch (section)
	{
		case kMapTypeSection:
		{
			return NSLocalizedString(@"ConfHeaderMapType", @"");
		}
		case kCustomEmailSection:
		{
			return NSLocalizedString(@"ConfHeaderEmail", @"");
		}
		default:
		{
			return nil;
		}
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	NSInteger row = [indexPath row];
	UITableViewCell *cell;
	
	switch (indexPath.section)
	{
		case kMapTypeSection:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:idMapTypeCell];
			if (!cell)
			{
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:idMapTypeCell] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				[cell addSubview:mapTypeControl];
			}
			
			break;
		}
		case kCustomEmailSection:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:idKeyValueCell];
			if (!cell)
			{				
				cell = [[[KeyValueCell alloc] initWithReuseIdentifier:idKeyValueCell] autorelease];
			}
			if (row == 0)
			{
				[(KeyValueCell *)cell setKeyText:NSLocalizedString(kSubjectString, @"")];				
				[(KeyValueCell *)cell setValueText:[registry valueForKey:kSubjectString]];
			}
			else
			{
				[(KeyValueCell *)cell setKeyText:NSLocalizedString(kBodyString, @"")];
				[(KeyValueCell *)cell setValueText:[registry valueForKey:kBodyString]];
			}
			break;
		}
		case kResetSection:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:idResetCell];
			if (!cell)
			{
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:idResetCell] autorelease];
				cell.textLabel.text = NSLocalizedString(@"ResetButton", @"");
				cell.textLabel.textAlignment = UITextAlignmentCenter;
			}
			break;
		}
		case kAboutSection:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:idAboutCell];
			if (!cell)
			{				
				cell = [[[KeyValueCell alloc] initWithReuseIdentifier:idAboutCell] autorelease];
				[(KeyValueCell *)cell setKeyText:NSLocalizedString(@"AboutLink", @"")];
				[(KeyValueCell *)cell setValueText:@""];
			}
			break;
		}
	}
	
	return cell;
}

@end
