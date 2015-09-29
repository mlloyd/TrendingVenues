//
//  LocationService.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

typedef void (^LocationServiceCompletionHandler)(id<Location> location);
typedef void (^LocationServiceErrorHandler)(NSError *error);

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@protocol LocationService <NSObject>

- (void)fetchCurrentLocationWithCompletionBlock:(LocationServiceCompletionHandler)completionHandler
                                   errorHandler:(LocationServiceErrorHandler)errorHandler;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface LocationService : NSObject<LocationService>

@end
