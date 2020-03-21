//
//  GPCalendarView.m
//  Crmservice
//
//  Created by wzk on 2020/2/23.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "GPCalendarView.h"
@interface GPCalendarView ()
@property (nonatomic, copy) NSString *selectDateString;
@end
@implementation GPCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    [self configCornerRadius:8];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    self.calendar.backgroundColor = [UIColor whiteColor];
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    self.selectDateString = [NSString getUTCFormateLocalDate];
    NSString *yearString = [self.selectDateString timeFromUTCTimeToFormatter:@"yyyy年"];
    NSString *monthDayString = [self.selectDateString timeFromUTCTimeToFormatter:@"MM月dd日"];
    NSString *weekString =  [NSString dateWeekWithDateString:self.selectDateString];
    self.yearLabel.text = yearString;
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",monthDayString,weekString];
    
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(50, 64+17+5, 34, 34);
    previousButton.backgroundColor = [UIColor clearColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.frame)-34-50, 64+17+5, 34, 34);
    nextButton.backgroundColor = [UIColor clearColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    self.nextButton = nextButton;
}

- (IBAction)previousClicked:(UIButton *)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (IBAction)nextClicked:(UIButton *)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}
- (IBAction)cancelClicked:(id)sender {
    [self dismissFromWindowToCenter];
}
- (IBAction)okClicked:(id)sender {
    [self dismissFromWindowToCenter];
    if (self.selectOKButton) {
        self.selectOKButton(self.selectDateString);
    }
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"%@",date);
    self.selectDateString = [NSDate jk_stringWithDate:date format:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *yearString = [self.selectDateString timeFromUTCTimeToFormatter:@"yyyy年"];
    NSString *monthDayString = [self.selectDateString timeFromUTCTimeToFormatter:@"MM月dd日"];
    NSString *weekString =  [NSDate jk_dayFromWeekday:date];
    self.yearLabel.text = yearString;
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",monthDayString,weekString];
}
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return [NSDate date];
}
@end
