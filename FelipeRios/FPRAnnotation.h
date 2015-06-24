//
//  FPRAnnotation.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 24/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "UIView+FPRView.h"
#import "FPRContent.h"

#define IMAGE_VIEW_WIDTH 90.0

@interface FPRAnnotation : NSObject<MKAnnotation>
@property(nonatomic)UIImageView* imageView;
@property(nonatomic)FPRContent* content;
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
