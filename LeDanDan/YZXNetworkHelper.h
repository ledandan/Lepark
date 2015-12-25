//
//  YZXNetworkHelper.h
//  LeDanDan
//
//  Created by yzx on 15/12/9.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZXNetworkHelper : NSObject

@property (nonatomic,strong) NSString *_token;           //登录成功的token
@property (nonatomic,strong) NSString *_uid;            //登录成功的id
@property(nonatomic,strong) NSNotificationCenter *_notificationCenter;  //通知中心

/**
 @brief 获取网络助手的单例
 */
+ (YZXNetworkHelper *) shared;

/**
 @brief  退出并清空个人相关信息
 */
-(void) signOut;


/**
 *  保存用户信息（包含token）
 *
 *  @param userInfoDic 用户信息字典
 */
- (void) saveLoginSuccessUserInfo: (NSDictionary *) userInfoDic;


/**
 *  get请求（基于指定的URL及参数）
 *
 *  @param path       请求地址
 *  @param parameters 请求参数，为字典
 *  @param success    成功block块，将返回得到的responseObject
 *  @param failure    失败block块，将打印错误信息
 *
 *  @return 返回NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) apiGet:(NSString *)path
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSDictionary* responseObject))success
                          failure:(void (^)(NSError *error))failure;


/**
 *  post请求（基于指定的URL及参数）
 *
 *  @param path       请求地址
 *  @param parameters 请求参数，为字典
 *  @param success    成功block块，将返回得到的responseObject
 *  @param failure    失败block块，将打印错误信息
 *
 *  @return 返回NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) apiPost:(NSString *)path
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSDictionary* responseObject))success
                           failure:(void (^)(NSError *error))failure;

/**
 *  delete请求（基于指定的URL及参数）
 *
 *  @param path       请求地址
 *  @param parameters 请求参数，为字典
 *  @param success    成功block块，将返回得到的responseObject
 *  @param failure    失败block块，将打印错误信息
 *
 *  @return 返回NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) apiDelete:(NSString *)path
                          parameters:(NSDictionary *)parameters
                             success:(void (^)(NSDictionary* responseObject))success
                             failure:(void (^)(NSError *error))failure;


/**
 *  put请求（基于指定的URL及参数）
 *
 *  @param path       请求地址
 *  @param parameters 请求参数，为字典
 *  @param success    成功block块，将返回得到的responseObject
 *  @param failure    失败block块，将打印错误信息
 *
 *  @return 返回NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) apiPut:(NSString *)path
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSDictionary* responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  所有请求封装（包括get、put、post、delete，包括数据解析）
 *
 *  @param apiPort             请求类型
 *  @param parameters          请求参数，为字典
 *  @param serverInterfaceName 接口名，基于Url.plist文件提取URL
 *  @param needLoading         是否需要显示加载圈
 *  @param success             成功block块，将返回解析后得到的resultDictionary
 *  @param failure             失败block块
 */
- (void ) requestToSeverWithApiPort: (kAPI_PROTO) apiPort
                     withParameters: (NSDictionary *) parameters
            withServerInterfaceName: (NSString *) serverInterfaceName
                        needLoading: (BOOL) needLoding
                            success: (void (^)(NSDictionary* resultDictionary))success
                            failure: (void (^)(NSError *error))failure;


/**
 *  上传数据（文本数据/多媒体数据）
 *
 *  @param path              上传请求地址
 *  @param parameters        上传请求参数集，字典
 *  @param fileURL           上传所带文件地址，URL
 *  @param progress          进度条，会不断更新，UI需自行刷新显示
 *  @param isMultipart       是否是多媒体
 *  @param completionHandler 完成回调方法
 *
 *  @return 返回NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) apiUpload:(NSString *)path
                          parameters:(NSDictionary *)parameters
                            fromFile:(NSData *) fileData
                            progress:(NSProgress * __autoreleasing *)progress
                         isMultipart:(BOOL) isMultipart
                   completionHandler:(void (^)(NSURLResponse *response, NSDictionary* resultDictionary, NSError *error))completionHandler;

/**
 *  监控网络连接状态，当无网络时会自动提示
 */
- (void) checkNetwork;

/**
 *  判断是否已经登录（不包括超时判断）
 */
- (BOOL) checkLogin;


@end
