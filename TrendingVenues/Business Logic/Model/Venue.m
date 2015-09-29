//
//  Venue.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

#import "Venue.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation Venue

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier": @"id",
             @"name": @"name",
             @"contact": [NSNull null],
             @"location": [NSNull null],
             @"categories": [NSNull null],
             @"verified": @"verified",
             @"stats": [NSNull null],
             @"url": @"url",
             @"specials": [NSNull null],
             @"hereNow": [NSNull null],
             @"referralId": [NSNull null],
             };
    
}

@end
