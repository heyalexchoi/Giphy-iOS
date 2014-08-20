//
//  AXCGiphyImage.h
//  AXCGiphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AXCGiphyImage : NSObject
/** URL for animated GIF*/
@property (readonly, strong, nonatomic) NSURL * url;
/** width for animated GIF*/
@property (readonly, nonatomic) CGFloat width;
/** height for animated GIF*/
@property (readonly, nonatomic) CGFloat height;
- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
