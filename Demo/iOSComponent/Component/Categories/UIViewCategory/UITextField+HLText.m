//
//  UITextField+HLText.m
//  lockiOS
//
//  Created by wzk on 2019/11/5.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "UITextField+HLText.h"

@implementation UITextField (HLText)
//重写initialize
+ (void)initialize
{
    // 获取到UITextField中setText对应的method
    Method setText =class_getInstanceMethod([UITextField class], @selector(setText:));
    Method setTextMySelf =class_getInstanceMethod([self class],@selector(setTextHooked:));
    
    // 将目标函数的原实现绑定到setTextOriginalImplemention方法上
    IMP setTextImp =method_getImplementation(setText);
    class_addMethod([UITextField class], @selector(setTextOriginal:), setTextImp,method_getTypeEncoding(setText));
    
    //然后用我们自己的函数的实现，替换目标函数对应的实现
    IMP setTextMySelfImp =method_getImplementation(setTextMySelf);
    class_replaceMethod([UITextField class], @selector(setText:), setTextMySelfImp,method_getTypeEncoding(setText));
    
}


- (void)setTextHooked:(NSString *)string
{
    
    //    //在这里插入过滤算法
    //    string = [stringstringByReplacingOccurrencesOfString:@"
    //              " withString:@"\r\n"];
    
    // do something what ever youwant
    
    string = App_EmojiCheatUniCode(string);
    
    // invoke originalimplemention
    [self performSelector:@selector(setTextOriginal:) withObject:string];
    
}
@end
