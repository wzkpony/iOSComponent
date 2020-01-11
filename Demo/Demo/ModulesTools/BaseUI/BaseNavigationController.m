//
//  BaseNavigationController.m
//  TodayGo
//
//  Created by Felix on 2017/7/16.
//
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationBarDelegate,UIGestureRecognizerDelegate>
@end

@implementation BaseNavigationController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;

    [self settingNavBarColor:App_NavBarColor titleColor:App_RGB(38, 38, 38) alpha:1];//、
    
}
/**设置系统的navigationBar的背景颜色和透明度和字体颜色*/
- (void)settingNavBarColor:(UIColor *)barColor titleColor:(UIColor *)titleColor alpha:(CGFloat)alpha{
    self.navigationBarHidden = NO;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.tintColor = titleColor;
    self.navigationBar.barTintColor = barColor;
    self.navigationBar.backgroundColor = barColor;

    self.navigationBar.alpha = alpha;

}

- (void)showNavBar{
    self.navigationBarHidden = NO;

}
- (void)hiddenNavBar{
    self.navigationBarHidden = YES;
    
}

- (void)selectBackNav{
    [self popViewControllerAnimated:YES];
}


/**手势问题*/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}




@end
