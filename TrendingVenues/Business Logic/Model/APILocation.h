//
//  APILocation.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface APILocation : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *cc;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *country;

@end
