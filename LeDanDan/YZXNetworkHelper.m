//
//  YZXNetworkHelper.m
//  LeDanDan
//
//  Created by yzx on 15/12/9.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "YZXNetworkHelper.h"
#import <AFNetworking.h>

#import <MBProgressHUD.h>
#import "AMLogger.h"
#import "Utility.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "ObjectCTools.h"
#define vTimeOutTime  30.0  //超时时间

//@implementation YZXNetworkHelper

static NSString * const FORM_FLE_INPUT = @"upload";

static YZXNetworkHelper *_instance = nil;

@interface YZXNetworkHelper ()
{
    BOOL __block _haveNetwork;  //是否有网络
    MBProgressHUD *_progressHUD;  //有进度的加载圈
}
@property(nonatomic,strong) AFHTTPSessionManager *_manager;

@end

@implementation YZXNetworkHelper
@synthesize _token;
@synthesize _uid;
@synthesize _notificationCenter;

/**
 @brief 获取网络助手的单例
 */
+ (YZXNetworkHelper *)shared;
{
    
    if(!_instance){
        _instance = [[YZXNetworkHelper alloc] init];
    }
    return _instance;
}

-(id) init{
    self = [super init];
    if (self) {
        self._manager = [AFHTTPSessionManager manager];
        self._manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        self._notificationCenter = [[NSNotificationCenter alloc] init];  //通知中心
        _haveNetwork = YES;
        [self checkNetwork];   //监控网络状态
        [self setTokenAndUid];  //读取之前的token和uid
        
    }
    
    return self;
}

/**
 @brief  退出并清空个人相关信息
 */
-(void) signOut
{
    [self clearTheTokenAndUid];
}

#pragma mark ---------------- 请求头构造 -----------------
-(AFHTTPRequestSerializer *) prepareJSONRequestSerializer{
    
    //因为是 "application/x-www-form-urlencoded" 方式，所以不能用json方式初始化 !!!切记，json方式时才能用AFJSONRequestSerializer
    //  AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
    AFHTTPRequestSerializer *requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    requestSerializer.timeoutInterval = vTimeOutTime;
    //    //如果没有token，先取本地token进行配置---
    //    if (self._token == nil)
    //    {
    //        [self setTokenAndUid];
    //    }
    //    //配置后再进行head设置
    //    if (self._token)
    //    {
    //        [requestSerializer setValue:self._token forHTTPHeaderField:@"Authorization"];
    //    }
    
    //"application/x-www-form-urlencoded" 使用AFHTTPRequestSerializer 默认亦可
    [requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"enctype"];
    
    NSLog(@"请求头为：\n%@", requestSerializer.HTTPRequestHeaders);
    return requestSerializer;
}

-(void) setInitTokenWithRequest:(NSMutableURLRequest *) request withIsMultipart: (BOOL) isMultipart
{
    request.timeoutInterval = vTimeOutTime;
    //    //如果没有token，先取本地token进行配置---,后统一放到参数 中
    //    if (self._token == nil)
    //    {
    //        [self setTokenAndUid];
    //    }
    //    //配置后再进行head设置
    //    if (self._token)
    //    {
    //        [request setValue:self._token forHTTPHeaderField:@"Authorization"];
    //    }
    if (!isMultipart)
    {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"enctype"];
    }
    else
    {
        [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"multipart/form-data" forHTTPHeaderField:@"enctype"];
    }
    
    
    NSLog(@"请求头为：\n%@", request.allHTTPHeaderFields);
    
}



/**
 *  初始化上传图片等多媒体request
 *
 *  @param url         请求url
 *  @param postParems  请求参数
 *  @param picFilePath 请求上传的文件路径,与数据流二选1
 *  @param picFileName 请求文件名，尽量设置成唯一
 *  @param picData     请求上传文件的数据流
 *
 *  @return 得到的request
 */
- (NSMutableURLRequest *)customInitRequestWithURL: (NSString *)url
                                       postParems: (NSDictionary *)postParems
                                      picFilePath: (NSString *)picFilePath
                                      picFileName: (NSString *)picFileName
                                        orPicData: (NSData *) picData;
{
    //根据url初始化request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    request.timeoutInterval = vTimeOutTime;  //超时时间
    
    //http method
    [request setHTTPMethod:@"POST"];
    
    //---------------------------------------------------------------------------
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //---------------------------------------------------------------------------
    
    //得到图片的data
    NSData* data;
    if(picFilePath)
    {
        
        UIImage *image=[UIImage imageWithContentsOfFile:picFilePath];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image))
        {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
    }
    else
        data = picData;
    //NSLog(@"%@",data);
    
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
        
        //        NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
    }
    // NSLog(@"body==%@",body);
    
    if((picFilePath) || (picData))
    {
        ////添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        
        //声明pic字段，文件名
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,picFileName];
        
        //声明上传文件的格式
        [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    }
    //    NSLog(@"body = %@", body);
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    if((picFilePath)||(picData))
    {
        //将image的data加入
        NSLog(@"长度为%luf",(unsigned long)[data length]);
        [myRequestData appendData:data];
    }
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    
    NSLog(@"-------请求头为:%@", request.allHTTPHeaderFields);
    return request;
}


#pragma mark ---------------- 基本请求 -----------------
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
                          failure:(void (^)(NSError *error))failure{
    
    self._manager.requestSerializer = [self prepareJSONRequestSerializer];
    
    NSURLSessionDataTask *task = [self._manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFaileWith:error];
        NSLog(@"error = %@", [error debugDescription]);
        failure(error);
        
    }];
    AMLogInfo(@"\nBegin Request[Delete]: %@ ", [self serializeURL:path params:parameters]);
    return task;
}

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
                           failure:(void (^)(NSError *error))failure{
    
    self._manager.requestSerializer = [self prepareJSONRequestSerializer];
    NSURLSessionDataTask *task = [self._manager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFaileWith:error];
        NSLog(@"error = %@", [error debugDescription]);
        failure(error);
        
    }];
    AMLogInfo(@"\nBegin Request[Post]: %@ \n Post Body: %@ ", path,parameters);
    return task;
}


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
                             failure:(void (^)(NSError *error))failure{
    
    self._manager.requestSerializer = [self prepareJSONRequestSerializer];
    
    NSURLSessionDataTask *task = [self._manager DELETE:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFaileWith:error];
        NSLog(@"error = %@", [error debugDescription]);
        failure(error);
        
    }];
    AMLogInfo(@"\nBegin Request[Delete]: %@ ", [self serializeURL:path params:parameters]);
    return task;
}


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
                   completionHandler:(void (^)(NSURLResponse *response, NSDictionary* resultDictionary, NSError *error))completionHandler{
    
    //加载圈
    [[ObjectCTools shared] addLoading];
    dispatch_async(dispatch_get_main_queue() , ^{
        //加载圈
        _progressHUD = nil;
        _progressHUD = [MBProgressHUD showHUDAddedTo:[[ObjectCTools shared] getAppDelegate].window animated:YES];
        _progressHUD.mode = MBProgressHUDModeDeterminate; //饼图
    });
    
    //先检查网络状态
    if (!_haveNetwork)
    {
        //影藏加载圈
        [[ObjectCTools shared] dissmissLoading];
        [UIView showAlertView:@"无网络连接" andMessage:@"请检查您的网络设置"];
        NSError *oneError = [[NSError alloc] init];
        completionHandler(nil,nil,oneError);
        return nil;
    }
    
    
    
    NSMutableURLRequest *request = [self customInitRequestWithURL:path postParems:parameters picFilePath:nil picFileName:[NSString stringWithFormat:@"%@.jpg", [ObjectCTools shared].generateUuidString] orPicData:fileData];
    NSURLSessionUploadTask *task = [self._manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [[ObjectCTools shared] dissmissLoading];
        [self printUploadInfo:response fileURL:path request:request error:error];
        if (completionHandler) {
            completionHandler(response,[self resolveResponse:responseObject],error);
        }
    }];
    
    // 添加一个 KVO 的监听方法
    [*progress addObserver:self
                forKeyPath:@"fractionCompleted"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
    
    [task resume];
    return task;
}


//打印上传的输出
- (void)printUploadInfo:(NSURLResponse *)response fileURL:(NSObject *)fileURL request:(NSMutableURLRequest *)request error:(NSError *)error
{
    //Print Error
    if (error) {
        NSMutableURLRequest *mRequest = request;
        AMLogError(@"\nError!!!Request Failure![Upload]: %@ \n %@", mRequest.URL,mRequest.allHTTPHeaderFields);
        AMLogError(@"\nResponse Headers: %@  \n Error: %@ ",((NSHTTPURLResponse *)response).allHeaderFields,error);
    }else{
        //Print Info
        NSMutableURLRequest *mRequest = request;
        AMLogVerbose(@"\nRequest[Upload]: %@ \n %@", mRequest.URL,mRequest.allHTTPHeaderFields);
        NSString *body = [NSString stringWithFormat:@"FilePath: %@",fileURL];
        AMLogVerbose(@"\nResponse Headers: %@  \n %@ ",((NSHTTPURLResponse *)response).allHeaderFields,body);
    }
}


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
                          failure:(void (^)(NSError *error))failure{
    
    self._manager.requestSerializer = [self prepareJSONRequestSerializer];
    
    NSURLSessionDataTask *task = [self._manager PUT:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFaileWith:error];
        NSLog(@"error = %@", [error debugDescription]);
        failure(error);
    }];
    AMLogInfo(@"\nBegin Request[Post]: %@ \n Post Body: %@ ", path,parameters);
    return task;
    
}


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
                            failure: (void (^)(NSError *error))failure
{
    if (needLoding)
    {
        //加载圈
        [[ObjectCTools shared] addLoading];
    }
    //先检查网络状态
    if (!_haveNetwork)
    {
        //影藏加载圈
        [[ObjectCTools shared] dissmissLoading];
        [UIView showAlertView:@"无网络连接" andMessage:@"请检查您的网络设置"];
        failure(nil);
        return;
    }
    switch (apiPort)
    {
        case kAPI_GET:
        {
            [self apiGet:[[ObjectCTools shared] getUrlsFromPlistFile:serverInterfaceName] parameters:parameters success:^(NSDictionary *responseObject) {
                success ([self resolveResponse:responseObject]);
                
            } failure:^(NSError *error) {
                failure(error);
                
            }];
        }
            break;
        case kAPI_POST:
        {
            [self apiPost:[[ObjectCTools shared] getUrlsFromPlistFile:serverInterfaceName] parameters:parameters success:^(NSDictionary *responseObject) {
                success([self resolveResponse:responseObject]);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }
            break;
        case kAPI_DELETE:
        {
            [self apiDelete :[[ObjectCTools shared] getUrlsFromPlistFile:serverInterfaceName] parameters:parameters success:^(NSDictionary *responseObject) {
                success ([self resolveResponse:responseObject]);
            } failure:^(NSError *error) {
                failure(error);
                
            }];
        }
            break;
        case kAPI_PUT:
        {
            [self apiPut :[[ObjectCTools shared] getUrlsFromPlistFile:serverInterfaceName] parameters:parameters success:^(NSDictionary *responseObject) {
                success ([self resolveResponse:responseObject]);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }
            break;
        default:
            break;
    }
    
}

//进一步解析并打印得到的Response
- (NSDictionary *) resolveResponse: (NSDictionary *) getResponseObject
{
    NSDictionary *getDic = nil;
    if (!getResponseObject)
    {
        NSLog(@"----返回nil");
        return getDic;
    }
    NSData *data = (NSData *)getResponseObject;
    //打出得到字符串信息--------------------------
    NSString *getString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if (getString == nil)
    {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        getString = [[NSString alloc]initWithData:data encoding:enc];
    }
    
    NSLog(@"返回的信息getString = %@", getString);
    
    //确定json为字典使用
    getDic = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    if (getDic)
    {
        NSLog(@"请求成功, 得到的字典为: %@", getDic);
    }
    else
    {
        NSLog(@"----返回非字典, getsuccess");
    }
    //影藏加载圈
    [[ObjectCTools shared] dissmissLoading];
    
    
    //超时处理//不同应用处理方式不一;-----------------------------------------
    if ([[getDic objectForKey:@"status"] isEqualToString:@"-1"] || [[getDic objectForKey:@"message"] isEqualToString:@"Invalid Error!"] || [[getDic objectForKey:@"message"] isEqualToString:@"Invalid Error!#1"])
    {
        //需先登录,同时返回时还需要在此页
       // [MainPageViewController shareMainPageVC]._needBackToThisMainPage = NO;
        //[[ObjectCTools shared].getAppDelegate signOut];
    }
    
    return (getDic);  //将得到的字典返回
    
}

- (void) requestFaileWith: (NSError *) error
{
    //影藏加载圈
    [[ObjectCTools shared] dissmissLoading];
    //    [UIView showAlertView:@"请求失败" andMessage:[NSString stringWithFormat:@"Erro code = %ld \nErro userInfo = %@", (long)error.code, error.userInfo]];
    if (!(error.code == -1009))
    {
        //非网络连接错误才弹提示框
        if (error.code == -1005)
        {
            [UIView showAlertView:@"网络连接错误" andMessage:@"请检查您的网络设置"];
        }
        else if (error.code == -1001)
        {
            [UIView showAlertView:@"网络连接不稳定" andMessage:@"请检查您的网络设置"];
        }
        else
        {
            [UIView showAlertView:@"请求失败" andMessage:[NSString stringWithFormat:@"Error code = %ld", (long)error.code]];
        }
    }
    else
    {
        //        [UIView showAlertView:@"网络连接错误" andMessage:@"请检查您的网络设置"]; //不再重复提示
    }
    
}

//body参数拼接
- (NSString *)serializeURL:(NSString *)baseUrl params:(NSDictionary *)params {
    
    NSURL* parsedURL = [NSURL URLWithString:baseUrl];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    
    if (!params) {
        params = [[NSMutableDictionary alloc] init] ;
        NSLocale *locale=[NSLocale currentLocale];
        NSString *language = [NSString stringWithFormat:@"%@", locale.localeIdentifier];
        [params setValue:language forKey:@"lang"];
    }else{
        
        params = [NSMutableDictionary dictionaryWithDictionary:params];
        
        if (![params objectForKey:@"lang"]) {
            NSLocale *locale=[NSLocale currentLocale];
            NSString *language = [NSString stringWithFormat:@"%@", locale.localeIdentifier];
            [params setValue:language forKey:@"lang"];
        }
    }
    
    NSMutableArray* pairs = [NSMutableArray array];
    if (params) {
        for (NSString* key in [params keyEnumerator]){
            NSString *paramValue = [params valueForKey:key];
            NSString* escaped_value = [Utility stringByURLEncodingString:paramValue];
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        }
    }
    
    NSString* query = [pairs componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}




#pragma mark ---------------- Token 相关 -----------------
/**
 *  保存用户信息（包含token）
 *
 *  @param userInfoDic 用户信息字典
 */
- (void) saveLoginSuccessUserInfo
: (NSDictionary *) userInfoDic
{
    self._token = nil;
    self._uid = nil;
    NSDictionary *userInfo = [userInfoDic objectForKey:@"data"];
    self._token = (NSString *)[userInfo objectForKey:@"token"];
    self._uid = (NSString *)[userInfo objectForKey:@"uid"];
    NSLog(@"保存成功登录的个人信息: %@", userInfo);
   // [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:kLastLoginUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置token
- (void) setTokenAndUid
{
//   // NSDictionary *userInfo = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
//    if (userInfo)
//    {
//        self._token = (NSString *)[userInfo objectForKey:@"token"];
//        self._uid = (NSString *)[userInfo objectForKey:@"uid"];
//        NSLog(@"****--------设置旧的token = %@", self._token);
//    }
}

//清空token
- (void) clearTheTokenAndUid
{
    self._token = nil;
    self._uid = nil;
    //[[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastLoginUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark ---------------- 实时网络状态监控 -----------------
/*
 AFNetworkReachabilityStatusUnknown = -1, 未知
 AFNetworkReachabilityStatusNotReachable = 0, 未連接
 AFNetworkReachabilityStatusReachableViaWWAN = 1, 3G
 AFNetworkReachabilityStatusReachableViaWiFi = 2, 無線連接
 */

/**
 *  监控网络连接状态，当无网络时会自动提示
 */
- (void)checkNetwork
{
    //    AFNetworkReachabilityManager *checkManager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityManager *checkManager = [AFNetworkReachabilityManager managerForAddress:(__bridge const void *)([[ObjectCTools shared] getServerAdderss])];
    [checkManager startMonitoring];
    [checkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [UIView showAlertView:@"无网络连接" andMessage:@"请检查您的网络设置"];
                _haveNetwork = NO;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"网络连接:3g");
                _haveNetwork = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"网络连接:Wifi");
                _haveNetwork = YES;
                break;
            case AFNetworkReachabilityStatusUnknown:
                [UIView showAlertView:@"网络连接错误" andMessage:@"请检查您的网络设置"];
                _haveNetwork = NO;
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark ---------------- 登录状态判断 -----------------
/**
 *  判断是否已经登录（不包括超时判断）
 */
- (BOOL) checkLogin
{
    if (!self._token)
    {
        [[ObjectCTools shared] showAlertViewAndDissmissAutomatic:@"您还未登录哦" andMessage:@"请先登录" withDissmissTime:1.2 withDelegate:nil withAction:nil];
        [self performSelector:@selector(goTologin) withObject:nil afterDelay:1.2];
        return NO;
    }
    return YES;
}

- (void) goTologin
{
    //[[[ObjectCTools shared] getAppDelegate] addLoginView: YES];
}

#pragma mark ---------------- UI 刷新 -----------------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
        _progressHUD.progress = progress.fractionCompleted;
    }
}




@end
