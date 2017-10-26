//
//  YJCarInsuranceOtherInfoVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJDishonestyInfoVC.h"
#import "reportDishonestyModel.h"
#import "YJDishonestyInfoCell.h"

@interface YJDishonestyInfoVC ()



@end

@implementation YJDishonestyInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    

    self.title = @"失信被执行报告";
    [self.tableView registerClass:[YJDishonestyInfoCell class] forCellReuseIdentifier:NSStringFromClass([YJDishonestyInfoCell class])];


    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    


    YJDishonestyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJDishonestyInfoCell class])];


    cell.reportDishonestyModel = self.reportDishonestyModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.reportDishonestyModel keyPath:@"reportDishonestyModel" cellClass:[YJDishonestyInfoCell class] contentViewWidth:[self cellContentViewWith]];
    
    
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
