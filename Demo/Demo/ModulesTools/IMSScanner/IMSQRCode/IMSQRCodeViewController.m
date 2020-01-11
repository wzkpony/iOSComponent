//
//  IMSQRCodeViewController.m
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import "IMSQRCodeViewController.h"
#import "IMSScannerViewController.h"
#import "IMSScannerBorder.h"
#import "IMSScannerMaskView.h"

@interface IMSQRCodeViewController ()
@property (strong, nonatomic) IMSScannerBorder *scannerBorder;
@property (strong, nonatomic) IMSScannerMaskView *maskView;

@property (assign, nonatomic, readwrite) CGFloat scannerRectOffset;
@property (strong, nonatomic, readwrite) UIColor *scannerColor;

@property (strong, nonatomic, readwrite) UILabel *topTipLabel;
@property (strong, nonatomic, readwrite) UILabel *bottomTipLabel;
@end

@implementation IMSQRCodeViewController

#pragma mark - 初始化方法
- (instancetype)init {
	return [self initWithScanRectOffset:0.f
						   scannerColor:nil
							 completion:nil
						errorCompletion:nil];
}

- (instancetype)initWithCompletion:(void (^)(NSString * _Nonnull))completion {
	return [self initWithScanRectOffset:0.f
						   scannerColor:nil
							 completion:completion
						errorCompletion:nil];
}

- (instancetype)initWithCompletion:(void (^)(NSString * _Nonnull))completion errorCompletion:(void (^)(void))errorCompletion {
	return [self initWithScanRectOffset:0.f
						   scannerColor:nil
							 completion:completion
						errorCompletion:errorCompletion];
}

- (instancetype)initWithScanRectOffset:(CGFloat)scannerRectOffset
						  scannerColor:(UIColor * __nullable)scannerColor
							completion:(void(^ __nullable)(NSString *result))completion
					   errorCompletion:(void(^ __nullable)(void))errorCompletion {
	if (self = [super initWithCompletion:completion errorCompletion:errorCompletion]) {
		_scannerRectOffset = scannerRectOffset;
		_scannerColor = scannerColor ?: [UIColor colorWithRed:0.04 green:0.56 blue:0.91 alpha:1.00];
		_topMargin = 30.f;
		_bottomMargin = 30.f;
		_maskViewBackgroundColor = [UIColor colorWithWhite:0.f alpha:0.4f];
		
		[self configTip];
	}
	return self;
}

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self configUI];
	self.scanFrame = self.scannerBorder.frame;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[_scannerBorder startScannerAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[_scannerBorder stopScannerAnimating];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	CGFloat centerX = CGRectGetMidX(self.view.bounds);
	CGFloat centerY = CGRectGetMidY(self.view.bounds);
	_scannerBorder.center = CGPointMake(centerX,  centerY + self.scannerRectOffset);
	self.maskView.cropRect = _scannerBorder.frame;
	self.scanFrame = self.scannerBorder.frame;
	
	CGFloat topTipHeight = [self.topTipLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.topTipLabel.font} context:nil].size.height;
	CGFloat bottomTipHeight = [self.bottomTipLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.bottomTipLabel.font} context:nil].size.height;
	CGFloat scanRectMinY = CGRectGetMinY(_scannerBorder.frame);
	CGFloat scanRectMaxY = CGRectGetMaxY(_scannerBorder.frame);
	self.topTipLabel.frame = CGRectMake(0, scanRectMinY - self.topMargin - topTipHeight, self.view.bounds.size.width, topTipHeight);
	self.bottomTipLabel.frame = CGRectMake(0, scanRectMaxY + self.bottomMargin, self.view.bounds.size.width, bottomTipHeight);
}

#pragma mark - Action

- (void)backEvent:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - configUI

- (void)configUI {
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	[self configScanerBorder];
}

- (void)configScanerBorder {
	
	CGFloat margin = 120.0f;
	
	if ([UIScreen mainScreen].bounds.size.height <= 568 )
	{
		//3.5inch 显示的扫码缩小
		margin = 80.f;
	}
	
	CGFloat width = self.view.bounds.size.width - margin;
	
	_scannerBorder = [[IMSScannerBorder alloc] initWithFrame:CGRectMake(0, 0, width, width) lineLength:0.f lineWidth:0.f lineColor:_scannerColor];
	_scannerBorder.scannerLineColor = _scannerColor;
	_scannerBorder.center = CGPointMake(self.view.center.x, self.view.center.y + self.scannerRectOffset);

	[self.view addSubview:_scannerBorder];

	_maskView = [IMSScannerMaskView maskViewWithFrame:self.view.bounds cropRect:_scannerBorder.frame];
	_maskView.borderColor = _scannerColor;
	_maskView.maskViewBackgroundColor = self.maskViewBackgroundColor;
	[self.view addSubview:_maskView];
}

- (void)configTip {
	UILabel *topTipLabel = [[UILabel alloc] init];
	topTipLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.f];
	topTipLabel.textColor = [UIColor whiteColor];
	topTipLabel.textAlignment = NSTextAlignmentCenter;
	
	UILabel *bottomTipLabel = [[UILabel alloc] init];
	bottomTipLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.f];
	bottomTipLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
	bottomTipLabel.textAlignment = NSTextAlignmentCenter;
	
	self.topTipLabel = topTipLabel;
	self.bottomTipLabel = bottomTipLabel;
	[self.view addSubview:topTipLabel];
	[self.view addSubview:bottomTipLabel];
	
}

#pragma mark - Setter

- (void)setTopMargin:(CGFloat)topMargin {
	_topMargin = topMargin;
	[self.view setNeedsLayout];
	[self.view layoutIfNeeded];
}

- (void)setBottomMargin:(CGFloat)bottomMargin {
	_bottomMargin = bottomMargin;
	[self.view setNeedsLayout];
	[self.view layoutIfNeeded];
}

- (void)setMaskViewBackgroundColor:(UIColor *)maskViewBackgroundColor {
	_maskViewBackgroundColor = maskViewBackgroundColor;
	self.maskView.maskViewBackgroundColor = maskViewBackgroundColor;
}

@end
