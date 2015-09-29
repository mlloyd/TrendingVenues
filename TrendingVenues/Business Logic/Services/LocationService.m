//
//  LocationService.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "LocationService.h"
#import "Location.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface LocationService () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation LocationService

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (instancetype)init
{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000;
        self.locationManager.delegate = self;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchCurrentLocationWithCompletionBlock:(LocationServiceCompletionHandler)completionHandler
                                   errorHandler:(LocationServiceErrorHandler)errorHandler
{
    id<Location> currentLocation = [[Location alloc] initWithLongitude:@(40.7)
                                                              latitude:@(-74)];
    completionHandler(currentLocation);
}

@end
