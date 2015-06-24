//
//  UIView+FPRView.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 15/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "UIView+FPRView.h"

@implementation UIView (FPRView)

- (void)addTopBorderWithColor:(UIColor *)color
                     andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0,
                              0,
                              self.frame.size.width,
                              borderWidth);
    [self.layer addSublayer:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color
                        andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0,
                              self.frame.size.height - borderWidth,
                              self.frame.size.width,
                              borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color
                      andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0,
                              0,
                              borderWidth,
                              self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addRightBorderWithColor:(UIColor *)color
                       andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width - borderWidth,
                              0,
                              borderWidth,
                              self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addRoundedBorderWithSize:(CGFloat)borderSize
                           color:(UIColor *)borderColor
                       andRadius:(CGFloat)cornerRadius {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderSize;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}
@end
