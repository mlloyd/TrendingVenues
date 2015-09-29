//
//  ViewController.h
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourSquareService.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface ViewController : UIViewController

@property (nonatomic, weak) id<FourSquareService> fourSquareService;

@end

