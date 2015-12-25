//
//  NSString_extra.h
//  Missionsky
//
//  Created by Jamie on 14-12-17.
//  Copyright 2014 Missionsky. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (extra)

/**
*  判断字符串是否为Nil或者空
*
*  @param str 需要校验的字符串
*
*  @return  YES:为nil或者空，NO:有内容
*/
+ (BOOL )isNilOrEmpty: (NSString *) str;

/**
 *  电话号码去掉多余的字符
 *
 *  @param phoneNumber 要处理的电话号码字符串
 *
 *  @return 处理过的电话号码
 */
+ (NSString *)normaPhoneNumber:(NSString *)phoneNumber;

@end
