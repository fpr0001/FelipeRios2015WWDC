//
//  FPRUtils.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRUtils.h"

@implementation FPRUtils
+(NSString*)getStringDateRangeWithDateBegin:(NSDate*)dateBegin andDateEnd:(NSDate*)dateEnd{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setDateFormat:@"MMM y"];
    
    NSString* date1 = [dateFormatter stringFromDate:dateBegin];
    NSString* date2 = [dateFormatter stringFromDate:dateEnd];
    
    if (!date2) {
        date2 = @"present";
    }
    
    NSString* response = [NSString stringWithFormat:@"%@ - %@",date1,date2];
    return response;
}

+(NSDate*)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    NSDate *date = [calendar dateFromComponents:components];
    
    return date;
}
@end
