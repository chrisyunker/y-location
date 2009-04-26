//
//  MapView.h
//  Y-Location
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Registry.h"

@interface MapView : UIWebView
{
	Registry *registry;
}

- (void)initMapWithCenter:(CLLocationCoordinate2D)center;
- (void)updateMapWithCenter:(CLLocationCoordinate2D)center;
- (CLLocationCoordinate2D)panToCenter;
- (void)updateMapType;
- (CLLocationCoordinate2D)getMarkerCoordinate;
- (int)getZoomLevel;

@end
