//
//  AXCGiphyImageFixed.m
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCGiphyImageFixed.h"
@interface AXCGiphyImageFixed ()
@property (strong, readwrite, nonatomic) NSURL * url;
@property (readwrite, nonatomic) CGFloat width;
@property (readwrite, nonatomic) CGFloat height;
@property (readwrite, nonatomic, strong) NSURL * mp4;
@end
@implementation AXCGiphyImageFixed
@synthesize url = _url, width = _width, height = _height;
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (!self) {
        return nil;
    }
    
    self.mp4 = [NSURL URLWithString:dictionary[@"mp4"]];
    
    return self;
}
@end
