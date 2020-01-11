//
//  IMSScannerViewController.m
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/16.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import "IMSScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface IMSScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation IMSScannerViewController

#pragma mark - 初始化方法

- (instancetype)init {
	return [self initWithCompletion:nil errorCompletion:nil];
}

- (instancetype)initWithCompletion:(void(^ __nullable)(NSString *result))completion {
	return [self initWithCompletion:completion errorCompletion:nil];
}

- (instancetype)initWithCompletion:(void(^ __nullable)(NSString *result))completion
				   errorCompletion:(void(^ __nullable)(void))errorCompletion {
	if (self = [super init]) {
		self.completion = completion;
		self.errorCompletion = errorCompletion;
		
		[self setupSession];
	}
	return self;
}

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//判断权限
	[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!granted) {
				if (self.errorCompletion) {
					self.errorCompletion();
				}
			}
		});
	}];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self startScan];
	});
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopScan];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	self.previewLayer.frame = self.view.bounds;
}

#pragma mark - Actions

- (void)startScan {
	if ([_session isRunning]) {
		return;
	}
	[_session startRunning];
}

- (void)stopScan {
	if (![_session isRunning]) {
		return;
	}
	[_session stopRunning];
}

- (void)setupSession {
	
	// 1> 输入设备
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
	
	if (!videoInput) {
		NSLog(@"创建输入设备失败");
		return;
	}
	
	// 2> 创建输出流
	AVCaptureMetadataOutput *dataOutput = [[AVCaptureMetadataOutput alloc]init];
	
	// 3> 拍摄会话 - 判断能够添加设备
	_session = [[AVCaptureSession alloc] init];
	[_session setSessionPreset:AVCaptureSessionPresetHigh];
	
	if (![_session canAddInput:videoInput]) {
		NSLog(@"无法添加输入设备");
		_session = nil;
		
		return;
	}
	
	if (![_session canAddOutput:dataOutput]) {
		NSLog(@"无法添加输入设备");
		_session = nil;
		
		return;
	}
	
	// 4> 添加输入／输出设备
	[_session addInput:videoInput];
	[_session addOutput:dataOutput];
	
	// 5> 设置扫描类型
	dataOutput.metadataObjectTypes = dataOutput.availableMetadataObjectTypes;
	[dataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
	
	// 6> 先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
	if (device.isFocusPointOfInterestSupported &&[device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
	{
		[videoInput.device lockForConfiguration:nil];
		[videoInput.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
		[videoInput.device unlockForConfiguration];
	}
	
	// 7> 设置预览图层会话
	[self setupLayers];
}

/// 设置绘制图层和预览图层
- (void)setupLayers {
	
	if (_session == nil) {
		NSLog(@"拍摄会话不存在");
		return;
	}
	
	// 预览图层
	_previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
	
	_previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	_previewLayer.frame = self.view.bounds;
	
	[self.view.layer insertSublayer:_previewLayer atIndex:0];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
	
	for (id obj in metadataObjects) {
		// 判断检测到的对象类型
		if (![obj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
			return;
		}
		
		// 转换对象坐标
		AVMetadataMachineReadableCodeObject *dataObject = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:obj];
		
		// 判断扫描范围
		if (!CGRectEqualToRect(self.scanFrame, CGRectZero)) {
			if (!CGRectContainsRect(self.scanFrame, dataObject.bounds)) {
				continue;
			}
		}
		
		[self stopScan];
		// 完成回调
		if (self.completion != nil) {
			self.completion(dataObject.stringValue);
		}
	}
}

@end
