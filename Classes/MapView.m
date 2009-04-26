//
//  MapView.m
//  Y-Location
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright 2009 Chris Yunker. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (id)initWithFrame:(CGRect)frame
{	
	self = [super initWithFrame:frame];
	if (!self) return nil;
	
	registry = [[Registry sharedRegistry] retain];
	
	self.userInteractionEnabled = NO;
	self.multipleTouchEnabled = YES;
	self.autoresizesSubviews = NO;
	self.scalesPageToFit = NO;
	
	NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"base" ofType:@"html"];
	NSData *data = [NSData dataWithContentsOfFile:htmlFile];
	[self loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:kMapBaseUrl]];
	
	return self;
}

- (void)dealloc
{
	DLog(@"dealloc");

	[registry release];
	[super dealloc];
}


#pragma mark - Map methods

- (void)initMapWithCenter:(CLLocationCoordinate2D)center
{
	DLog(@"Coordinate[(%f,%f)]", center.latitude, center.longitude);
		
	NSString *js = [NSString stringWithFormat:
					@"var map = new GMap2(document.getElementById(\"map_bg\"), {backgroundColor:\"%@\"});"
					"map.setMapType(%@);"
					"map.setCenter(new GLatLng(%lf, %lf), %d);"
					"map.panTo(map.getCenter());"
					"var marker = new GMarker(new GLatLng(%lf, %lf), {draggable: true});"
					"map.addOverlay(window.marker);",
					kMapBgColor,
					[registry mapCode],
					center.latitude,
					center.longitude,
					kZoomLevel,
					center.latitude,
					center.longitude];
		
	[self stringByEvaluatingJavaScriptFromString:js];
}

- (void)updateMapWithCenter:(CLLocationCoordinate2D)center;
{
	DLog(@"Coordinate[(%f,%f)]", center.latitude, center.longitude);
	
	NSString *js = [NSString stringWithFormat:
					@"marker.setLatLng(new GLatLng(%lf, %lf))",
					center.latitude,
					center.longitude];
	
	[self stringByEvaluatingJavaScriptFromString:js];	
}

- (CLLocationCoordinate2D)panToCenter
{
	CLLocationCoordinate2D coordinate;
	
	NSString *js = [NSString stringWithFormat:
					@"marker.getLatLng().toString();"];
	
	NSString *centerStr = [self stringByEvaluatingJavaScriptFromString:js];
	
    sscanf([centerStr UTF8String], "(%lf, %lf)", &coordinate.latitude, &coordinate.longitude);
	
	js = [NSString stringWithFormat:
		  @"map.panTo(new GLatLng(%lf, %lf))",
		  coordinate.latitude,
		  coordinate.longitude];
	
	[self stringByEvaluatingJavaScriptFromString:js];
	
	DLog(@"Coordinate[(%f,%f)]", coordinate.latitude, coordinate.longitude);

	return coordinate;
}

- (void)updateMapType
{
	DLog(@"MapType[%@]", [registry mapCode]);
		
	NSString *js = [NSString stringWithFormat:
					@"map.setMapType(%@)",
					[registry mapCode]];
		
	[self stringByEvaluatingJavaScriptFromString:js];
}

- (CLLocationCoordinate2D)getMarkerCoordinate
{
	CLLocationCoordinate2D coordinate;

	NSString *js = [NSString stringWithFormat:
					@"marker.getLatLng().toString();"];
		
	NSString *centerStr = [self stringByEvaluatingJavaScriptFromString:js];
		
    sscanf([centerStr UTF8String], "(%lf, %lf)", &coordinate.latitude, &coordinate.longitude);
	
	DLog(@"Coordinate[(%f,%f)]", coordinate.latitude, coordinate.longitude);

    return coordinate;
}

- (int)getZoomLevel
{	
	NSString *js = [NSString stringWithFormat:
					@"map.getZoom();"];
	
	return [[self stringByEvaluatingJavaScriptFromString:js] intValue];
}

@end
