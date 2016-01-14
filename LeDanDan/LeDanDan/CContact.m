//
//  CContact.m
//  LeDanDan
//
//  Created by yzx on 16/1/12.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "CContact.h"
#import "pinyin.h"

@implementation CContact

-(void)dealloc
{

    _recordID = nil;
    _firstName = nil;
    _lastName = nil;
    _compositeName = nil;
    _image = nil;
    _phoneInfo = nil;
    _emailInfo = nil;

}


-(NSMutableDictionary *)phoneInfo
{
    if(_phoneInfo == nil)
    {
        _phoneInfo = [[NSMutableDictionary alloc] init];
    }
    
    return _phoneInfo;
}


-(NSMutableDictionary *)emailInfo
{
    if(_emailInfo == nil)
    {
        _emailInfo = [[NSMutableDictionary alloc] init];
    }
    return  _emailInfo;
}



@end