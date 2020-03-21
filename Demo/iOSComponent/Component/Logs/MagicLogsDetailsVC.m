//
//  MagicLogsDetailsVC.m
//  lockiOS
//
//  Created by wzk on 2020/3/17.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "MagicLogsDetailsVC.h"

@interface MagicLogsDetailsVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MagicLogsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"日志详情";
    NSString *content = [[NSString alloc] initWithContentsOfFile:self.url encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = content;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
