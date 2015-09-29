//
//  FourSquareRemoteService.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@protocol Location;
@protocol FourSquareRemoteService <NSObject>

- (void)fetchVenueNearLocation:(id<Location>)location
             completionHandler:(void (^)(NSArray *))completionHandler
                  errorHandler:(void (^)(NSError *))errorHandler;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface FourSquareRemoteService : NSObject<FourSquareRemoteService>

@end
