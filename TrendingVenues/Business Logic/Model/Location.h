//
//  Location.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@protocol Location <NSObject>

@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSString *searchName;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface Location : NSObject<Location>

@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSString *searchName;

- (instancetype)initWithLongitude:(NSNumber *)longitude
                         latitude:(NSNumber *)latitude;

@end
