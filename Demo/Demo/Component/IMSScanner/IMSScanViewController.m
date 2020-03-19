//
//  CALScan.m
//  CALScan
//
//  Created by Dong on 2017/11/2.
//  Copyright © 2017年 aliyun. All rights reserved.
//


#import "IMSScanViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ZhifubaoAnimation :UIView
- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView*)parentView Image:(UIImage*)image;
- (void)stopAnimating;
@end

@interface ScanView:UIView
@property (nonatomic, strong) ZhifubaoAnimation *scanAnimation;
@end



@interface IMSScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, assign) BOOL isReading;

@property (nonatomic, assign) UIStatusBarStyle originStatusBarStyle;

@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) ScanView *scan;




@end

@implementation IMSScanViewController

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    NSLog(@"二维码页面释放了");
    _session = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCustomView];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
    //判断权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (granted) {
                //不延时，可能会导致界面黑屏并卡住一会
                [self performSelector:@selector(loadScanView) withObject:nil afterDelay:0.2];
                
            } else {
                NSString *title = self.titleStr ? self.titleStr : @"请在iPhone的”设置-隐私-相机“选项中，允许App访问你的相机";

                UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:self.errorConfirm ? self.errorConfirm : @"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击取消了");
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];

            }
            
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;            
    self.navigationController.navigationBarHidden=YES;
    NSString *codeStr = @"扫描二维码";
    
    //title
    if (self.titleStr && self.titleStr.length > 0) {
        self.titleLabel.text = self.titleStr;
    } else {
        self.titleLabel.text = codeStr;
    }
    
    //tip
    if (self.tipStr && self.tipStr.length > 0) {
        self.tipLabel.text = self.tipStr;
    } else {
        self.tipLabel.text= @"请将二维码放置在识别框中";
    }

    [self startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:self.originStatusBarStyle animated:YES];
    
    [self stopRunning];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault)];
    [super viewWillDisappear:animated];
}

- (void)loadScanView {
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device) {
        NSLog(@"模拟器");
        return;
    }
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    if (!input) {
        NSLog(@"模拟器");
        return;
    }
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    //设置扫码支持的编码格式
    
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,
                                 AVMetadataObjectTypeEAN13Code,
                                 AVMetadataObjectTypeEAN8Code,
                                 AVMetadataObjectTypeUPCECode,
                                 AVMetadataObjectTypeCode39Code,
                                 AVMetadataObjectTypeCode39Mod43Code,
                                 AVMetadataObjectTypeCode93Code,
                                 AVMetadataObjectTypeCode128Code,
                                 AVMetadataObjectTypePDF417Code];
    
    
    
    //先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
    if (device.isFocusPointOfInterestSupported &&[device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
    {
        [input.device lockForConfiguration:nil];
        [input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [input.device unlockForConfiguration];
    }
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self startRunning];
}

- (void)loadCustomView {
    
    self.view.backgroundColor=[UIColor blackColor];
    CGRect rc = [[UIScreen mainScreen] bounds];
    //rc.size.height -= 50;
    _width = rc.size.width * 0.1;
    //height = rc.size.height * 0.2;
    _height = (rc.size.height - (rc.size.width - _width * 2))/2;
    
    
    self.scan= [[ScanView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scan];
    
    
    //用于说明的label
    self.tipLabel= [[UILabel alloc] init];
    self.tipLabel.backgroundColor = [UIColor clearColor];
    self.tipLabel.frame=CGRectMake(_width, rc.size.height - _height, rc.size.width - _width * 2, 40);
    self.tipLabel.numberOfLines=0;
    self.tipLabel.textColor=[UIColor whiteColor];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.tipLabel];
    
    
    
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, rc.size.width - 50 - 50, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    

    
    //返回
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"scan_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
}



- (void)startRunning {
    if (self.session) {
        _isReading = YES;        
        [self.session startRunning];
    }
}

- (void)stopRunning {
    [self.scan.scanAnimation stopAnimating];
    [self.session stopRunning];
}


- (void)pressBackButton {
    UINavigationController *nvc = self.navigationController;
    if (nvc) {
        if (nvc.viewControllers.count == 1) {
            [nvc dismissViewControllerAnimated:YES completion:nil];
        } else {
            [nvc popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
//    if (!_isReading) {
//        return;
//    }
    if (metadataObjects.count > 0) {
        _isReading = NO;
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *result = metadataObject.stringValue;
        
        if (self.resultBlock) {
            self.resultBlock(result?:@"");
        }
        
//        [self pressBackButton];
    }
}


@end


#pragma animation


@interface ZhifubaoAnimation()
{
    BOOL isAnimationing;
}

@property (nonatomic,assign) CGRect animationRect;
@property (nonatomic,strong) UIImageView *scanImageView;

@end

@implementation ZhifubaoAnimation

- (instancetype)init{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.scanImageView];
    }
    return self;
}

- (UIImageView *)scanImageView{
    if (!_scanImageView) {
        _scanImageView = [[UIImageView alloc] init];
    }
    return _scanImageView;
}

- (void)stepAnimation
{
    if (!isAnimationing) {
        return;
    }
    
    self.frame = _animationRect;
    
    CGFloat scanNetImageViewW = self.frame.size.width;
    CGFloat scanNetImageH = self.frame.size.height;
    
    __weak __typeof(self) weakSelf = self;
    self.alpha = 0.5;
    _scanImageView.frame = CGRectMake(0, -scanNetImageH, scanNetImageViewW, scanNetImageH);
    [UIView animateWithDuration:1.4 animations:^{
        weakSelf.alpha = 1.0;
        
        _scanImageView.frame = CGRectMake(0, scanNetImageViewW-scanNetImageH, scanNetImageViewW, scanNetImageH);
        
    } completion:^(BOOL finished)
     {
         [weakSelf performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
     }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
}


- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView *)parentView Image:(UIImage*)image
{
    [self.scanImageView setImage:image];
    
    self.animationRect = animationRect;
    
    [parentView addSubview:self];
    
    self.hidden = NO;
    
    isAnimationing = YES;
    
    [self stepAnimation];
}


- (void)dealloc
{
    [self stopAnimating];
}

- (void)stopAnimating
{
    self.hidden = YES;
    isAnimationing = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


@end



@interface ScanView()

@end

@implementation ScanView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    [self drawScanRect];
}

#pragma drawframe

- (void)drawScanRect
{
    
    int centerUpOffset = 60;
    float photoframeLineW = 3.0;
    //!CHANGE
    int XRetangleLeft = 50;
    float photoframeAngleW = 44;
    float photoframeAngleH = 44;
    
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        centerUpOffset = 40;
        XRetangleLeft = 20;
    }
    
    
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - XRetangleLeft*2, self.frame.size.width - XRetangleLeft*2);
    
    
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.frame.size.height / 2.0 - sizeRetangle.height/2.0 - centerUpOffset;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    
    
    NSLog(@"frame:%@",NSStringFromCGRect(self.frame));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //非扫码区域半透明
    
    //设置非识别区域颜色
    
    const CGFloat *components = CGColorGetComponents([UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
    
    
    CGFloat red_notRecoginitonArea = components[0];
    CGFloat green_notRecoginitonArea = components[1];
    CGFloat blue_notRecoginitonArea = components[2];
    CGFloat alpa_notRecoginitonArea = components[3];
    
    
    CGContextSetRGBFillColor(context, red_notRecoginitonArea, green_notRecoginitonArea,
                             blue_notRecoginitonArea, alpa_notRecoginitonArea);
    
    //填充矩形
    
    //扫码区域上面填充
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
    CGContextFillRect(context, rect);
    
    
    //扫码区域左边填充
    rect = CGRectMake(0, YMinRetangle, XRetangleLeft,sizeRetangle.height);
    CGContextFillRect(context, rect);
    
    //扫码区域右边填充
    rect = CGRectMake(XRetangleRight, YMinRetangle, XRetangleLeft,sizeRetangle.height);
    CGContextFillRect(context, rect);
    
    //扫码区域下面填充
    rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle);
    CGContextFillRect(context, rect);
    //执行绘画
    CGContextStrokePath(context);
    
    
    CGRect scanRetangleRect = CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height);
    
    self.scanAnimation = [[ZhifubaoAnimation alloc]init];
    [self.scanAnimation startAnimatingWithRect:scanRetangleRect
                                        InView:self
                                         Image:[UIImage imageNamed:@"scan_full_net"]];
    
    
    //画矩形框4格外围相框角
    
    //相框角的宽度和高度
    int wAngle = photoframeAngleW;
    int hAngle = photoframeAngleH;
    
    //4个角的 线的宽度
    CGFloat linewidthAngle = photoframeLineW;// 经验参数：6和4
    
    //画扫码矩形以及周边半透明黑色坐标参数
    CGFloat diffAngle = 0.0f;
    //diffAngle = linewidthAngle / 2; //框外面4个角，与框有缝隙
    //diffAngle = linewidthAngle/2;  //框4个角 在线上加4个角效果
    //diffAngle = 0;//与矩形框重合
    
    diffAngle = -1*photoframeLineW/2;
//    UIColor *colorAngle = [UIColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0];
    //!CHANGE
    UIColor *colorAngle = [UIColor whiteColor];
    CGContextSetStrokeColorWithColor(context,colorAngle.CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, linewidthAngle);
    
    
    //
    CGFloat leftX = XRetangleLeft - diffAngle;
    CGFloat topY = YMinRetangle - diffAngle;
    CGFloat rightX = XRetangleRight + diffAngle;
    CGFloat bottomY = YMaxRetangle + diffAngle;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    
    CGContextStrokePath(context);
}

@end

