//
//  FPRViewScrollPaged.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRViewScrollPaged.h"

@implementation FPRViewScrollPaged

- (instancetype)initWithFrame:(CGRect)frame andContent:(FPRContent*)content
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FPRXibScrollPaged" owner:self options:nil] objectAtIndex:0];
        self.frame=frame;
        [self configureViewWithContent:content];
        [self updateConstraints];
    }
    return self;
}


-(void)configureViewWithContent:(FPRContent *)content{
    self.labelTopic.text = content.stringTopic;
    self.labelSubtopic.text = content.stringSubtopic;
    self.labelDateRange.text = [FPRUtils getStringDateRangeWithDateBegin:content.dateBegin andDateEnd:content.dateEnd];
    
    self.labelDescription.text=content.stringDescription;
    [self.labelDescription setAdjustsFontSizeToFitWidth:YES];
    
    if ([content.stringSubtopic isEqualToString:@"Mercurial"]) {
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]};
        self.buttonWebsite.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.buttonWebsite.titleLabel.text attributes:underlineAttribute];
        
        [self.buttonVideo.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.buttonVideo.layer setBorderWidth:.5];
        [self.buttonVideo.layer setCornerRadius:8.0];
    }
    else{
        [self.buttonVideo removeFromSuperview];
        [self.buttonWebsite removeFromSuperview];
    }
}


@end
