//
//  Constants.h
//  Y-Location
//
//  Created by Chris Yunker on 3/21/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//
//

#include <CoreLocation/CoreLocation.h>

#define kVersionMajor			1
#define kVersionMinor			1

// User Default Keys
#define kKeySavedDefaults		@"savedDefaults"
#define kKeyMapType				@"mapType"
#define kSubjectString			@"subjectString"
#define kBodyString				@"bodyString"

// Map Settings
#define kMapTypeDefault 		0
#define kZoomLevel				17
#define kLocationAccuracy		kCLLocationAccuracyBest
#define kGoogleMapsHostname		@"maps.google.com"
#define kMapBaseUrl				@"http://ylocation.chrisyunker.com/"
#define kMapBgColor				@"gray"
#define kLatitudeThreshold		0.0001f
#define kLongitudeThreshold		0.0001f

#define kStatupCheckInterval	1.0f
#define kConfirmTransitionTime	0.3f

// Screen Dimensions
#define kMapX				0
#define kMapY				0
#define kMapWidth			320
#define kMapHeight			372

#define kToolbarX			0
#define kToolbarY			372
#define kToolbarWidth		320
#define kToolbarHeight		44

#define kWebMapX			-8
#define kWebMapY			-8
#define kWebMapWidth		336
#define kWebMapHeight		388
