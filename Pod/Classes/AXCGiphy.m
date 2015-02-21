//
//  AXCGiphy.m
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//
//https://github.com/giphy/GiphyAPI
#import "AXCGiphy.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import "AXCGiphyImage.h"
#import "AXCGiphyImageDownsampled.h"
#import "AXCGiphyImageFixed.h"
#import "AXCGiphyImageOriginal.h"

NSString * const kGiphyPublicAPIKey = @"dc6zaTOxFJmzC";

@interface AXCGiphy ()
@property (readwrite, strong, nonatomic) NSString * gifID;
@property (readwrite, strong, nonatomic) NSString * type;
@property (readwrite, strong, nonatomic) NSURL * url;
@property (readwrite, strong, nonatomic) NSURL * bitlyURL;
@property (readwrite, strong, nonatomic) NSURL * bitlyGIFURL;
@property (readwrite, strong, nonatomic) NSURL * embedURL;
@property (readwrite, strong, nonatomic) NSString * username;
@property (readwrite, strong, nonatomic) NSURL * source;
@property (readwrite, strong, nonatomic) NSString * rating;
@property (readwrite, strong, nonatomic) NSDate * trendingDateTime;
@property (readwrite, strong, nonatomic) AXCGiphyImageFixed * fixedHeightImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightStillImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightDownsampledImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageFixed * fixedWidthImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthStillImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthDownsampledImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageOriginal * originalImage;
@property (readwrite, strong, nonatomic) AXCGiphyImageDownsampled * originalStillImage;
@end

@implementation AXCGiphy
static NSString * kGiphyAPIKey;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.gifID = dictionary[@"id"];
    self.type = dictionary[@"type"];
    self.url = [NSURL URLWithString:dictionary[@"url"]];
    self.bitlyURL = [NSURL URLWithString:dictionary[@"bitly_url"]];
    self.bitlyGIFURL = [NSURL URLWithString:dictionary[@"bitly_gif_url"]];
    self.embedURL = [NSURL URLWithString:dictionary[@"embed_url"]];
    self.username = dictionary[@"username"];
    self.source = [NSURL URLWithString:dictionary[@"source"]];
    self.rating = dictionary[@"rating"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.trendingDateTime = [dateFormatter dateFromString:dictionary[@"trending_datetime"]];
    
    NSDictionary * images = dictionary[@"images"];
    self.fixedHeightImage = [[AXCGiphyImageFixed alloc] initWithDictionary:images[@"fixed_height"]];
    self.fixedHeightStillImage = [[AXCGiphyImageDownsampled alloc] initWithDictionary:images[@"fixed_height_still"]];
    self.fixedHeightDownsampledImage = [[AXCGiphyImageDownsampled alloc] initWithDictionary:images[@"fixed_height_downsampled"]];
    self.fixedWidthImage = [[AXCGiphyImageFixed alloc] initWithDictionary:images[@"fixed_width"]];
    self.fixedWidthStillImage = [[AXCGiphyImageDownsampled alloc] initWithDictionary:images[@"fixed_width_still"]];
    self.fixedWidthDownsampledImage = [[AXCGiphyImageDownsampled alloc] initWithDictionary:images[@"fixed_width_downsampled"]];
    self.originalImage = [[AXCGiphyImageOriginal alloc] initWithDictionary:images[@"original"]];
    self.originalStillImage = [[AXCGiphyImageDownsampled alloc] initWithDictionary:images[@"original_still"]];
    
    return self;
}
+ (void) setGiphyAPIKey:(NSString *) APIKey
{
    kGiphyAPIKey = APIKey;
}
+ (NSString *) giphyAPIKey
{
    return kGiphyAPIKey;
}

+ (NSArray *) AXCGiphyArrayFromDictArray:(NSArray *) array
{
    NSMutableArray * gifArray = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * dict = obj;
        AXCGiphy * gif = [[AXCGiphy alloc] initWithDictionary:dict];
        [gifArray addObject:gif];
    }];
    return gifArray;
}

+ (NSURLRequest *) giphySearchRequestForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset
{
    return [self requestForEndPoint:@"/search" params:@{@"limit": @(limit), @"offset": @(offset), @"q": term}];
}

+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset
{
    return [self requestForEndPoint:@"/trending" params:@{@"limit": @(limit), @"offset": @(offset)}];
}

+ (NSURLRequest *) giphyRequestForGIFWithID:(NSString *) ID
{
    return [self requestForEndPoint:[NSString stringWithFormat:@"/%@",ID] params:nil];
}
+ (NSURLRequest *) giphyRequestForGIFsWithIDs:(NSArray *) IDs
{
    return [self requestForEndPoint:@"" params:@{@"ids": [IDs componentsJoinedByString:@","]}];
}

+ (NSURLRequest *) giphyTranslationRequestForTerm:(NSString *) term
{
    return [self requestForEndPoint:@"/translate" params:@{@"limit": @(1), @"s": term}];
}
/** Response on this endpoint is inconsistent with the rest of the endpoints' responses*/
+ (NSURLRequest *) giphyRequestForRandomGIFWithTag:(NSString *) tag
{
    return [self requestForEndPoint:@"/random" params:@{@"tag": tag}];
}

+ (NSURLRequest *) requestForEndPoint:(NSString *) endpoint params:(NSDictionary *) params
{
    NSString * base = @"http://api.giphy.com/v1/gifs";
    NSString * withEndPoint = [NSString stringWithFormat:@"%@%@", base, endpoint];
    NSError * error;
    
    NSMutableDictionary * paramsWithAPIKey = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsWithAPIKey setObject:kGiphyAPIKey forKey:@"api_key"];
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:withEndPoint parameters:paramsWithAPIKey error:&error];
    return request;
}

+ (NSURLSessionDataTask *) searchGiphyWithTerm:(NSString *) searchTerm limit:(NSUInteger) limit offset:(NSUInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphySearchRequestForTerm:searchTerm limit:limit offset:offset];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                NSArray * gifArray = [AXCGiphy AXCGiphyArrayFromDictArray:results[@"data"]];
                block(gifArray, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyTrendingRequestWithLimit:limit offset:offset];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                NSArray * gifArray = [AXCGiphy AXCGiphyArrayFromDictArray:results[@"data"]];
                block(gifArray, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) giphyTranslationForTerm:(NSString *)term completion:(void (^)(AXCGiphy *, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyTranslationRequestForTerm:term];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                AXCGiphy * result = [[AXCGiphy alloc] initWithDictionary:results[@"data"]];
                block(result, nil);
            }
        }
    }];
    [task resume];
    return task;
}


+ (NSURLSessionDataTask *) gifForID:(NSString *)ID completion:(void (^)(AXCGiphy *, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyRequestForGIFWithID:ID];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                AXCGiphy * result = [[AXCGiphy alloc] initWithDictionary:results[@"data"]];
                block(result, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) gifsForIDs:(NSArray *)IDs completion:(void (^)(NSArray *, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyRequestForGIFsWithIDs:IDs];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                NSArray * gifs = [AXCGiphy AXCGiphyArrayFromDictArray:results[@"data"]];
                block(gifs, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSError *)customErrorFromResults:(NSDictionary *)results
{
    NSArray * resultsData = results[@"data"];
    if ([resultsData count] == 0) {
        return [[NSError alloc] initWithDomain:@"com.giphy.ios" code:-1 userInfo:@{@"error_message" : @"No results were found"}];
    }
    return nil;
}


@end
