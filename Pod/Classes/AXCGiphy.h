//
//  AXCGiphy.h
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
// public api key. you should get your own: https://github.com/giphy/GiphyAPI#access-and-api-keys
extern NSString * const kGiphyPublicAPIKey;

@class AXCGiphyImage;
@class AXCGiphyImageDownsampled;
@class AXCGiphyImageFixed;
@class AXCGiphyImageOriginal;

@interface AXCGiphy : NSObject
@property (readonly, strong, nonatomic) NSString * gifID;
@property (readonly, strong, nonatomic) NSString * type;
@property (readonly, strong, nonatomic) NSURL * url;
@property (readonly, strong, nonatomic) NSURL * bitlyURL;
@property (readonly, strong, nonatomic) NSURL * bitlyGIFURL;
@property (readonly, strong, nonatomic) NSURL * embedURL;
@property (readonly, strong, nonatomic) NSString * username;
@property (readonly, strong, nonatomic) NSURL * source;
@property (readonly, strong, nonatomic) NSString * rating;
@property (readonly, strong, nonatomic) NSDate * trendingDateTime;
@property (readonly, strong, nonatomic) AXCGiphyImageFixed * fixedHeightImage;
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightStillImage;
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightDownsampledImage;
@property (readonly, strong, nonatomic) AXCGiphyImageFixed * fixedWidthImage;
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthStillImage;
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthDownsampledImage;
@property (readonly, strong, nonatomic) AXCGiphyImageOriginal * originalImage;
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * originalStillImage;


// set your Giphy API Key
+ (void) setGiphyAPIKey:(NSString *) APIkey;
// get your Giphy API Key
+ (NSString *) giphyAPIKey;
+ (NSURLRequest *) giphySearchRequestForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset;
+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset;
+ (NSURLRequest *) giphyRequestForGIFWithID:(NSString *) ID;
+ (NSURLRequest *) giphyRequestForGIFsWithIDs:(NSArray *) IDs;
+ (NSURLRequest *) giphyTranslationRequestForTerm:(NSString *) term;
+ (NSURLRequest *) giphyRequestForRandomGIFWithTag:(NSString *) tag;
+ (NSURLRequest *) requestForEndPoint:(NSString *) endpoint params:(NSDictionary *) params;
// Search Giphy with search term. Result size can be limited with max 100 and default 25. Offset results defaults to 0.
+ (NSURLSessionDataTask *) searchGiphyWithTerm:(NSString *) searchTerm limit:(NSUInteger) limit offset:(NSUInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block;
// Get Giphy GIF with ID
+ (NSURLSessionDataTask *) gifForID:(NSString *) ID completion:(void (^) (AXCGiphy * result, NSError * error)) block;
// Get Giphy GIFs with IDs
+ (NSURLSessionDataTask *) gifsForIDs:(NSArray *) IDs completion:(void (^) (NSArray * results, NSError * error)) block;
+ (NSURLSessionDataTask *) giphyTranslationForTerm:(NSString *) term completion:(void (^) (AXCGiphy * result, NSError * error)) block;
+ (NSURLSessionDataTask *) randomGIFWithcompletion:(void (^) (AXCGiphy * result, NSError * error)) block;
+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit completion:(void (^) (NSArray * results, NSError * error)) block;
@end
