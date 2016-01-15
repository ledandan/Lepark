//
//  MyCollectionModel.h
//  LeDanDan
//
//  Created by yzx on 16/1/15.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "JSONModel.h"

@interface MyCollectionModel : JSONModel

@property (nonatomic, copy) NSString *activitysId;
@property (nonatomic, copy) NSString *activitysName;
@property (nonatomic, copy) NSString *activitysLogo;
@property (nonatomic, copy) NSString *activitysDateTime;
@property (nonatomic, copy) NSString *activitysAddress;
@property (nonatomic, copy) NSString *activitysPrice;
@property (nonatomic, copy) NSString *collectionId;


@end

