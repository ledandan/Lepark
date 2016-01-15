//
//  MyOrderModel.h
//  LeDanDan
//
//  Created by yzx on 16/1/15.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"
@interface MyOrderModel :JSONModel

@property (nonatomic ,copy) NSString *activitysLogo;
@property (nonatomic, copy) NSString *activitysName;
@property (nonatomic, copy) NSString *activitysPrice;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *status;

@end
