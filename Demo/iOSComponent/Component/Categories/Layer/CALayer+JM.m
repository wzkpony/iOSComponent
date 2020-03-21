//
//  CALayer+JKBorderColor.m
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 Xidibuy. All rights reserved.
//

#import "CALayer+JKBorderColor.h"

@implementation CALayer (CALayerJM)

-(void)setBorderColorFromUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

-(void)setBackgroundColorFromUIColor:(UIColor *)color{
    self.shadowColor = color.CGColor;
}

@end
