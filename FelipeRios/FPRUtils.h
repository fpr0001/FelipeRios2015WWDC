//
//  FPRUtils.h
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPRUtils : NSObject
+(NSString*)getStringDateRangeWithDateBegin:(NSDate*)dateBegin andDateEnd:(NSDate*)dateEnd;
+(NSDate*)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
@end
