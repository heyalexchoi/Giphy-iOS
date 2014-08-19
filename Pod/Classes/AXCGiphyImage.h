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
@property (readonly, strong, nonatomic) NSURL * url;
@property (readonly, nonatomic) CGFloat width;
@property (readonly, nonatomic) CGFloat height;
- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
