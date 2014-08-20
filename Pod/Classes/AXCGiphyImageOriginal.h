//
//  AXCGiphyImageOriginal.h
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCGiphyImage.h"

@interface AXCGiphyImageOriginal : AXCGiphyImage
/** Size of this GIF */
@property (readonly, nonatomic) NSUInteger size;
/** Number of frames in this GIF */
@property (readonly, nonatomic) NSUInteger frames;
/** URL for mp4 of this GIF */
@property (readonly, nonatomic, strong) NSURL * mp4;
@end
