//
//  GPEditTextCell.h
//  Crmservice
//
//  Created by wzk on 2020/1/13.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPEditTextCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

NS_ASSUME_NONNULL_END
