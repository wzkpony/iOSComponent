//
//  COSBBBViewController.m
//  COSCOEBProject
//
//  Created by Eve on 2018/11/29.
//  Copyright © 2018 COSCO. All rights reserved.
//

#import "COSDocPickerViewController.h"

@interface COSDocPickerViewController ()

@end

@implementation COSDocPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> forState:<#(UIControlState)#>]
//    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:self.view.tintColor], for: .normal)
//    UIButton.appearance().tintColor = self.view.tintColor
//
//    UIImageView.appearance().tintColor = self.view.tintColor
//    UITabBar.appearance().tintColor = self.view.tintColor
//    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = self.view.tintColor

    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateHighlighted];
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



@end
