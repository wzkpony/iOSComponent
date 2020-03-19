//
//  BaseViewController.m
//  TodayGo
//
//  Created by Felix on 2017/7/16.
//
//

#import "BaseViewController.h"


@interface BaseViewController ()<UIGestureRecognizerDelegate>
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLoginVC) name:gotologin object:nil];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.view endEditing:YES];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:gotologin object:nil];
}
- (void)gotoLoginVC{
//    if (![self.navigationController.visibleViewController isKindOfClass:[JMLoginVC class]]) {

//    }
//    if ( [JMMemberUserLoginModel user].showLogin) {
//        return;
//    }
//    [JMMemberUserLoginModel user].showLogin = true;
//    BOOL hasLogin = NO;//是否包含登录
//
//    for (id obj in self.navigationController.viewControllers) {
//        if ([obj isKindOfClass:[JMLoginVC class]]) {
//            hasLogin = YES;
//            break;
//        }
//    }
//
//    if (hasLogin == NO) {//如果没有登录vc就跳转登录
//       BOOL is =   [NSThread isMainThread];
//        NSLog(@"如果没有登录vc就跳转登录  %d",is);
//        [JMUserBindInfoModel cleanModel];
//        [JMMemberUserLoginModel cleanModel];
//
//        JMLoginVC* vc = [JMLoginVC new];
//        vc.hidesBottomBarWhenPushed = true;
//
//        [self.navigationController pushViewController:vc animated:true];
//    }
    
}
- (void)configLeftBarButtonItem:(UIView *)view
{
    if (view != nil) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.navigationItem.rightBarButtonItem = item;
    }
    else{
        if (self.navigationController.viewControllers.count > 1) {
            UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            [buttonLeft setImage:App_IMAGE(@"icon_fanhui") forState:UIControlStateNormal];
            buttonLeft.bounds = CGRectMake(0, 0, 30, 44);
            buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonLeft addTarget:self action:@selector(backBtnSelect) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
//            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage: style:UIBarButtonItemStylePlain target:self action:@selector(backBtnSelect)];
            self.navigationItem.leftBarButtonItem = item;
        }
        else{
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
            self.navigationItem.rightBarButtonItem = item;
        }
   
    }
    
}
- (void)configRithtBarButtonItem:(UIView *)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)configNavBarBackgroundImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
- (IBAction)backBtnSelect
{
    if (_backMorePage == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
         [self.navigationController jk_popToViewControllerWithLevel:_backMorePage + 1 animated:true];
    }

}
 
-(UIStatusBarStyle)preferredStatusBarStyle {
    return _statusStyle?_statusStyle:UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return _statusBarHidden?_statusBarHidden:NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    self.navH.constant = App_NavHeight;

    [self configLeftBarButtonItem:nil];
//    self.tabBarController.tabBar.hidden = YES;

    
//    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:[self.navigationController screenEdgePanGestureRecognizer]];

    
}

- (void)dealloc
{
    NSLog(@"[%@ dealloc]",NSStringFromClass([self class]));
}

NSString *decimalNumberWithDouble(double conversionValue){
    NSString *doubleString        = [NSString stringWithFormat:@"%.02lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

int decimalFloatWithInteger(NSString * conversionValue){
    NSString *doubleString        = [NSString stringWithFormat:@"%.2f", [conversionValue floatValue]*10];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber intValue];
}
@end
