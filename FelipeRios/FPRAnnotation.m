//
//  FPRAnnotation.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 24/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRAnnotation.h"


@interface FPRAnnotation()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end
@implementation FPRAnnotation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

-(void)setContent:(FPRContent *)content{
    _content=content;
    [self imageView];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, IMAGE_VIEW_WIDTH, IMAGE_VIEW_WIDTH)];
        [_imageView setTag:98];
        [_imageView setImage:[UIImage imageNamed:self.content.stringImageName]];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView addRoundedBorderWithSize:3.0 color:[UIColor whiteColor] andRadius:IMAGE_VIEW_WIDTH/2.0];
        _imageView.tag = 10;

    }
    return _imageView;
}

@end
