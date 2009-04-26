//
//  MapController.m
//  Y-Location
//
//  Created by Chris Yunker on 3/16/09.
//  Copyright Chris Yunker 2009. All rights reserved.
//

#import "MapController.h"

@interface MapController (Private)

- (void)checkInitialization:(NSTimer *)timer;
- (void)configure;
- (void)confirmSend;
- (void)sendEmail;
- (void)cancelSend;

@end


@implementation MapController

@synthesize gpsLocation;

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	self.title = NSLocalizedString(@"YLocationTitle", @"");
	
	registry = [[Registry sharedRegistry] retain];
	validLoc = NO;
	
	// Location Manager
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	[locationManager setDesiredAccuracy:kLocationAccuracy];
	[locationManager startUpdatingLocation];
	
    return self;
}

- (void)dealloc
{
	DLog(@"dealloc");
	
	[confirmView release];
	[toolbar release];
	[sendButton release];
	[display release];
	locationManager.delegate = nil;
	[locationManager release];
	[gpsLocation release];
	mapView.delegate = nil;
	[mapView release];
	[registry release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
	ALog(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
}

- (void)createToolbar
{
	// Status Display
	display = [[StatusDisplay alloc] init];

	// Send Button
	sendButton = [[UIBarButtonItem alloc]
				  initWithTitle:NSLocalizedString(@"SendButton", @"")
				  style:UIBarButtonItemStyleBordered
				  target:self
				  action:@selector(confirmSend)];

	// Toolbar
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(kToolbarX,
														  kToolbarY,
														  kToolbarWidth,
														  kToolbarHeight)];
	toolbar.barStyle = UIBarStyleDefault;
	
	UIBarButtonItem *displayItem = [[UIBarButtonItem alloc] initWithCustomView:display];
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
								  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
								  target:nil
								  action:nil];
	
	NSArray *items = [[NSArray alloc] initWithObjects:flexItem, displayItem, sendButton, nil];
	toolbar.items = items;
	[items release];
	[displayItem release];
	[flexItem release];
	
	[self.view addSubview:toolbar];
}

- (BOOL)checkConnectivity
{
	if (![Util checkConnectivity])
	{
		[display stop];
		[display updateMessage:NSLocalizedString(@"StatusNoConn", @"")];
		
		ErrorImageView *eiv = [[ErrorImageView alloc]
							   initWithErrorMessage:NSLocalizedString(@"MessageNoConn", @"")];
		[self.view addSubview:eiv];
		[eiv release];
		
		return NO;
	}

	return YES;
}

- (BOOL)checkLocationServices
{	
	if (![locationManager locationServicesEnabled])
	{
		[display stop];
		[display updateMessage:NSLocalizedString(@"StatusNoLocService", @"")];

		ErrorImageView *eiv = [[ErrorImageView alloc]
							   initWithErrorMessage:NSLocalizedString(@"MessageNoLocService", @"")];
		[self.view addSubview:eiv];
		[eiv release];
		
		return NO;
	}
	
	return YES;
}

- (void)loadView
{
    [super loadView];
		
	// Navigation Bar
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc]
									   initWithTitle:NSLocalizedString(@"SettingsButton", @"")
									   style:UIBarButtonItemStyleBordered
									   target:self
									   action:@selector(configure)];
	self.navigationItem.rightBarButtonItem = settingsButton;
	[settingsButton release];
	
	// Create Toolbar and set initial state
	[self createToolbar];
	[display start];
	[display updateMessage:NSLocalizedString(@"StatusLoading", @"")];
	sendButton.enabled = NO;

	// If we have a valid location, then this is a restart due to low memory
	if (!validLoc)
	{
		// Check Internet/Location Requirements
		if ((![self checkConnectivity]) ||
			(![self checkLocationServices]))
		{
			return;
		}
	}
	
	// Map View
	mapView = [[MapView alloc] initWithFrame:CGRectMake(kWebMapX,
														kWebMapY,
														kWebMapWidth,
														kWebMapHeight)];
	mapView.delegate = self;
	mapView.hidden = YES;
	mapView.userInteractionEnabled = NO;
	[self.view addSubview:mapView];
	[self.view sendSubviewToBack:mapView];
	
	// Start Initialization Timer
	[NSTimer scheduledTimerWithTimeInterval:kStatupCheckInterval
									 target:self
								   selector:@selector(checkInitialization:)
								   userInfo:nil
									repeats:YES];
	
	// Create Confirm View
	confirmView = [[ConfirmView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[confirmView.backButton setTarget:self];
	[confirmView.backButton setAction:@selector(cancelSend)];
	[confirmView.sendButton setTarget:self];
	[confirmView.sendButton setAction:@selector(sendEmail)];
	confirmView.alpha = 0.0;
}

- (void)checkInitialization:(NSTimer *)timer
{
	DLog(@"Check");

	if ([mapView isLoading])
	{
		DLog(@"MapView loading");
		return;
	}
	if (!validLoc)
	{
		DLog(@"No valid location")
		return;
	}
	
	[timer invalidate];
	[locationManager stopUpdatingLocation];

	[mapView initMapWithCenter:gpsLocation.coordinate];

	[display updateMessage:NSLocalizedString(@"StatusDragDrop", @"")];
	[display stop];
	sendButton.enabled = YES;
	mapView.hidden = NO;
	mapView.userInteractionEnabled = YES;
}

- (void)updateMapType
{
	if (mapView)
	{
		[mapView updateMapType];
	}
}

- (void)configure
{
	ConfigController *cc = [[ConfigController alloc] initWithMapController:self];	
	[self.navigationController pushViewController:cc animated:YES];
	[cc release];
}

- (void)confirmSend
{	
	mapView.userInteractionEnabled = NO;
	confirmCord = [mapView panToCenter];
	confirmZoomLevel = [mapView getZoomLevel];
	
	confirmView.alpha = 0.0;
	[[[UIApplication sharedApplication] keyWindow] addSubview:confirmView];
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kConfirmTransitionTime];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	confirmView.alpha = 1.0;
	
	[UIView commitAnimations];	
}

- (void)cancelSend
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kConfirmTransitionTime];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	confirmView.alpha = 0.0;

	[UIView commitAnimations];
	
	mapView.userInteractionEnabled = YES;
}

- (void)sendEmail
{
	NSString *reserved = @":/?#[]@!$&'()*+,;=";
	
	// Email Subject
	NSString *subject = [NSString stringWithFormat:[registry subjectString]];
	CFStringRef subjectStringRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																		   (CFStringRef)subject,
																		   NULL,
																		   (CFStringRef)reserved,
																		   kCFStringEncodingUTF8);
	NSString *subjectEncoded = NSMakeCollectable(subjectStringRef);
	
	// Email Body
	NSString *body = [NSString stringWithFormat:
					  @"%@\n\n"
					  "http://maps.google.com/maps?q=%f,%f"
					  "&t=%@"
					  "&z=%d",
					  [registry bodyString],
					  confirmCord.latitude,
					  confirmCord.longitude,
					  [registry mapUrlCode],
					  confirmZoomLevel];
	CFStringRef bodyStringRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																		(CFStringRef)body,
																		NULL,
																		(CFStringRef)reserved,
																		kCFStringEncodingUTF8);
    NSString *bodyEncoded = NSMakeCollectable(bodyStringRef);
	
	NSString *url = [NSString stringWithFormat:@"mailto:?subject=%@&body=%@", subjectEncoded, bodyEncoded];	
	CFRelease(subjectStringRef);
	CFRelease(bodyStringRef);
	
	DLog(@"url [%@]", url);

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{	
	if (signbit(newLocation.horizontalAccuracy))
	{		
		// Negative accuracy means an invalid or unavailable measurement
		ALog(@"MapController:locationManager Bad Location");
				
		return;
	}
	
	DLog(@"Coordinate[(%f,%f)]", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
		
	validLoc = YES;
	self.gpsLocation = newLocation;	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	ALog(@"MapController:locationManager:didFailWithError");
}

@end
