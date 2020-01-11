//
//  BaseTabController.m
//  ShellJZ
//
//  Created by bairongjinrong on 2018/6/17.
//  Copyright © 2018年 bairongjinrong. All rights reserved.
//

#import "BaseTabController.h"
#import "ColorConfig.h"
@interface BaseTabController ()
@property (nonatomic, strong)UILabel *numberLabel;

@end

@implementation BaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
}

- (id)init {
    self = super.init;
    if (self != nil) {
     
        
    }
    return self;
}


- (void)configTabController:(NSArray<UIViewController *> *)controllers withItemTitle:(NSArray<NSString *> *)titles withUnselectedImage:(NSArray<NSString *> *)unimages withSelectedImage:(NSArray<NSString *> *)images
{
    
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<controllers.count; i++) {
       
        UIViewController *vc = controllers[i];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UIImage *selectedImage = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unSelectedImage = [[UIImage imageNamed:unimages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:unSelectedImage selectedImage:selectedImage];
        
        [vcArray addObject:nav];
        
    }
    
    self.viewControllers =vcArray;

    [self customizeTabBarAppearance];
    
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    self.tabBar.jk_height = App_TabHeight;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = App_GrayColor;
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = App_ThemeColor;
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    //    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    //TODO:解开注释
    [self.tabBar addSubview:self.numberLabel];
    
    self.numberLabel.center = CGPointMake(App_WIDTH/4.0*2+(App_WIDTH/4.0/2)+12,12);//App_WIDTH/4.0*2+(App_WIDTH/4.0/2)-10 = 第二个item的右边+item的宽度+numberLabel宽度的一半
    
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor redColor];
        _numberLabel.font = [UIFont systemFontOfSize:10];
        _numberLabel.backgroundColor = [UIColor whiteColor];
        _numberLabel.clipsToBounds = YES;
        _numberLabel.layer.cornerRadius = 20/2.0;
        _numberLabel.layer.borderWidth = 1;
        _numberLabel.layer.borderColor = _numberLabel.textColor.CGColor;
        _numberLabel.bounds = CGRectMake(0, 0, 20, 20);
        _numberLabel.hidden = YES;
    }
    return _numberLabel;
}

- (void)setNumberString:(NSString *)numberString{
    _numberString = numberString;
    if (App_IsEmpty(numberString)||
        [numberString intValue] == 0) {
        _numberLabel.hidden = YES;
    }
    else{
        _numberLabel.hidden = NO;
        if ([numberString integerValue]>99) {
            numberString = @"99+";
        }
        _numberLabel.text = numberString;
    }
}
- (void)backToHome{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    [nav popToRootViewControllerAnimated:NO];
    self.selectedIndex = 0;
}

- (void)goToTabbarVC:(NSInteger)index {
    self.selectedIndex = index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
