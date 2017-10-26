//
//  YJSocialSecurityDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSocialSecurityDetailsVC.h"
#import "YJSocialSecurityDetailCell.h"
#import "YJSocialSecurityModel.h"
@interface YJSocialSecurityDetailsVC ()
{
}
@end

@implementation YJSocialSecurityDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"存缴明细";
    CGFloat rowH = 0;
    if (_isMaternity) {
        rowH = 185 ;
    } else {
        rowH = 155 ;
    }
    self.tableView.rowHeight = rowH + 10;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);

    if (self.insuranceDataArr.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    } else {
        [self setupFooterNODataView];
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (!self.insuranceDataArr.count) {
//        [self.view makeToast:@"暂无数据"];
//    }
//    if ((self.tableView.rowHeight*self.insuranceDataArr.count)>=SCREEN_HEIGHT) {
//        [self setupFooterNODataView];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.insuranceDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJSocialSecurityDetailCell *cell = [YJSocialSecurityDetailCell socialSecurityDetailCellWithTableView:tableView isMaternity:_isMaternity];
    cell.baseInsurance = self.insuranceDataArr[indexPath.row];
    
    return cell;
}

- (void)setupFooterNODataView {
    UILabel *noDataLB = [[UILabel alloc] init];
    noDataLB.backgroundColor = [UIColor clearColor];
    noDataLB.text = @"没有更多数据了";
    noDataLB.textAlignment = NSTextAlignmentCenter;
    noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    noDataLB.font = Font15;
    noDataLB.textColor = RGB_grayPlaceHoldText;
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = RGB_pageBackground;
    [bgView addSubview:noDataLB];
    self.tableView.tableFooterView = bgView;
}


@end
