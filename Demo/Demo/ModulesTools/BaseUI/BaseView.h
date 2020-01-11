//
//  BaseView.h
//  IronFish
//
//  Created by wzk on 2018/12/17.
//  Copyright © 2018 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

- (instancetype)init;
- (instancetype)setupView;

/**将自己加到KeyWindow上*/
- (void)showToWindow;
- (void)showToWindowToCenter;
/**将自己从keywindow上移除*/
- (void)dismissFromWindow;
- (void)dismissFromWindowToCenter;

/**添加到当前的vc上*/
- (void)showToViewController:(UIViewController *)VC;
- (void)closePOPVC:(id)obj;
@end

NS_ASSUME_NONNULL_END
