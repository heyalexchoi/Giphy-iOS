//
//  AXCCollectionViewCell.m
//  AXCGiphy
//
//  Created by alexchoi on 8/19/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCCollectionViewCell.h"

@implementation AXCCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
