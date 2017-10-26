//
//  YJRepoortCreditEmailBillDetailsBillListVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRepoortCreditEmailBillDetailsBillListVC.h"
#import "ReportCreditEmailBillDetailBillCell.h"
#import "ReportCreditEmailBillDetailfenqiCell.h"
#import "reportCreditBillModel.h"

#import "ReportCreditEmailBillDetailBillHeader.h"
#import "YJCreditCardMonthBillCell.h"

@interface YJRepoortCreditEmailBillDetailsBillListVC ()

@end

@implementation YJRepoortCreditEmailBillDetailsBillListVC
{
    ReportCreditEmailBillDetailBillHeader *_headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

    [self creatUI];
    
}

#pragma mark - 创建UI
- (void)creatUI {
    
    switch (self.detailType) {
        case  RepoortCreditEmailBillDetailsTypeEver:{//分期
            self.title = @"账单分期";
            if (!_fenqiData && !_fenqiData.count) {
                self.tableView.delegate = nil;
                self.tableView.dataSource = nil;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.tableView.backgroundColor = RGB_pageBackground;
                [self.view addSubview:[YJNODataView NODataView:NODataTypeRedNormal]];
                return;
            }
            
            
            break;
            
        }case RepoortCreditEmailBillDetailsTypeMonth:{//月份
            self.title = [[_reportCreditBillChangeInfo.statementMonth DateString_Year_Month_Day] stringByAppendingString:@"账单"];
            
            if (!_reportCreditBillChangeInfo) {
                self.tableView.delegate = nil;
                self.tableView.dataSource = nil;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.tableView.backgroundColor = RGB_pageBackground;
                [self.view addSubview:[YJNODataView NODataView:NODataTypeRedNormal]];
                return;
            }
            
//            ReportCreditEmailBillDetailBillHeader *headerView = [ReportCreditEmailBillDetailBillHeader reportCreditEmailBillDetailBillCellHeader];
//            headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 265);
//            headerView.model = _reportCreditBillChangeInfo;
//            self.tableView.tableHeaderView = headerView;
            
            [self setupHeaderView];
            break;
            
        }default:
            break;
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.estimatedRowHeight = 213;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    
//    [self.tableView reloadData];
}


- (void)setupHeaderView {
    
    ReportCreditEmailBillDetailBillHeader *headerView = [ReportCreditEmailBillDetailBillHeader reportCreditEmailBillDetailBillCellHeader];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 265);
    headerView.model = _reportCreditBillChangeInfo;
    self.tableView.tableHeaderView = headerView;
    
    
}




#pragma mark--UITableViewDataSource

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    // 月份
//    if (self.detailType == RepoortCreditEmailBillDetailsTypeMonth && _headerView) {
//        return _headerView;
//    }
//    
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    header.backgroundColor = RGB_pageBackground;
//    return header;
//    
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 月份
    if (self.detailType == RepoortCreditEmailBillDetailsTypeMonth) {
        return _reportCreditBillChangeInfo.details.count;
        
    }
    
    return _fenqiData.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.detailType) {
        case RepoortCreditEmailBillDetailsTypeMonth://月份
        {
//            ReportCreditEmailBillDetailBillCell *cell = [ReportCreditEmailBillDetailBillCell reportCreditEmailBillDetailBillCellWithTableView:tableView];
//            cell.cellmodel = _reportCreditBillChangeInfo.details[indexPath.row];
//            if (indexPath.row == _reportCreditBillChangeInfo.details.count-1) {
//                reportCreditBilldetails *model = _reportCreditBillChangeInfo.details[indexPath.row] ;
//                CGFloat h =[ReportCreditEmailBillDetailBillCell cellHelight:model.summary];
//                [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, h-0.5, SCREEN_WIDTH, 0.7) Super:cell.contentView]];
//            }
//            return cell;
            YJCreditCardMonthBillCell *cell = [YJCreditCardMonthBillCell creditCardMonthBillCelWithTableView:tableView];
            cell.cellmodel = _reportCreditBillChangeInfo.details[indexPath.row];
            
            if (indexPath.row == _reportCreditBillChangeInfo.details.count - 1) {
                cell.bottomLine.hidden = NO;
            } else {
                cell.bottomLine.hidden = YES;
            }
            return cell;
            
            break;
        }case RepoortCreditEmailBillDetailsTypeEver:// 分期
        {
            ReportCreditEmailBillDetailfenqiCell *cell = [ReportCreditEmailBillDetailfenqiCell reportCreditEmailBillDetailfenqiCellWithTableView:tableView];
            cell.model = _fenqiData[indexPath.row];
            cell.coinSign = _reportCreditBillChangeInfo.currency;
            if (indexPath.row == _fenqiData.count-1) {
                [cell addSubview:[JFactoryView JLineWith:CGRectMake(0, cell.height-0.5, SCREEN_WIDTH, 0.7) Super:cell.contentView]];
            }
            return cell;
            break;
        }default:
            break;
    }
    
    return nil;
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str;
    switch (self.detailType) {
        case RepoortCreditEmailBillDetailsTypeMonth:// 180 正常
        {
//            if (_reportCreditBillChangeInfo.details) {
//                reportCreditBilldetails *model = _reportCreditBillChangeInfo.details[indexPath.row] ;
//                str = model.summary; 
//            }
//            return [ReportCreditEmailBillDetailBillCell cellHelight:str];
            
            reportCreditBilldetails *cellmodel = _reportCreditBillChangeInfo.details[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:cellmodel keyPath:@"cellmodel" cellClass:[YJCreditCardMonthBillCell class] contentViewWidth:[self cellContentViewWith]];
            
            break;
        }case RepoortCreditEmailBillDetailsTypeEver://
        {
            return 215;
            break;
        }default:
            break;
    }
    
    
    return 0;
    
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
