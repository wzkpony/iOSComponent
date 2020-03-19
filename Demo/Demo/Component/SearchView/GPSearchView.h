//
//  GPSearchView.h
//  Crmservice
//
//  Created by wzk on 2019/12/22.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPSearchView : BaseView
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTextFieldLeft;
@end

NS_ASSUME_NONNULL_END
