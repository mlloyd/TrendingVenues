//
//  MapViewController.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 30/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <MapKit/MapKit.h>

#import "MapViewController.h"

#import "APIVenue.h"
#import "APILocation.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface MapViewController ()

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) APIVenue  *venue;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation MapViewController

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (instancetype)initWithVenue:(APIVenue *)venue
{
    if(self = [super init]) {
        self.venue = venue;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.venue.name;
    
    self.mapView = [[MKMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    ////////////////////////////////////////////////////////////////////////////////
    // Apply lat/long to map
    ////////////////////////////////////////////////////////////////////////////////
    CGFloat latitude  = [self.venue.location.latitude floatValue];
    CGFloat longitude = [self.venue.location.longitude floatValue];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002401f, 0.003433f);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    
    [self.mapView setRegion:region animated:YES];
    
    ////////////////////////////////////////////////////////////////////////////////
    //
    ////////////////////////////////////////////////////////////////////////////////
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    [self.mapView addAnnotation:point];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
