//
//  FourSquareService.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FourSquareServiceCompletionHandler)(NSArray *venues);
typedef void (^FourSquareServiceErrorHandler)(NSError *error);

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@protocol Location;
@protocol FourSquareService <NSObject>

- (void)fetchTrendingVenuesAtCurrentLocationWithCompletionHandler:(FourSquareServiceCompletionHandler)completionHandler
                                                     errorHandler:(FourSquareServiceErrorHandler)errorHandler;

- (void)fetchTrendingVenuesAtLocation:(id<Location>)location
                    completionHandler:(FourSquareServiceCompletionHandler)completionHandler
                         errorHandler:(FourSquareServiceErrorHandler)errorHandler;

- (void)fetchTrendingVenuesAtLocationNamed:(NSString *)location
                         completionHandler:(FourSquareServiceCompletionHandler)completionHandler
                              errorHandler:(FourSquareServiceErrorHandler)errorHandler;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@protocol FourSquareRemoteService;
@protocol LocationService;
@interface FourSquareService : NSObject<FourSquareService>

- (instancetype)initWithRemoteService:(id<FourSquareRemoteService>)remoteService
                      locationService:(id<LocationService>) locationService;

@end
