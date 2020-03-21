//
//  IMSScannerMaskView.m
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/11.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import "IMSScannerMaskView.h"

@implementation IMSScannerMaskView

+ (instancetype)maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropRect {
	
	IMSScannerMaskView *maskView = [[self alloc] initWithFrame:frame];
	
	maskView.backgroundColor = [UIColor clearColor];
	maskView.cropRect = cropRect;
	
	return maskView;
}

- (void)setCropRect:(CGRect)cropRect {
	_cropRect = cropRect;
	
	[self setNeedsDisplay];
}

- (void)setMaskViewBackgroundColor:(UIColor *)maskViewBackgroundColor {
	_maskViewBackgroundColor = maskViewBackgroundColor;
	
	[self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor {
	_borderColor = borderColor;
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	UIColor *fillColor = self.maskViewBackgroundColor ?: [UIColor colorWithWhite:0.0 alpha:0.4];
	UIColor *strokeColor = self.borderColor ?: [UIColor colorWithRed:0.04 green:0.56 blue:0.91 alpha:1.00];
	CGFloat borderWidth = self.borderWidth == 0 ? 1.f : self.borderWidth;
	[fillColor setFill];
	CGContextFillRect(ctx, rect);
	
	CGContextClearRect(ctx, self.cropRect);
	
	[strokeColor setStroke];
	CGContextStrokeRectWithWidth(ctx, CGRectInset(_cropRect, borderWidth, borderWidth), borderWidth);
}

@end
