//
//  AXCGiphyImageOriginal.h
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCGiphyImage.h"

@interface AXCGiphyImageOriginal : AXCGiphyImage
@property (readonly, nonatomic) NSUInteger size;
@property (readonly, nonatomic) NSUInteger frames;
@property (readonly, nonatomic, strong) NSURL * mp4;
@end
