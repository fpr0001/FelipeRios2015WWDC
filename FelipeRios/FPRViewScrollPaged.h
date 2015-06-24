//
//  FPRViewScrollPaged.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPRContent.h"
#import "FPRUtils.h"

@interface FPRViewScrollPaged : UIView
@property (weak, nonatomic) IBOutlet UILabel *labelTopic;
@property (weak, nonatomic) IBOutlet UILabel *labelSubtopic;
@property (weak, nonatomic) IBOutlet UILabel *labelDateRange;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIButton *buttonVideo;
@property (weak, nonatomic) IBOutlet UIButton *buttonWebsite;
- (instancetype)initWithFrame:(CGRect)frame andContent:(FPRContent*)content;
@end
