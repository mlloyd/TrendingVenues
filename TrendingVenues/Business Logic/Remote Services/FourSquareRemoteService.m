//
//  FourSquareRemoteService.m
//  TrendingVenues
//
//  Created by Martin Lloyd on 29/09/2015.
//  Copyright © 2015 mlloyd. All rights reserved.
//

#import <Mantle/MTLJSONAdapter.h>

#import "FourSquareRemoteService.h"
#import "Location.h"

#import "Venue.h"

NSString *const kFourSquareRemoteService_Endpoint     = @"https://api.foursquare.com/v2/venues/search";
NSString *const kFourSquareRemoteService_ClientId     = @"2UHTQ3034YVMH3WYQZSWRYNQHNUPKO2CNARKHUC3YL230BT5";
NSString *const kFourSquareRemoteService_ClientSecret = @"G4CPUIXFWMCRCG4GWUJWIDCOI1XGQWKDDAMNMFQHWQ2T040V";

NSString *const kUserProgramPreferencesKey_Duration = @"duration";
NSString *const kUserProgramPreferencesKey_Region   = @"region";
NSString *const kUserProgramPreferencesKey_StoryIds = @"storyIds";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface FourSquareRemoteService ()

@property (nonatomic) NSURLSession *session;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation FourSquareRemoteService

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (instancetype)init
{
    if (self = [super init]) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchVenueNearLocation:(id<Location>)location
             completionHandler:(void (^)(NSArray *))completionHandler
                  errorHandler:(void (^)(NSError *))errorHandler
{
    NSString *resource = [NSString stringWithFormat:@"%@?%@&%@&%@&%@",
                          kFourSquareRemoteService_Endpoint,
                          [NSString stringWithFormat:@"ll=%@,%@", location.longitude, location.latitude],
                          [NSString stringWithFormat:@"client_id=%@", kFourSquareRemoteService_ClientId],
                          [NSString stringWithFormat:@"client_secret=%@", kFourSquareRemoteService_ClientSecret],
                          [NSString stringWithFormat:@"v=%@", @"20150929"]];
    
    NSURL *serviceEndpoint = [NSURL URLWithString:resource];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceEndpoint
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0f];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     
                                                     if(((NSHTTPURLResponse *)response).statusCode != 200) {
                                                         NSError *responseError = [NSError errorWithDomain:@"com.trendingvalues.remoteservice.venue" code:-100 userInfo:@{}];
                                                        dispatch_sync(dispatch_get_main_queue(), ^(){ errorHandler(responseError); });
                                                     }
                                                     
                                                     NSError *responseProcessingError = nil;
                                                     NSDictionary *decodedResponseData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:0
                                                                                                                           error:&responseProcessingError];
//                                                     NSLog(@"%@", decodedResponseData);
                                                     
                                                     // Could build these out, into MTLModel objects.
                                                     NSArray *venuesResponseData = decodedResponseData[@"response"][@"venues"];
                                                     NSMutableArray *venues = [NSMutableArray array];
                                                     
                                                     NSError *parseError = nil;
                                                     for (NSDictionary *venueDict in venuesResponseData) {
                                                         Venue *decodedResponse = [MTLJSONAdapter modelOfClass:[Venue class]
                                                                                            fromJSONDictionary:venueDict
                                                                                                         error:&parseError];
                                                         [venues addObject:decodedResponse];
                                                     }                                                     
                                                     
                                                     dispatch_sync(dispatch_get_main_queue(), ^(){
                                                         completionHandler(venues);
                                                     });
    }];

    [task resume];
}

@end
