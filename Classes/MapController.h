//
//  MapController.h
//  Y-Location
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright Chris Yunker 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Registry.h"
#import "Util.h"
#import "ConfirmView.h"
#import "MapView.h"
#import "ConfigController.h"
#import "StatusDisplay.h"
#import "ErrorImageView.h"

@interface MapController : UIViewController <CLLocationManagerDelegate, UIWebViewDelegate>
{
	ConfirmView *confirmView;
	UIToolbar *toolbar;
	UIBarButtonItem *sendButton;
	StatusDisplay *display;
	CLLocationManager *locationManager;
	CLLocation *gpsLocation;
	CLLocationCoordinate2D confirmCord;
	int	confirmZoomLevel;
	MapView *mapView;
	Registry *registry;
	BOOL validLoc;
}

@property (nonatomic, retain) CLLocation *gpsLocation;

- (void)updateMapType;

@end

