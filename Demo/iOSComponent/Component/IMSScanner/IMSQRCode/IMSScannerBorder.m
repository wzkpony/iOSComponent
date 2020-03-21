//
//  IMSScannerBorder.m
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import "IMSScannerBorder.h"

@interface IMSScannerBorder ()
@property (assign, nonatomic, readwrite) CGFloat lineLength;
@property (assign, nonatomic, readwrite) CGFloat lineWidth;
@property (strong, nonatomic, readwrite) UIColor *lineColor;

@property (strong, nonatomic) UIImageView *scannerLine;
@property (strong, nonatomic) CALayer *borderLayer;
@property (strong, nonatomic) NSTimer *animationTimer;
@end

#pragma mark - 扫描动画方法

@implementation IMSScannerBorder 

/// 开始扫描动画
- (void)startScannerAnimating {
	[self stopScannerAnimating];
	
	self.animationTimer = [NSTimer timerWithTimeInterval:1.7f target:self selector:@selector(repeatScannerAnimating) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
	[self.animationTimer fire];
}

- (void)repeatScannerAnimating {
	self.scannerLine.frame = CGRectMake(0, -self.scannerLine.bounds.size.height, self.bounds.size.width, self.scannerLine.bounds.size.height);
	self.scannerLine.alpha = 0.5f;
	
	[UIView animateWithDuration:1.4f
						  delay:0.f
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.scannerLine.alpha = 1.0f;
						 self.scannerLine.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
						 
					 } completion:nil];
}

/// 停止扫描动画
- (void)stopScannerAnimating {
	if (self.animationTimer) {
		[self.animationTimer invalidate];
		self.animationTimer = nil;
	}
	
	[_scannerLine.layer removeAllAnimations];
	_scannerLine.frame = CGRectMake(0, -_scannerLine.bounds.size.height, self.bounds.size.width, _scannerLine.bounds.size.height);
	_scannerLine.alpha = 0.5f;
}

#pragma mark - LifeCircle
- (instancetype)initWithFrame:(CGRect)frame
				   lineLength:(CGFloat)lineLength
					lineWidth:(CGFloat)lineWidth
					lineColor:(UIColor * __nullable)lineColor {
	if (self = [super initWithFrame:frame]) {
		_lineWidth = lineWidth == 0 ?  4.f : lineWidth ;
		_lineLength = lineLength == 0 ? 23.f : lineLength;
		_lineColor = lineColor ?: [UIColor colorWithRed:0.04 green:0.56 blue:0.91 alpha:1.00];
		self.tintColor = [UIColor colorWithRed:0.04 green:0.56 blue:0.91 alpha:1.00];
		
		[self configUI];
	}
	return self;
}

- (void)dealloc {
	[self stopScannerAnimating];
}

- (void)configUI {
	self.clipsToBounds = YES;
	
	// 图像文件包
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSURL *url = [bundle URLForResource:@"IMSScanner" withExtension:@"bundle"];
	NSBundle *imageBundle = bundle;
	if (url) {
		imageBundle = [NSBundle bundleWithURL:url];
	}
	
	// 冲击波图像
	_scannerLine = [[UIImageView alloc] initWithImage:[self imageWithName:@"scan_full_net" bundle:imageBundle]];
	_scannerLine.frame = CGRectMake(0, -self.bounds.size.width, self.bounds.size.width, self.bounds.size.width);
	_scannerLine.alpha = 0.5f;
	
	[self addSubview:_scannerLine];
	
	// 加载边框
	CGFloat width = self.bounds.size.width;
	CGFloat height = self.bounds.size.height;
	
	double offset = self.lineWidth / 2;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	
	//top
	[path moveToPoint:CGPointMake(0, offset)];
	[path addLineToPoint:CGPointMake(self.lineLength, offset)];
	[path moveToPoint:CGPointMake(width - self.lineLength, offset)];
	[path addLineToPoint:CGPointMake(width, offset)];
	
	//bottom
	[path moveToPoint:CGPointMake(0, height - offset)];
	[path addLineToPoint:CGPointMake(self.lineLength, height - offset)];
	[path moveToPoint:CGPointMake(width - self.lineLength, height - offset)];
	[path addLineToPoint:CGPointMake(width, height - offset)];
	
	//left
	[path moveToPoint:CGPointMake(offset, 0)];
	[path addLineToPoint:CGPointMake(offset, self.lineLength)];
	[path moveToPoint:CGPointMake(offset, height - self.lineLength)];
	[path addLineToPoint:CGPointMake(offset, height)];
	
	//right
	[path moveToPoint:CGPointMake(width - offset, 0)];
	[path addLineToPoint:CGPointMake(width - offset, self.lineLength)];
	[path moveToPoint:CGPointMake(width - offset, height - self.lineLength)];
	[path addLineToPoint:CGPointMake(width - offset, height)];
	
	[path closePath];
	
	CAShapeLayer *layer = [[CAShapeLayer alloc] init];
	layer.path = path.CGPath;
	layer.strokeColor = self.lineColor.CGColor;
	layer.lineWidth = self.lineWidth;
	layer.frame = self.bounds;
	layer.backgroundColor = [UIColor clearColor].CGColor;
	
	[self.layer addSublayer:layer];
	
	_borderLayer = layer;
}

#pragma mark - Setter

- (void)setScannerLineColor:(UIColor *)scannerLineColor {
	_scannerLineColor = scannerLineColor;
	self.tintColor = scannerLineColor;
}

#pragma mark - Tools

- (UIImage *)imageWithName:(NSString *)imageName bundle:(NSBundle *)imageBundle {
	NSString *fileName = [NSString stringWithFormat:@"%@", imageName];
	NSString *path = [imageBundle pathForResource:fileName ofType:@"png"];
	
	return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}


@end
