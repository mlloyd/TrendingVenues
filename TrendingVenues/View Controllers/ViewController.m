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

#import "MapViewController.h"

#import "APIVenue.h"
#import "APILocation.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) NSArray *datasource;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *overlay;

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
    
    [self.searchBar becomeFirstResponder];
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
    
    APIVenue *venue = self.datasource[indexPath.row];
    cell.textLabel.text = venue.name;
    // TODO: Present data in a better way, could utilise custom cell more. Time permitting.
    return cell;
}

#pragma mark - UITableViewDataSource

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    APIVenue *venue = self.datasource[indexPath.row];
    
    MapViewController *mapViewController = [[MapViewController alloc] initWithVenue:venue];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma mark - UISearchBarDelegate

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    __weak typeof(self) weakSelf = self;
    
    [self.activityIndicatorView startAnimating];
    [searchBar resignFirstResponder];
    // TODO: Validate search bar text
    self.view.userInteractionEnabled = NO;
    
    dispatch_block_t fetchCompletionHandler = ^(){
        weakSelf.view.userInteractionEnabled = YES;
        [weakSelf.activityIndicatorView stopAnimating];
    };
    
    dispatch_block_t completionHandler = ^(){
        [self.fourSquareService fetchTrendingVenuesAtLocationNamed:searchBar.text
                                                 completionHandler:^(NSArray *venues) {
                                                     weakSelf.datasource = venues;
                                                     [weakSelf.tableView reloadData];
                                                     
                                                     [weakSelf animateOverlayToAlpha:0.0 completionHandler:fetchCompletionHandler];
                                                 }
                                                      errorHandler:^(NSError *error) {
                                                          [weakSelf animateOverlayToAlpha:0.0 completionHandler:fetchCompletionHandler];
                                                      }];
    };
    
    [self animateOverlayToAlpha:0.6 completionHandler:completionHandler];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)animateOverlayToAlpha:(CGFloat)alpha completionHandler:(dispatch_block_t)completionHandler
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                         weakSelf.overlay.alpha = alpha;
                     }
                     completion:^(BOOL finished) {
                         completionHandler();
                     }];
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
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

@end
