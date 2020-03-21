//
//  SplashViewController.m
//  ChannelPlus
//
//  Created by Peter on 15/1/26.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "SplashViewController.h"
#import "AppDelegate.h"
#define Duration 3


@interface SplashViewController ()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, assign) int count;

@property (nonatomic, retain)  dispatch_source_t timer;

@property (nonatomic, strong) UIView *tabView;

@property (nonatomic, strong) UIImageView *titleImage;


@end
static int const showtime = Duration;

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // 1.广告图片
    _adView = [[UIImageView alloc] init];
    _adView.userInteractionEnabled = YES;
    _adView.contentMode = UIViewContentModeScaleAspectFill;
    _adView.clipsToBounds = YES;
    _adView.backgroundColor = [UIColor whiteColor];
    // 为广告页面添加一个点击手势，跳转到广告页面
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
//    [_adView addGestureRecognizer:tap];
    
    // 2.跳过按钮
    CGFloat btnW = 60.0;
    CGFloat btnH = 30.0;
    _countBtn = [[UIButton alloc] init];
    [_countBtn addTarget:self action:@selector(removeAdvertView) forControlEvents:UIControlEventTouchUpInside];
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    _countBtn.layer.cornerRadius = 4;
    
    [self.view addSubview:_adView];
    [self.view addSubview:_countBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.adView.mas_width).multipliedBy(1.6);
    }];
    
    [_countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(App_StatusBarHeight));
        make.right.equalTo(@-20.0);
        make.height.equalTo(@(btnH));
        make.width.equalTo(@(btnW));
    }];
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.adView.mas_bottom);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
    [self.tabView addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakSelf.tabView);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self start];
}

- (UIView *)tabView{
    if (_tabView == nil) {
        _tabView = [[UIView alloc] init];
        _tabView.backgroundColor = [UIColor whiteColor];//App_RGB(180, 170, 175)
 
    }
    return _tabView;
}

- (UIImageView *)titleImage{
    if (_titleImage == nil) {
        _titleImage = [[UIImageView alloc] init];
        _titleImage.image = App_IMAGE(@"tabLogo");
        _titleImage.contentMode = UIViewContentModeScaleAspectFit;
        _titleImage.backgroundColor = [UIColor clearColor];
    }
    return _titleImage;
}


- (void)pushToAd {
    
    [self removeAdvertView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLPushToAdvert" object:nil userInfo:nil];
}

- (void)countDown {
    
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self removeAdvertView];
    }
}

// 广告页面的跳过按钮倒计时功能可以通过定时器或者GCD实现
- (void)start {
    [self startCoundown];
}

// GCD倒计时
- (void)startCoundown {
    __weak __typeof(self) weakSelf = self;
    __block int timeout = showtime; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    }
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(self->_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf removeAdvertView];
                
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
                timeout--;

            });
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)removeAdvertView {
  
    // 停掉定时器
    dispatch_source_cancel(_timer);


    AppDelegate *delegate = (AppDelegate *)App_AppDelegate;
    NSString *locationVer = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if ([locationVer isEqualToString:App_SYSTEM_VERSION]) {
//        [delegate gotoTabController];
    }
    else{
//        [delegate gotoGuideVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
