//
//  JMPageVC.m
//  JMProject
//
//  Created by wzk on 2019/6/4.
//  Copyright © 2019 JingMai. All rights reserved.
//

#import "JMPageVC.h"

@interface JMPageVC ()

@end

@implementation JMPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLoginVC) name:gotologin object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:gotologin object:nil];
    
    
}
- (void)gotoLoginVC{
    //    if (![self.navigationController.visibleViewController isKindOfClass:[JMLoginVC class]]) {
    
    //    }
    BOOL hasLogin = NO;//是否包含登录
 
    for (id obj in self.navigationController.viewControllers) {
//        if ([obj isKindOfClass:[JMLoginVC class]]) {
//            hasLogin = YES;
//            break;
//        }
    }
    if (hasLogin == NO) {//如果没有登录vc就跳转登录
//        [JMUserBindInfoModel cleanModel];
//        [JMMemberUserLoginModel cleanModel];
//        JMLoginVC* vc = [JMLoginVC new];
//        vc.hidesBottomBarWhenPushed = true;
//        [self.navigationController pushViewController:vc animated:true];
    }
    
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
