//
//  IFWebViewController.m
//  IronFish
//
//  Created by wzk on 2018/12/11.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "JMWebViewController.h"

@interface JMWebViewController ()<UIScrollViewDelegate>

@end

@implementation JMWebViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;

    [nav showNavBar];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
    [nav hiddenNavBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"WebViewController-viewDidLoad");
//    if (@available(iOS 11.0, *)) {
//        //顶部20偏移
//        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self settingRegisterJSHandler];
    self.webView.scrollView.delegate = self;
}

- (void)settingRegisterJSHandler{
    /**
     注册一个js回调方法
     
     在代理方法：
     -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
     回调得到数据
     */
    /**
     onLinkMyHouse ：我的房产
     参考文档：http://git.adinnet.cn/wangzhengkui/H5Markdown/blob/master/%E9%93%81%E9%B1%BCH5%E4%BA%A4%E4%BA%92.md
     */
//    [self settingJsBridge:@"onLinkMyHouse"];//跳转我的房产
   

}

/**滑动隐藏和显示状态栏*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    CGFloat f = scrollView.contentOffset.y;
//
//    BaseNavigationController *nav =  (BaseNavigationController *)self.navigationController;
//    [nav settingViewBarColor:App_RGBA(105,126,214,f/64.0)];
    
}
/**js回调*/
- (void)jsResponseCallback:(NSString *)registerHandler data:(id)data webView:(APPWebVC *)webView{
    NSLog(@"123456-回调成功");

   
    
//    if ([registerHandler isEqualToString:@"onLinkMyHouse"]) {
//        VC = [IFRouter getViewControllerWithKey:IronFish_MyHouseListVC(nil)];
//    }
//    [self.navigationController pushViewController:VC animated:YES];

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
