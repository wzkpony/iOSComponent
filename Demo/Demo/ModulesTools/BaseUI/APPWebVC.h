//
//  APPWebVC.h
//  QingLvProject
//
//  Created by Felix on 2018/7/11.
//  Copyright © 2018年 Adinnet. All rights reserved.
//

#import "WebViewJavascriptBridge.h"

//定义枚举类型
typedef enum URLType {
    URLNet  = 0,
    PathLocation,
    htmlString
    
} URLType;
@class APPWebVC;
@protocol APPWebVCDelegate
- (void)jsResponseCallback:(NSString *)registerHandler data:(id)data webView:(APPWebVC *)webView;
@end



@interface APPWebVC : UIViewController

@property (nonatomic, assign) URLType urlType;

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, weak) id delegateWeb;

@property (strong,nonatomic) WKWebView *webView;

@property (strong,nonatomic) WebViewJavascriptBridge* bridge;


/**设置JSBridge*/
- (void)settingJsBridge:(NSString *)registerHandler;
@end
