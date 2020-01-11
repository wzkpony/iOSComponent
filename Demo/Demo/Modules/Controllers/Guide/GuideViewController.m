//
//  GuideViewController.m
//  Promotion
//
//  Created by HuMengChi on 15/10/10.
//  Copyright (c) 2015年 hmc. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#define nunmberPage 3
@interface GuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation GuideViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT)];
    scrollView.pagingEnabled = YES;
//    NSString *size = @"YD";
//    if(App_WIDTH == 320){
//        size = @"YD";
//    }else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667){
//        size = @"YD";
//    }else if(SCREEN_HEIGHT == 736){
//        size = @"YD";
//    }else if(SCREEN_HEIGHT == 812){
//        size = @"YD";
//    }
    for (int i = 0; i < nunmberPage; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageName = [NSString stringWithFormat:@"%@%d.png",@"YD",i+1];
        imageView.image = App_IMAGE(imageName);
        [scrollView addSubview:imageView];
        if(i == (nunmberPage-1)){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH*i+(SCREEN_WIDTH-112)/2, SCREEN_HEIGHT-65*App_SCREEN_RATIO6, 112, 30);
//            [btn setImage:[UIImage imageNamed:@"btn_ydy_ljty"] forState:UIControlStateNormal];
            [btn setTitle:@"立即开启" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.clipsToBounds = NO;
            btn.layer.cornerRadius = 10;
            btn.backgroundColor = App_RGB(40, 91, 222);
            [btn addTarget:self action:@selector(gotoLogin_guide) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
        }
    }
    [self.view addSubview:scrollView];
//    [self.view addSubview:self.pageControl];

}
- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        CGSize sizes = [_pageControl sizeForNumberOfPages:nunmberPage];
        _pageControl.frame = CGRectMake(0, SCREEN_HEIGHT-30, sizes.width, sizes.height);
        _pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-30);
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_pageControl setPageIndicatorTintColor:App_UICOLOR_HEX(@"cecece")];
        _pageControl.numberOfPages = nunmberPage;
        _pageControl.currentPage = 0;
    }
 
    return _pageControl;
}

- (void)gotoLogin_guide{
    
    [[NSUserDefaults standardUserDefaults] setValue:App_SYSTEM_VERSION forKey:@"version"];
    AppDelegate *delegate = (AppDelegate *)App_AppDelegate;
//    [delegate gotoTabController];
   
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float index = scrollView.contentOffset.x;
    if(index<0 || index>SCREEN_WIDTH*2){
        if(index<0){
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else if(index>SCREEN_WIDTH*2){
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:NO];
        }
        scrollView.scrollEnabled = NO;
        sleep(0.05);
        scrollView.scrollEnabled = YES;
    }
    if(index>(App_WIDTH*(nunmberPage -2))){
        _pageControl.hidden = YES;
    }
    else{
        _pageControl.hidden = NO;

    }
    self.pageControl.currentPage = (int)index/SCREEN_WIDTH;
}

@end
