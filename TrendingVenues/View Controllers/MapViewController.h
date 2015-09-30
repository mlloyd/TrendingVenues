//
//  MapViewController.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 30/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@class APIVenue;
@interface MapViewController : UIViewController

- (instancetype)initWithVenue:(APIVenue *)venue;

@end
