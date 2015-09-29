//
//  AppAssembly.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import "AppAssembly.h"

#import "FourSquareRemoteService.h"
#import "FourSquareService.h"
#import "LocationService.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface AppAssembly ()

@property (nonatomic) id<FourSquareRemoteService> fourSquareRemoteService;
@property (nonatomic) id<FourSquareService      > fourSquareService;
@property (nonatomic) id<LocationService        > locationService;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation AppAssembly

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (instancetype)init
{
    if (self = [super init]) {
        self.fourSquareRemoteService = [[FourSquareRemoteService alloc] init];
        self.locationService         = [[LocationService alloc] init];
        
        self.fourSquareService       = [[FourSquareService alloc] initWithRemoteService:self.fourSquareRemoteService
                                                                        locationService:self.locationService];        
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (id<FourSquareService>)fetchFourSquareService
{
    return self.fourSquareService;
}

@end
