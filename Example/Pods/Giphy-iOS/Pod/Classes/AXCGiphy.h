//
//  AXCGiphy.h
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXCGiphyImageDownsampled.h"
#import "AXCGiphyImageFixed.h"
#import "AXCGiphyImageOriginal.h"
/** public api key. you should get your own: https://github.com/giphy/GiphyAPI#access-and-api-keys */
extern NSString * const kGiphyPublicAPIKey;
/** Representation of Giphy's animated GIF and its metadata */
@interface AXCGiphy : NSObject
/** Giphy ID for this GIF */
@property (readonly, strong, nonatomic) NSString * gifID;
@property (readonly, strong, nonatomic) NSString * type;
/** URL to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * url;
/** Shortened link to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * bitlyURL;
/** Shortened link to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * bitlyGIFURL;
@property (readonly, strong, nonatomic) NSURL * embedURL;
@property (readonly, strong, nonatomic) NSString * username;
@property (readonly, strong, nonatomic) NSURL * source;
@property (readonly, strong, nonatomic) NSString * rating;
@property (readonly, strong, nonatomic) NSDate * trendingDateTime;
/** Modified version of the GIF with fixed height of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageFixed * fixedHeightImage;
/** Still image of the GIF with fixed height of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightStillImage;
/** Smaller, lower quality version of the GIF with fixed height of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedHeightDownsampledImage;
/** Modified version of the GIF with fixed width of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageFixed * fixedWidthImage;
/** Still image of the GIF with fixed width of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthStillImage;
/** Smaller, lower qualitiy version of the GIF with fixed width of 200 */
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * fixedWidthDownsampledImage;
/** Original GIF */
@property (readonly, strong, nonatomic) AXCGiphyImageOriginal * originalImage;
/** Still image of the original GIF*/
@property (readonly, strong, nonatomic) AXCGiphyImageDownsampled * originalStillImage;


/** Set your Giphy API Key. You must set this before making any requests. You may use kGiphyPublicAPIKey for development
 https://github.com/giphy/GiphyAPI#access-and-api-keys */
+ (void) setGiphyAPIKey:(NSString *) APIkey;
/** Get your currently set Giphy API Key */
+ (NSString *) giphyAPIKey;
/** NSURLRequest to search Giphy with term. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. */
+ (NSURLRequest *) giphySearchRequestForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset;
/** NSURLRequest to get trending GIFs. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. */
+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset;
/** NSURLRequest to fetch GIF with ID .*/
+ (NSURLRequest *) giphyRequestForGIFWithID:(NSString *) ID;
/** NSURLRequest to fetch GIFs with IDs .*/
+ (NSURLRequest *) giphyRequestForGIFsWithIDs:(NSArray *) IDs;
/** NSURLRequest to translate term into a GIF.*/
+ (NSURLRequest *) giphyTranslationRequestForTerm:(NSString *) term;
/** Search Giphy with term. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. Asynchronously returns either array of AXCGiphy objects or an error. */
+ (NSURLSessionDataTask *) searchGiphyWithTerm:(NSString *) searchTerm limit:(NSUInteger) limit offset:(NSUInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block;
/** Get currently trending GIFs. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. Asynchronously returns either array of AXCGiphy objects or an error. */
+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block;
/** Fetch GIF with ID . Asynchronously returns either AXCGiphy object or an error.*/
+ (NSURLSessionDataTask *) gifForID:(NSString *) ID completion:(void (^) (AXCGiphy * result, NSError * error)) block;
/** Fetch multiple GIFs by ID. Asynchronously returns either array of AXCGiphy objects or an error.*/
+ (NSURLSessionDataTask *) gifsForIDs:(NSArray *) IDs completion:(void (^) (NSArray * results, NSError * error)) block;
/** Use Giphy's translation 'special sauce' to translate your term into a GIF. Asynchronously returns either AXCGiphy object or an error. */
+ (NSURLSessionDataTask *) giphyTranslationForTerm:(NSString *) term completion:(void (^) (AXCGiphy * result, NSError * error)) block;

@end
