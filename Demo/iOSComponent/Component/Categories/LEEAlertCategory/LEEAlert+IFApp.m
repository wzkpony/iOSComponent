//
//  LEEAlert+IFApp.m
//  IronFish
//
//  Created by wzk on 2018/12/24.
//  Copyright © 2018 wzk. All rights reserved.
//
/*
// 默认LEEAlert弹框
//    [LEEAlert alert].config
//    .LeeTitle(@"标题")
//    .LeeContent(@"内容")
//    .LeeCancelAction(@"取消", ^{
//        // 取消点击事件Block
//    })
//    .LeeAction(@"确认", ^{
//        // 确认点击事件Block
//    })
//    .LeeShow();
 //自定义
 [LEEAlert alert].config
 .LeeAddTitle(^(UILabel *label) {
 
 // 自定义设置Block
 
 // 关于UILabel的设置这里不多说了
 
 label.text = @"标题";
 
 label.textColor = [UIColor redColor];
 })
 .LeeAddContent(^(UILabel *label) {
 
 // 自定义设置Block
 
 // 同标题一样
 })
 .LeeAddTextField(^(UITextField *textField) {
 
 // 自定义设置Block
 
 // 关于UITextField的设置你们都懂的 这里textField默认高度为40.0f 如果需要调整可直接设置frame 当然frame只有高度是有效的 其他的均无效
 
 textField.textColor = [UIColor redColor];
 })
 .LeeAddCustomView(^(LEECustomView *custom) {
 
 // 自定义设置Block
 
 // 设置视图对象
 custom.view = view;
 
 // 设置自定义视图的位置类型 (包括靠左 靠右 居中 , 默认为居中)
 custom.positionType = LEECustomViewPositionTypeLeft;
 
 // 设置是否自动适应宽度 (自适应宽度后 位置类型为居中)
 custom.isAutoWidth = YES;
 })
 .LeeAddAction(^(LEEAction *action) {
 
 // 自定义设置Block
 
 // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
 
 action.title = @"确认";
 
 action.titleColor = [UIColor blueColor];
 })
 .LeeShow();

 */

#import "LEEAlert+IFApp.h"

@implementation LEEAlert (IFApp)
+ (void)showOKAndCell{
    
    [LEEAlert alert].config
    .LeeCornerRadius(5)
    .LeeAddContent(^(UILabel *label) {
        // 自定义设置Block
        label.text = @" 确认拨打400-991-1110么？";
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
        label.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
        
    })
    .LeeAddAction(^(LEEAction *action) {
        // 自定义设置Block
        // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
        action.title = @"取消";
        action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        action.titleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
        action.clickBlock = ^{
            NSLog(@"取消");
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        // 自定义设置Block
        // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
        action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        action.title = @"确定";
        action.backgroundImage = [UIImage imageNamed:@"Rectangle27"];
        action.titleColor = [UIColor whiteColor];
        action.clickBlock = ^{
            NSLog(@"确定");
        };
    })
    
    .LeeShow();
}

+ (void)close{
    // 关闭当前显示的Alert或ActionSheet
    [LEEAlert closeWithCompletionBlock:^{
        
        //如果在关闭后需要做一些其他操作 建议在该Block中进行
    }];
}
@end
