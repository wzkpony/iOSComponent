//
//  GPCalendarView.h
//  Crmservice
//
//  Created by wzk on 2020/2/23.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseView.h"
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPCalendarView : BaseView<FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, copy) void (^selectOKButton)(NSString *dateString);
@end

NS_ASSUME_NONNULL_END
