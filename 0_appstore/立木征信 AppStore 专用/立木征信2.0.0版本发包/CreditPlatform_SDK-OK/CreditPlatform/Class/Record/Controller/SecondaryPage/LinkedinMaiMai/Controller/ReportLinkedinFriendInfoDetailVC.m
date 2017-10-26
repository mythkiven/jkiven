//
//  YJReportLinkedinFriendInfoVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportLinkedinFriendInfoDetailVC.h"
#import "ReportLinkedinFriendInfoDetailCell.h"
@interface ReportLinkedinFriendInfoDetailVC ()

@end

@implementation ReportLinkedinFriendInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight =  405;
    
    
}
 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportLinkedinFriendInfoDetailCell *cell = [[ReportLinkedinFriendInfoDetailCell alloc] reportLinkedinFriendInfoDetailCell:tableView];
    cell.searchType =self.searchType;
    if (self.searchType == SearchItemTypeMaimai) {
        cell.mmModel = _data;
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        cell.linkModel = _data;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchType == SearchItemTypeMaimai) {
        return 405;
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        return 405-5*35;
    }
    return 0;
}



@end
