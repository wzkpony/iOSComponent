//
//  DropDownBoxCell.h
//  Crmservice
//
//  Created by wzk on 2020/1/13.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SelectViews.h"

NS_ASSUME_NONNULL_BEGIN

@interface DropDownBoxCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet SelectViews *selectView;

@end

NS_ASSUME_NONNULL_END
