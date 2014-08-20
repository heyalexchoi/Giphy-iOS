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
    setAsyncSpecTimeout(3);
  
    it(@"should get search results", ^AsyncBlock {
        [AXCGiphy searchGiphyWithTerm:@"cows" limit:10 offset:0 completion:^(NSArray *results, NSError *error) {
            expect(results.count).to.equal(13);
            expect(results.count).to.equal(10);
            expect(@"this").to.equal(@"that");
            done();
        }];
    });
});
describe(@"these will fail", ^{

    it(@"can do maths", ^{
        expect(1).to.equal(1);
    });

    it(@"can read", ^{
        expect(@"number").to.equal(@"number");
    });
    
    it(@"will wait and fail", ^AsyncBlock {
        expect(10).to.equal(10);
        done();
    });
    
});
describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
