//
//  RequestUtil.m
//  JJShipping
//
//  Created by Mr.Han on 2017/4/25.
//  Copyright © 2017年 Adinnet_Mac. All rights reserved.
//

#import "RequestUtil.h"

/**
 * token:配置header里。
 * timeout_Interval 配置事件
 * urlDomain: 配置url域名
 **/


NSInteger  const timeout_Interval = 60;//

NSString * const URLDomain = App_BASE_URL;

@implementation RequestUtil


+ (nullable RequestUtil *)manager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
+ (AFHTTPSessionManager *)settingSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
/**
 AFJSONRequestSerializer :json提交
 AFHTTPResponseSerializer ：表单提交或者键值对提交
 */
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeout_Interval;
    /*
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
      NSArray *arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:App_ShowString([UserModel shareUser].token) forHTTPHeaderField:@"SESSION_TOKEN"];
    
    NSString *deviceID = App_ShowString([NSString getDeviceId:@"com.yujian.lock" kKeychainDeviceId:@"KeychainDeviceId"]);
    
    [manager.requestSerializer setValue:deviceID forHTTPHeaderField:@"CONTEXT_ID"];
    
    [manager.requestSerializer setValue:@"WEB_SERVICE" forHTTPHeaderField:@"SOURCE"];
    
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:cidKey] forHTTPHeaderField:@"C_ID"];
    
    [manager.requestSerializer setValue:App_iOSChannle forHTTPHeaderField:@"CONTEXT_PLATFORM"];
    */

//
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"multipart/form-data",@"image/jpeg",@"image/png",@"text/plain",@"application/json",@"text/json",nil];
  
    return manager;
    
}

+ (void)listenerRequest{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        return;
    }
}

#pragma mark -- 普通POST请求 --
+ (void)requestPost:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    [self listenerRequest];
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,action];
    AFHTTPSessionManager *manager = [self settingSessionManager];
    [MBProgressHUD ll_showActivity];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD ll_dismiss];

        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        @try {
            completionBlock(response.statusCode,nil,responseObject);
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD ll_dismiss];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        @try {
            NSDictionary *userInfo = error.userInfo;
            if (userInfo[@"com.alamofire.serialization.response.error.data"] != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                if (dic != nil) {
                }

            }
        } @catch (NSException *exception) {
        }
        NSInteger statusCode = [response statusCode];

        completionBlock(statusCode,error.description,nil);
    }];

    
}

//
#pragma mark -- 普通Get请求 --
+(void)requestGet:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    [self listenerRequest];
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,action];
    AFHTTPSessionManager *manager = [self settingSessionManager];
    [MBProgressHUD ll_showActivity];

    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = [response statusCode];
        completionBlock(statusCode,nil,responseObject);
        [MBProgressHUD ll_dismiss];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD ll_dismiss];

        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *userInfo = error.userInfo;
        if (userInfo[@"com.alamofire.serialization.response.error.data"] != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
        }
        
        NSInteger statusCode = [response statusCode];
       
        NSLog(@"请求失败 url = %@\nerror = %@",url,error.description);

        completionBlock(statusCode,error.description,nil);
    }];
}

#pragma mark -- Patch请求 --
+(void)requestPatch:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    
    [self listenerRequest];
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,action];
    AFHTTPSessionManager *manager = [self settingSessionManager];
    [MBProgressHUD ll_showActivity];

    [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        @try {
            completionBlock(response.statusCode,nil,dic);
        } @catch (NSException *exception) {
        }
        [MBProgressHUD ll_dismiss];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *userInfo = error.userInfo;
        
        NSInteger statusCode = [response statusCode];
     
        completionBlock(statusCode,error.description,nil);
        [MBProgressHUD ll_dismiss];

    }];
}


//普通Delete请求
#pragma -- 普通Delete请求 --
+ (void)requestDelete:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock {
    
    [self listenerRequest];
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,action];
    AFHTTPSessionManager *manager = [self settingSessionManager];
    [MBProgressHUD ll_showActivity];

    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        completionBlock(response.statusCode,nil,dic);
        [MBProgressHUD ll_dismiss];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        
        NSDictionary *userInfo = error.userInfo;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSInteger statusCode = [response statusCode];
        
        completionBlock(statusCode,error.description,nil);
        [MBProgressHUD ll_dismiss];

    }];    
}

#pragma mark -- 多个上传文件 --
/**
 mimeType的格式—— 大类/小类
 
 JPG   image/jpg
 
 PNG   image/png
 
 JSON  application/json
 
 PDF   application/pdf
 
 names 对应网站上[upload.php中]处理文件的字段（比如upload）,上传到服务器，接受这个图片的字段名
 
 fileName 这个文件在服务器的名字。
 */
+(void)requestPostForFiles:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray nameKeys:(NSArray <NSString *>*)names mimeTypes:(NSArray <NSString *>*)mimeTypes completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    
    [self listenerRequest];
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,action];
    AFHTTPSessionManager *manager = [self settingSessionManager];
    if (App_IsEmpty(params[@"chatMsg"]) == YES) {

    }
    [MBProgressHUD ll_showActivity];


    [manager POST:url parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        for (int i = 0; i < fileArray.count; i++) {
            id tmpFileData =[fileArray objectAtIndex:i];
            NSData *fileData;
            if ([tmpFileData isKindOfClass:[NSData class]]) {
                fileData = tmpFileData;
            }
            else if([tmpFileData isKindOfClass:[UIImage class]]){
                fileData = UIImageJPEGRepresentation(tmpFileData, 0.5);
            }
            
            
            NSString *type = mimeTypes[i];
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            if ([type containsString:@"mpeg"]){
                fileName = [NSString  stringWithFormat:@"%@.mp3", dateString];
                NSError *error ;
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:tmpFileData] name:names[i] error:&error];
                NSLog(@"%@",error.localizedDescription);
            }
            else{
                /*
                 *该方法的参数
                 1. appendPartWithFileData：要上传的照片[二进制流]
                 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                 3. fileName：要保存在服务器上的文件名
                 4. mimeType：上传的文件的类型
                 */
                [formData appendPartWithFileData:fileData name:names[i] fileName:fileName mimeType:type];
            }
           
         
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD ll_dismiss];
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        @try {
            completionBlock(response.statusCode,nil,responseObject);
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD ll_dismiss];

    }];
}

#pragma mark -- DownLoad --
+ (void)requestDownLoadURL:(NSString *)urlString completionBlock:(void(^)(id errorString, id responseObject ))completionBlock
{
    AFHTTPSessionManager *manager = [self settingSessionManager];
//    NSString *url = [NSString stringWithFormat:@"%@%@",URLDomain,urlString];

    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [MBProgressHUD ll_showActivity];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        completionBlock(error,filePath);
        [MBProgressHUD ll_dismiss];
    }];
    [downloadTask resume];
}

#pragma mark -- 使用NSURLSession 发起一个get请求 --
+ (void)requestGetURLSession:(NSString *)urlString completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock
{
    
   
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;

    __block NSMutableArray *useCookies = [[NSMutableArray alloc] init];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain isEqualToString:@"dubhe.zhaochewisdom.com"]) {
            [useCookies addObject:obj];
        }
    }];
    
    NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:useCookies];
    
    //将cookie塞进Request请求
 
    
    NSURL *url = [NSURL URLWithString:urlString];
    //2.构造Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //(1)设置为POST请求
    [request setHTTPMethod:@"GET"];
    //(2)超时
    [request setTimeoutInterval:60];
    //(3)设置请求头
    
    [request setValue:[headers objectForKey:@"Cookie"]forHTTPHeaderField:@"Cookie"];
    
    NSString *contentType = [NSString stringWithFormat:@"text/html;image/jpeg;text/plain;application/json"];
    [request setAllHTTPHeaderFields:@{@"Authorization":@"",@"Content-Type":contentType}];
    
    //(4)设置请求体
    //    NSString *bodyStr = @"user_name=admin&user_password=admin";
    //    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //设置请求体
    [request setHTTPBody:nil];
    //3.构造Session
    [MBProgressHUD ll_showActivity];

    NSURLSession *session = [NSURLSession sharedSession];        //4.task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        NSDictionary *dic = @{};
        if (data != nil) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        completionBlock(responseStatusCode,nil,dic);
        [MBProgressHUD ll_dismiss];

        
    }];
    [task resume];
}




/**获取web的cookie*/
+ (NSString *)getCookies
{
    NSArray *arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    NSString *cookieStr = @"";
    
    for (NSHTTPCookie *cookie in arr) {
        if ([cookie.name isEqualToString:@"ecology_JSessionId"]) {
            cookieStr = [NSString stringWithFormat:@"%@=%@",cookie.name, cookie.value];
            break;
        }
    }
    return cookieStr;
}
 /**图片压缩*/
+ (NSData *)configImageData:(UIImage *)image{
   
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2.0, image.size.height/2.0));
    [image drawInRect:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(resultImage, 0.3);
    return data;
}

//iOS进行NTLM认证
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    NSLog(@"开始认证...");
    
    NSString *authMethod = [[challenge protectionSpace] authenticationMethod];
    NSLog(@"%@认证...",authMethod);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }else{
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
        }
    }
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodNTLM]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialWithUser:@"guoluo" password:@"Gl@1234" persistence:NSURLCredentialPersistenceForSession];
            
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }else{
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
        }
    }
    
    NSLog(@"认证结束...");
}


@end
