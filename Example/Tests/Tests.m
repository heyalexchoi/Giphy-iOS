//
//  AXCGiphyTests.m
//  AXCGiphyTests
//
//  Created by Alex Choi on 08/19/2014.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//
#import <AXCGiphy/AXCGiphy.h>

SpecBegin(InitialSpecs)

describe(@"AXCGiphy", ^{
    [AXCGiphy setGiphyAPIKey:kGiphyPublicAPIKey];
    setAsyncSpecTimeout(2);
    
    it(@"should get search results", ^AsyncBlock {
        [AXCGiphy searchGiphyWithTerm:@"cows" limit:10 offset:0 completion:^(NSArray *results, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                expect(results.count).to.equal(10);
                done();
            }];
        }];
    });
    it(@"search results should produce gifs with all these properties", ^AsyncBlock{
        [AXCGiphy searchGiphyWithTerm:@"cows" limit:10 offset:10 completion:^(NSArray *results, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    AXCGiphy * gif = obj;
                    expect(gif.gifID.length).to.beGreaterThan(0);
                    expect(gif.type.length).to.beGreaterThan(0);
                    expect(@"string").to.contain(@"string");
                    expect([[NSURL URLWithString:@"http://www.google.com"] absoluteString]).to.contain(@"http://");
                    expect(gif.url.absoluteString).to.contain(@"http://");
                    expect(gif.bitlyURL.absoluteString).to.contain(@"http://");
                    expect(gif.bitlyGIFURL.absoluteString).to.contain(@"http://");
                    expect(gif.embedURL.absoluteString).to.contain(@"http://");
                    // expect(gif.username.length).to.beGreaterThan(0);
                    expect(gif.source.absoluteString).to.contain(@"http://");
                    expect(gif.rating.length).to.beGreaterThan(0);
                    // expect(gif.trendingDateTime).toNot.beNil();
                    
                    expect(gif.fixedHeightImage).toNot.beNil;
                    expect(gif.fixedHeightImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.fixedHeightImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedHeightStillImage).toNot.beNil;
                    expect(gif.fixedHeightStillImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightStillImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightStillImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedHeightDownsampledImage).toNot.beNil;
                    expect(gif.fixedHeightDownsampledImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightDownsampledImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightDownsampledImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthImage).toNot.beNil;
                    expect(gif.fixedWidthImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.fixedWidthImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthStillImage).toNot.beNil;
                    expect(gif.fixedWidthStillImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthStillImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthStillImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthDownsampledImage).toNot.beNil;
                    expect(gif.fixedWidthDownsampledImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthDownsampledImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthDownsampledImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.originalImage).toNot.beNil;
                    expect(gif.originalImage.width).to.beGreaterThan(0);
                    expect(gif.originalImage.height).to.beGreaterThan(0);
                    expect(gif.originalImage.size).to.beGreaterThan(0);
                    expect(gif.originalImage.frames).to.beGreaterThan(0);
                    expect(gif.originalImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.originalImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.originalStillImage).toNot.beNil;
                    expect(gif.originalStillImage.width).to.beGreaterThan(0);
                    expect(gif.originalStillImage.height).to.beGreaterThan(0);
                    expect(gif.originalStillImage.url.absoluteString).to.contain(@"http://");
                }];
                done();
            }];
        }];
    });
    
    it(@"should get trending results", ^AsyncBlock {
        [AXCGiphy trendingGIFsWithlimit:10 offset:0 completion:^(NSArray *results, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                expect(results.count).to.equal(10);
                done();
            }];
        }];
    });
    it(@"trending results should produce gifs with all these properties", ^AsyncBlock{
        [AXCGiphy trendingGIFsWithlimit:10 offset:0 completion:^(NSArray *results, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    AXCGiphy * gif = obj;
                    expect(gif.gifID.length).to.beGreaterThan(0);
                    expect(gif.type.length).to.beGreaterThan(0);
                    expect(@"string").to.contain(@"string");
                    expect([[NSURL URLWithString:@"http://www.google.com"] absoluteString]).to.contain(@"http://");
                    expect(gif.url.absoluteString).to.contain(@"http://");
                    expect(gif.bitlyURL.absoluteString).to.contain(@"http://");
                    expect(gif.bitlyGIFURL.absoluteString).to.contain(@"http://");
                    expect(gif.embedURL.absoluteString).to.contain(@"http://");
                    // expect(gif.username.length).to.beGreaterThan(0);
                    //expect(gif.source.absoluteString).to.contain(@"http://");
                   // expect(gif.rating.length).to.beGreaterThan(0);
                    // expect(gif.trendingDateTime).toNot.beNil();
                    
                    expect(gif.fixedHeightImage).toNot.beNil;
                    expect(gif.fixedHeightImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.fixedHeightImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedHeightStillImage).toNot.beNil;
                    expect(gif.fixedHeightStillImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightStillImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightStillImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedHeightDownsampledImage).toNot.beNil;
                    expect(gif.fixedHeightDownsampledImage.width).to.beGreaterThan(0);
                    expect(gif.fixedHeightDownsampledImage.height).to.beGreaterThan(0);
                    expect(gif.fixedHeightDownsampledImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthImage).toNot.beNil;
                    expect(gif.fixedWidthImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.fixedWidthImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthStillImage).toNot.beNil;
                    expect(gif.fixedWidthStillImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthStillImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthStillImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.fixedWidthDownsampledImage).toNot.beNil;
                    expect(gif.fixedWidthDownsampledImage.width).to.beGreaterThan(0);
                    expect(gif.fixedWidthDownsampledImage.height).to.beGreaterThan(0);
                    expect(gif.fixedWidthDownsampledImage.url.absoluteString).to.contain(@"http://");
                    
                    expect(gif.originalImage).toNot.beNil;
                    expect(gif.originalImage.width).to.beGreaterThan(0);
                    expect(gif.originalImage.height).to.beGreaterThan(0);
                    expect(gif.originalImage.size).to.beGreaterThan(0);
                    expect(gif.originalImage.frames).to.beGreaterThan(0);
                    expect(gif.originalImage.url.absoluteString).to.contain(@"http://");
                    expect(gif.originalImage.mp4.absoluteString).to.contain(@"http://");
                    
                    expect(gif.originalStillImage).toNot.beNil;
                    expect(gif.originalStillImage.width).to.beGreaterThan(0);
                    expect(gif.originalStillImage.height).to.beGreaterThan(0);
                    expect(gif.originalStillImage.url.absoluteString).to.contain(@"http://");
                }];
                done();
            }];
        }];
    });
    
    
});

describe(@"these will pass", ^{
    
   
});

SpecEnd
