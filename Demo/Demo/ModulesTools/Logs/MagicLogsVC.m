//
//  MagicLogsVC.m
//  lockiOS
//
//  Created by wzk on 2020/3/17.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "MagicLogsVC.h"
#import "MagicLogsDetailsVC.h"
#import "MagicLogManager.h"

@interface MagicLogsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MagicLogsVC
+ (UINavigationController *)shareMagicLogsVC{
    static UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MagicLogsVC *vc = [MagicLogsVC new];
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return nav;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"日志";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Logscell"];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = [[MagicLogManager shareManager] getAllLogFilePath].count;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Logscell" forIndexPath:indexPath];
    NSString *url = [[MagicLogManager shareManager] getAllLogFilePath][indexPath.row];
    cell.textLabel.text = url;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [[MagicLogManager shareManager] getAllLogFilePath][indexPath.row];
    MagicLogsDetailsVC *vc = [MagicLogsDetailsVC new];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
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
