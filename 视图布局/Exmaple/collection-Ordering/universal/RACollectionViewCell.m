//
//  RACollectionViewCell.m
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/27/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RACollectionViewCell.h"

@implementation RACollectionViewCell

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = .7f;
    }else {
        self.alpha = 1.f;
    }
}

@end
