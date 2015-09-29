//
//  ViewController.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "ViewController.h"
#import "VenueTableViewCell.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface ViewController ()

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) NSArray *datasource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    
    [self _configureTableView];
    [self _createActivityIndicator];
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

#pragma mark - UITableViewDataSource

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VenueTableViewCell reuseIdentifier]
                                                               forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Private Functions

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)_configureTableView
{
    [self.tableView registerNib:[VenueTableViewCell nib] forCellReuseIdentifier:[VenueTableViewCell reuseIdentifier]];
    [self.tableView setRowHeight:80.0f];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)_createActivityIndicator
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.activityIndicatorView startAnimating];
}

@end
