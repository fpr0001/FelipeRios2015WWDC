//
//  FPRImageView.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRImageView.h"

@implementation FPRImageView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
