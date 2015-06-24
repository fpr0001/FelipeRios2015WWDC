//
//  FPRContent.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRContent.h"

@implementation FPRContent
- (instancetype)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        _stringTopic = dic[@"stringTopic"];
        _stringSubtopic = dic[@"stringSubtopic"];
        _stringImageName = dic[@"stringImageName"];
        _stringDescription = dic[@"stringDescription"];
        _dateBegin = dic[@"dateBegin"];
        _dateEnd = dic[@"dateEnd"];
        _longitude = [(NSNumber*)dic[@"longitude"] doubleValue];
        _latitude = [(NSNumber*)dic[@"latitude"] doubleValue];
    }
    return self;
}
@end
