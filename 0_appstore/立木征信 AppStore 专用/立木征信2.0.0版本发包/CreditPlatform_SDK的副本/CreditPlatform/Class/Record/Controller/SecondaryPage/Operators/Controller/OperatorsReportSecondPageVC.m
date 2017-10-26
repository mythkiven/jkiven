//
//  OperatorsReportSecondPageVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "OperatorsReportSecondPageVC.h"

#import "ORDetailTypeBillCell.h"
#import "ORDetailTypeOperationCell.h"
#import "ORDetailTypeNetworkCell.h"
#import "ORDetailTypeTenMostCallCell.h"
#import "ORDetailTypeCallListCell.h"
#import "ORDetailTypeMessageCell.h"

#import "OperationModel.h"

@interface OperatorsReportSecondPageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger rowH;
}
@end

@implementation OperatorsReportSecondPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.itemType) {
        case OperatorsReportDetailTypeBill://账单信息
        {
            self.title = @"近6个月账单信息";
            rowH = 120;
            break;
        }case OperatorsReportDetailTypeOperation://办理业务
        {
            self.title = @"近6个月办理业务";
            rowH = 125;
            break;
        }case OperatorsReportDetailTypeNetwork://网络
        {
            self.title = @"近6个月上网数据";
             rowH = 125;
            break;
        }case OperatorsReportDetailTypeTenMostCall://前10通话
        {
            self.title = @"近6月前10通话记录";
            rowH = 240;
            break;
        }case OperatorsReportDetailTypeCallList://通话数据
        {
            self.title = @"近6个月通话详单记录";
            rowH = 240;
            break;
        }case OperatorsReportDetailTypeMessage://短信
        {
            self.title = @"近6个月短信记录";
            rowH = 210;
            break;
        }case OperatorsReportDetailTypeMore://更多
        {
            break;
            
        }default:
            break;
    }
    

    self.tableView.rowHeight = rowH+10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.backgroundColor = RGB_pageBackground;
    
    if (self.data.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    } else {
        [self setupFooterNODataView];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
//    if (!self.data.count) {
//        [self.view makeToast:@"暂无数据"];
//    }
//    if (((rowH+10)*self.data.count)>=SCREEN_HEIGHT) {
//        [self setupFooterNODataView];
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celll;
    
    switch (self.itemType) {
        case OperatorsReportDetailTypeBill://账单信息
        {
            ORDetailTypeBillCell *cell = [ORDetailTypeBillCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            
            break;
        }case OperatorsReportDetailTypeOperation://办理业务
        {
            ORDetailTypeOperationCell *cell =[ORDetailTypeOperationCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case OperatorsReportDetailTypeNetwork://网络
        {
            ORDetailTypeNetworkCell *cell = [ORDetailTypeNetworkCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case OperatorsReportDetailTypeTenMostCall://前10通话
        {
            ORDetailTypeTenMostCallCell *cell = [ORDetailTypeTenMostCallCell subjectCellWithTabelView:tableView];
            cell.modelNew = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case OperatorsReportDetailTypeCallList://通话数据
        {
            ORDetailTypeCallListCell *cell = [ORDetailTypeCallListCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case OperatorsReportDetailTypeMessage://短信
        {
            ORDetailTypeMessageCell *cell = [ORDetailTypeMessageCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case OperatorsReportDetailTypeMore://更多
        {
            break;
            
        }default:
            break;
    }
    
    
    return celll;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (self.itemType) {
//        case OperatorsReportDetailTypeBill://账单信息
//        {
//            rowH = 120;
//            return 120;
//            
//            break;
//        }case OperatorsReportDetailTypeOperation://办理业务
//        {
//            rowH = 125;
//            return 125;
//            break;
//        }case OperatorsReportDetailTypeNetwork://网络
//        {
//            rowH = 125;
//            return 125;
//            break;
//        }case OperatorsReportDetailTypeTenMostCall://前10通话
//        {
//            rowH = 82;
//            return 82;
//            break;
//        }case OperatorsReportDetailTypeCallList://通话数据
//        {
//            rowH = 240;
//            return 240;
//            break;
//        }case OperatorsReportDetailTypeMessage://短信
//        {
//            rowH = 210;
//            return 210;
//            break;
//        }case OperatorsReportDetailTypeMore://更多
//        {
//            break;
//            
//        }default:
//            break;
//    }
//    return 0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}

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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 0;
    
}
@end


















