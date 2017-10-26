//
//  YJReportSampleVC.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJReportSampleVC.h"
#import "ReportBaseInfoCell.h"
#import "ReportSectionView.h"
@interface YJReportSampleVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YJReportSampleVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = RGB_yellow;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportBaseInfoCell" bundle:nil] forCellReuseIdentifier:ReportSectionViewIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportSectionView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"ReportSampleHeader"];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,64, 0);
    self.tableView.backgroundView = [UIView new];
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportSectionViewIdentifier forIndexPath:indexPath];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ReportSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ReportSampleHeader"];

    return sectionView;
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//
//    UITableViewHeaderFooterView *headerView=(UITableViewHeaderFooterView *)view;
//    [headerView.backgroundView setBackgroundColor:RGB(240, 242, 245)];
//}

- (IBAction)backTop:(UIButton *)sender {
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    
}



@end
