//
//  BaseTabController.h
//  ShellJZ
//
//  Created by bairongjinrong on 2018/6/17.
//  Copyright © 2018年 bairongjinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface BaseTabController : UITabBarController
@property (nonatomic,copy) NSString *numberString;
- (void)configTabController:(NSArray<UIViewController *> *)controllers withItemTitle:(NSArray<NSString *> *)titles withUnselectedImage:(NSArray<NSString *> *)unimages withSelectedImage:(NSArray<NSString *> *)images;
- (void)backToHome;


- (void)goToTabbarVC:(NSInteger)index;
@end
