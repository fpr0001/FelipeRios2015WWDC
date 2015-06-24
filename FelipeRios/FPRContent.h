//
//  FPRContent.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPRContent : NSObject
@property(nonatomic)NSString* stringTopic;
@property(nonatomic)NSString* stringSubtopic;
@property(nonatomic)double longitude;
@property(nonatomic)double latitude;
@property(nonatomic)NSString* stringImageName;
@property(nonatomic)NSString* stringDescription;
@property(nonatomic)NSDate* dateBegin;
@property(nonatomic)NSDate* dateEnd;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
@end
