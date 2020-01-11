//
//  XXCustomAuthentication.m
//  lockiOS
//
//  Created by wzk on 2019/11/11.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "XXCustomAuthentication.h"

@implementation XXCustomAuthentication
- (void)handleRequestBeforeSend:(IMSRequest * _Nonnull)request
                        payload:(IMSRequestPayload * _Nonnull)payload
                     completion:(void (^ _Nonnull)(NSError * _Nullable error,
                                                   IMSResponse *_Nullable mockResponse,
                                                   IMSRequestPayload * _Nullable newPayload))completionHandler {
    [super handleRequestBeforeSend:request payload:payload completion:^(NSError * _Nullable error, IMSResponse * _Nullable mockResponse, IMSRequestPayload * _Nullable newPayload) {
        completionHandler(error, mockResponse, newPayload);
        
        if (mockResponse && mockResponse.code == 401) {
            //自定义处理 401, 比如 toast
            NSLog(@"before: 401");
        }
    }];
}

- (void)handleResponse:(IMSResponse * _Nonnull)response
            completion:(void (^ _Nonnull)(NSError * _Nullable error, IMSResponse * _Nullable response))completionHandler {
    [super handleResponse:response
               completion:^(NSError * _Nullable error, IMSResponse * _Nullable response) {
                   completionHandler(error, response);
                   
                   if (response && response.code == 401) {
                       //自定义处理 401, 比如 toast
                       NSLog(@"after: 401");
                       [[IMSConfig sharedInstance] aliLogin];
                   }
               }];
}
@end
