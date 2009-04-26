//
//  ConfigController.h
//  Y-Location
//
//  Created by Chris Yunker on 3/21/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registry.h"
#import "MapController.h"
#import "StringEditController.h"
#import "AboutController.h"
#import "KeyValueCell.h"

@class MapController;

@interface ConfigController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
	UITableView *configTableView;
	UISegmentedControl *mapTypeControl;
	MapController *mapController;
	Registry *registry;
}

@property (nonatomic, retain) UITableView *configTableView;
@property (nonatomic, retain) UISegmentedControl *mapTypeControl;

- (id)initWithMapController:(MapController *)aMapController;

@end
