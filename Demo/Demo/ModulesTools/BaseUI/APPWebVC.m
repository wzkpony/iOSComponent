//
//  APPWebVC.m
//  QingLvProject
//
//  Created by Felix on 2018/7/11.
//  Copyright © 2018年 Adinnet. All rights reserved.
//

#import "APPWebVC.h"
//#import "WebKit/WebKit.h"
#import "AFNetworking.h"
@interface APPWebVC ()<UIWebViewDelegate,WKNavigationDelegate,UIScrollViewDelegate>
@property (strong,nonatomic) UIProgressView *progressView;

@end

@implementation APPWebVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWKWebView];


}

- (void)initWKWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];//CGRectMake(0, 0, App_WIDTH, App_HEIGHT -App_NavHeight)
    webview.navigationDelegate = self;
    webview.UIDelegate = self;
    webview.scrollView.showsVerticalScrollIndicator = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView = webview;
    [self.view addSubview:self.webView];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    

    //添加网络加载进度条
    UIProgressView *progressView = [[UIProgressView alloc]init];//CGRectMake(0, 0, App_WIDTH, 3)
    progressView.progressTintColor = [UIColor greenColor];
    progressView.trackTintColor = [UIColor whiteColor];
    self.progressView = progressView;
    [webview addSubview:progressView];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(App_NavHeight));
        make.left.right.equalTo(webview);
        make.height.equalTo(@3.0);
    }];
    
    if (@available(iOS 13.0, *)) {}else{
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSArray *arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    
    [arr enumerateObjectsUsingBlock:^(NSHTTPCookie *cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",cookie.name);
    }];
    
//    NSString *urlString = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:self.urlStr];
    if (self.urlType == PathLocation) {
        url = [NSURL fileURLWithPath:self.urlStr];
        
        [webview loadFileURL:url allowingReadAccessToURL:url];
    }
    else if (self.urlType == htmlString){
//        loadHTMLString
        [webview loadHTMLString:self.urlStr baseURL:nil];
    }
    else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];        
        [webview loadRequest:request];
    }
    
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    NSLog(@"%@",strRequest);
    
    decisionHandler(WKNavigationActionPolicyAllow);

}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"开始加载");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"加载成功");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        self.progressView.hidden = self.progressView.progress>=1;
    }
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            if (![self.webView.title isEqualToString:@"Title"]) {
                self.navigationItem.title = self.webView.title;
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
    }

}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


/**设置JSBridge*/

- (void)settingJsBridge:(NSString *)registerHandler
{
    /**日志*/
    //    [WebViewJavascriptBridge enableLogging];
    self.delegateWeb = self;
    [self.bridge setWebViewDelegate:self];
    __weak typeof(self) mySelf = self;
    [self.bridge registerHandler:registerHandler handler:^(id data, WVJBResponseCallback responseCallback) {
        if (mySelf.delegateWeb != nil) {
            if ([mySelf.delegateWeb respondsToSelector:@selector(jsResponseCallback:data:webView:)]) {
                [mySelf.delegateWeb jsResponseCallback:registerHandler data:data webView:mySelf];
            }
        }
    }];
}
- (WebViewJavascriptBridge *)bridge{
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    }
    return _bridge;
}
-(void)dealloc{
    self.webView.scrollView.delegate = nil;

    self.webView.navigationDelegate = nil;
    //一定要关闭KVO
    if (@available(iOS 13.0, *)) {}else{
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end
