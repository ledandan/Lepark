//
//  NSString_extra.m
//  Missionsky
//
//  Created by Jamie on 14-12-17.
//  Copyright 2014 Missionsky. All rights reserved.
//

#import "NSString_extra.h"

@implementation NSString(extra)

/**
 *  判断字符串是否为Nil或者空
 *
 *  @param str 需要校验的字符串
 *
 *  @return  YES:为nil或者空，NO:有内容
 */
+ (BOOL )isNilOrEmpty: (NSString *) str;
{
    if (str && ![str isEqualToString:@""])
    {
        return NO;
    }
    
    return YES;
}

/**
 *  电话号码去掉多余的字符
 *
 *  @param phoneNumber 要处理的电话号码字符串
 *
 *  @return 处理过的电话号码
 */
+ (NSString *)normaPhoneNumber:(NSString *)phoneNumber
{
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:phoneNumber.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:phoneNumber];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        }
        // --------- Add the following to get out of endless loop
        else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
        // --------- End of addition
    }
    return strippedString;
}


@end
