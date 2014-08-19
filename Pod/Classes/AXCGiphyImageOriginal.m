//
//  AXCGiphyImageOriginal.m
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCGiphyImageOriginal.h"
@interface AXCGiphyImageOriginal ()
@property (strong, readwrite, nonatomic) NSURL * url;
@property (readwrite, nonatomic) CGFloat width;
@property (readwrite, nonatomic) CGFloat height;
@property (readwrite, nonatomic) NSUInteger size;
@property (readwrite, nonatomic) NSUInteger frames;
@property (readwrite, nonatomic, strong) NSURL * mp4;
@end
@implementation AXCGiphyImageOriginal
@synthesize url = _url, width = _width, height = _height;
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (!self) {
        return nil;
    }
    
    self.size = [dictionary[@"size"] integerValue];
    self.frames = [dictionary[@"frames"] integerValue];
    self.mp4 = [NSURL URLWithString:dictionary[@"mp4"]];
    
    return self;
}
@end
