//
//  APIVenue.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

#import "APILocation.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface APIVenue : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *categories;
@property (nonatomic, copy) NSString *verified;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) APILocation *location;

@end
