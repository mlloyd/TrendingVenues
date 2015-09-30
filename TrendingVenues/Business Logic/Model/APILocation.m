//
//  APILocation.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import "APILocation.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation APILocation

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"address":    @"address",
             @"latitude":   @"lat",
             @"longitude":  @"lng",
             @"postalCode": @"postalCode",
             @"cc":         @"cc",
             @"city":       @"city",
             @"state":      @"state",
             @"country":    @"country"
    };
}

@end
