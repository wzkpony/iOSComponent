//
//  TitleDropDownBoxCell.h
//  Crmservice
//
//  Created by wzk on 2020/1/15.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SelectViews.h"
NS_ASSUME_NONNULL_BEGIN

@interface TitleDropDownBoxCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet SelectViews *selectView;

@end

NS_ASSUME_NONNULL_END
