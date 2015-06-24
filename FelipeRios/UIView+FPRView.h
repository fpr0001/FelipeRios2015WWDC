//
//  UIView+FPRView.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 15/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FPRView)
- (void)addBottomBorderWithColor:(UIColor *)color
                        andWidth:(CGFloat)borderWidth;
- (void)addLeftBorderWithColor:(UIColor *)color
                      andWidth:(CGFloat)borderWidth;
- (void)addRightBorderWithColor:(UIColor *)color
                       andWidth:(CGFloat)borderWidth;
- (void)addTopBorderWithColor:(UIColor *)color
                     andWidth:(CGFloat)borderWidth;
- (void)addRoundedBorderWithSize:(CGFloat)borderSize
                           color:(UIColor *)borderColor
                       andRadius:(CGFloat)cornerRadius;
@end
