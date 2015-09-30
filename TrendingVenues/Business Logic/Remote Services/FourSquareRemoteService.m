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

#import "APIVenue.h"

NSString *const kFourSquareRemoteService_Endpoint     = @"https://api.foursquare.com/v2/venues/search";
NSString *const kFourSquareRemoteService_ClientId     = @"2UHTQ3034YVMH3WYQZSWRYNQHNUPKO2CNARKHUC3YL230BT5";
NSString *const kFourSquareRemoteService_ClientSecret = @"G4CPUIXFWMCRCG4GWUJWIDCOI1XGQWKDDAMNMFQHWQ2T040V";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface FourSquareRemoteService ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSDateFormatter *dateFormatter;

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
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyyMMDD"];
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
                          [NSString stringWithFormat:@"near=%@", @"London"],
                          [NSString stringWithFormat:@"client_id=%@", kFourSquareRemoteService_ClientId],
                          [NSString stringWithFormat:@"client_secret=%@", kFourSquareRemoteService_ClientSecret],
                          [NSString stringWithFormat:@"v=%@", [self.dateFormatter stringFromDate:[NSDate date]]]];
    
    [self buildRequestWithResource:resource completionHandler:completionHandler errorHandler:errorHandler];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)fetchVenueNearLocationNamed:(NSString *)location
                  completionHandler:(void (^)(NSArray *))completionHandler
                       errorHandler:(void (^)(NSError *))errorHandler
{
    NSString *resource = [NSString stringWithFormat:@"%@?%@&%@&%@&%@",
                          kFourSquareRemoteService_Endpoint,
                          [NSString stringWithFormat:@"near=%@", location],
                          [NSString stringWithFormat:@"client_id=%@", kFourSquareRemoteService_ClientId],
                          [NSString stringWithFormat:@"client_secret=%@", kFourSquareRemoteService_ClientSecret],
                          [NSString stringWithFormat:@"v=%@", [self.dateFormatter stringFromDate:[NSDate date]]]];
    
    [self buildRequestWithResource:resource completionHandler:completionHandler errorHandler:errorHandler];
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)buildRequestWithResource:(NSString *)resource
               completionHandler:(void (^)(NSArray *))completionHandler
                    errorHandler:(void (^)(NSError *))errorHandler
{
    NSString *encodedURL = [resource stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *serviceEndpoint = [NSURL URLWithString:encodedURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceEndpoint
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0f];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     
                                                     if(data == nil ||
                                                        error!=nil ||
                                                        ((NSHTTPURLResponse *)response).statusCode != 200) {
                                                         NSError *responseError = [NSError errorWithDomain:@"com.trendingvalues.remoteservice.venue" code:-100 userInfo:@{}];
                                                         dispatch_sync(dispatch_get_main_queue(), ^(){ errorHandler(responseError); });
                                                     }
                                                     
                                                     NSError *responseProcessingError = nil;
                                                     NSDictionary *decodedResponseData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:0
                                                                                                                           error:&responseProcessingError];
                                                     // Could build these out, into MTLModel objects.
                                                     NSArray *venuesResponseData = decodedResponseData[@"response"][@"venues"];
                                                     NSMutableArray *venues = [NSMutableArray array];
                                                     
                                                     NSError *parseError = nil;
                                                     for (NSDictionary *venueDict in venuesResponseData) {
                                                         APIVenue *decodedResponse = [MTLJSONAdapter modelOfClass:[APIVenue class]
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
