//
//  FourSquareService.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import "FourSquareService.h"
#import "FourSquareRemoteService.h"
#import "LocationService.h"
#import "Location.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface FourSquareService ()

@property (nonatomic) id<FourSquareRemoteService> remoteService;
@property (nonatomic) id<LocationService        > locationService;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation FourSquareService

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (instancetype)initWithRemoteService:(id<FourSquareRemoteService>)remoteService
                      locationService:(id<LocationService>) locationService
{
    if (self = [super init]) {
        self.remoteService = remoteService;
        self.locationService = locationService;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchTrendingVenuesAtCurrentLocationWithCompletionHandler:(FourSquareServiceCompletionHandler)completionHandler
                                                     errorHandler:(FourSquareServiceErrorHandler)errorHandler
{
    __weak typeof(self) weakSelf = self;
    [self.locationService fetchCurrentLocationWithCompletionBlock:^(id<Location> location) {
            [weakSelf fetchTrendingVenuesAtLocation:location
                                  completionHandler:completionHandler
                                       errorHandler:errorHandler];
    }
                                                     errorHandler:^(NSError *error) {
                                                         errorHandler(error);
    }];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchTrendingVenuesAtLocation:(id<Location>)location
                    completionHandler:(FourSquareServiceCompletionHandler)completionHandler
                         errorHandler:(FourSquareServiceErrorHandler)errorHandler
{
    if(location == nil) {
        // TODO: Handler error
        errorHandler(nil);
    }
    
    [self.remoteService fetchVenueNearLocation:location
                             completionHandler:completionHandler
                                  errorHandler:errorHandler];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchTrendingVenuesAtLocationNamed:(NSString *)location
                         completionHandler:(FourSquareServiceCompletionHandler)completionHandler
                              errorHandler:(FourSquareServiceErrorHandler)errorHandler
{
    [self.remoteService fetchVenueNearLocationNamed:location
                                  completionHandler:completionHandler
                                       errorHandler:errorHandler];
}

@end
