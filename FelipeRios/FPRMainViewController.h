//
//  FPRMainViewController.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FPRView.h"
#import "FPRGradientView.h"
#import <MapKit/MapKit.h>
#import "FPRContent.h"
#import "FPRUtils.h"
#import "FPRViewScrollPaged.h"
#import "FPRAnnotation.h"
#import "FelipeRios-Swift.h"
#import "FPRData.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface FPRMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWWDC;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end
