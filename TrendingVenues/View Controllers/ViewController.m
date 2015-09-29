//
//  ViewController.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "ViewController.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface ViewController ()

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation ViewController

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Venues", @"");
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.activityIndicatorView startAnimating];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [self.fourSquareService fetchTrendingVenuesAtCurrentLocationWithCompletionHandler:^(NSArray *venues) {
        [weakSelf.activityIndicatorView stopAnimating];
    }
                                                                         errorHandler:^(NSError *error) {
                                                                             [weakSelf.activityIndicatorView stopAnimating];
                                                                         }];
}

@end
