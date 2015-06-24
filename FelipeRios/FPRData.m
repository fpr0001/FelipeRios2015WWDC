//
//  FPRData.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 24/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

#import "FPRData.h"

@implementation FPRData

-(id) init
{
    self = [super init];
    if (self)
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FPRData" ofType:@"plist"];
        NSDictionary* dicAux = [[ NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSMutableDictionary* dicResponse = [[NSMutableDictionary alloc]init];
        
        for (NSString* key in dicAux.allKeys) {
            FPRContent* content = [[FPRContent alloc]initWithDictionary:dicAux[key]];
            [dicResponse setObject:content forKey:[NSNumber numberWithInteger:key.integerValue]];
        }
        
        _dictionaryData = dicResponse;
    }
    return self;
}

@end