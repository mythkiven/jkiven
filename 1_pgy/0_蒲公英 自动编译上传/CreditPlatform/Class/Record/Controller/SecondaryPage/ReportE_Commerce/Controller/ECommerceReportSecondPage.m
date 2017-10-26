//
//  ECommerceReportSecondPage.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ECommerceReportSecondPage.h"

#import "ECommerceReportDetailTypeAddressCell.h"
#import "ECommerceReportDetailTypeCardCell.h"
#import "ECommerceReportDetailTypeOrderListCell.h"

#import "ECommerceReportDetailTypeStatisticsCell.h"

@interface ECommerceReportSecondPage ()
{
    NSInteger rowH;
}
@end

@implementation ECommerceReportSecondPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电商报告";
    switch (self.itemType) {
        case ECommerceReportDetailTypeCard://银行卡
        {
            rowH = 125;
            self.title = @"绑定银行卡信息";
            break;
        }case ECommerceReportDetailTypeAddress://地址
        {
            rowH = 115;
            self.title = @"地址信息";
            break;
        }case ECommerceReportDetailTypeOrderList://订单
        {
            rowH = 290;
            self.title = @"订单记录";
            break;
        }case ECommerceReportDetailTypeCostBarChart://柱状图
        {
            break;
            
        }case ECommerceReportDetailTypeStatistics://消费统计
        {
            rowH = 230;
            self.title = @"消费统计";
            break;
            
        }default:
            break;
    }
    
    rowH = rowH+10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.frame = CGRectMake(0, -10, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.backgroundColor = RGB_pageBackground;
    
    if (self.data.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    }
//    else {
//        [self setupFooterNODataView];
//    }
    
}
//-(void)viewWillAppear:(BOOL)animated{
//
//}
//-(void)viewDidAppear:(BOOL)animated{
////    if (!self.data.count) {
////        [self.view makeToast:@"暂无数据"];
////    }
////    if ((self.tableView.rowHeight*self.data.count)>=SCREEN_HEIGHT) {
////        [self setupFooterNODataView];
////    }
//    
//}
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
        case ECommerceReportDetailTypeCard ://银行卡
        {
            ECommerceReportDetailTypeCardCell *cell = [ECommerceReportDetailTypeCardCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            
            break;
        }case ECommerceReportDetailTypeAddress://地址
        {
            ECommerceReportDetailTypeAddressCell *cell =[ECommerceReportDetailTypeAddressCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case ECommerceReportDetailTypeOrderList://订单
        {
            ECommerceReportDetailTypeOrderListCell *cell = [ECommerceReportDetailTypeOrderListCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor =[UIColor clearColor];
//            cell.backgroundColor =[UIColor clearColor];
            return cell;
            break;
        }case ECommerceReportDetailTypeCostBarChart://柱状图
        {
            
            break;
            
        }case ECommerceReportDetailTypeStatistics://消费统计
        {
            ECommerceReportDetailTypeStatisticsCell *cell = [ECommerceReportDetailTypeStatisticsCell subjectCellWithTabelView:tableView];
            cell.model = _data[indexPath.row];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            cell.contentView.backgroundColor =[UIColor clearColor];
            //            cell.backgroundColor =[UIColor clearColor];
            return cell;
            
            
            break;
            
        }default:
            break;
    }
    
    
    
    
    return celll;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.itemType) {
        case ECommerceReportDetailTypeAddress://地址
        {
            JDaddressInfoModel *addressModel = _data[indexPath.row];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 4;
            CGFloat MAXW = SCREEN_WIDTH - 90-15;
            CGFloat h= [addressModel.address
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            
            if (h > 35) {
                return 115+ h-15;
            }
            
            return 115;
            break;
        }case ECommerceReportDetailTypeOrderList://订单
        {
            
            JDorderDetailModel *addressModel = _data[indexPath.row];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 4;
            CGFloat MAXW = SCREEN_WIDTH - 105-15;
            CGFloat h= [addressModel.consigneeAddr
                        boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            
            if (h > 15) {
                return 290+ h-15;
            }
            
            return 290;
            
            break;
        }
        case ECommerceReportDetailTypeCard://银行卡
        {
            return rowH;
            break;
        }case ECommerceReportDetailTypeCostBarChart://柱状图
        {
            break;
            
        }case ECommerceReportDetailTypeStatistics://消费统计
        {
            return rowH;
            break;
            
        }
        default:
            break;
    }
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.data.count == 0) {
        
    }else{
        UILabel *noDataLB = [[UILabel alloc] init];
        noDataLB.text = @"没有更多数据了";
        noDataLB.textAlignment = NSTextAlignmentCenter;
        noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        noDataLB.font = Font15;
        noDataLB.textColor = RGB_grayPlaceHoldText;
        UIView *bgView = [[UIView alloc] init];
        [bgView addSubview:noDataLB];
        return bgView;
    }
    return nil;
    
}

//- (void)setupFooterNODataView {
//    UILabel *noDataLB = [[UILabel alloc] init];
//    noDataLB.text = @"没有更多数据了";
//    noDataLB.textAlignment = NSTextAlignmentCenter;
//    noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
//    noDataLB.font = Font15;
//    noDataLB.textColor = RGB_grayPlaceHoldText;
//    UIView *bgView = [[UIView alloc] init];
//    [bgView addSubview:noDataLB];
//    self.tableView.tableFooterView = bgView;
//}

@end
