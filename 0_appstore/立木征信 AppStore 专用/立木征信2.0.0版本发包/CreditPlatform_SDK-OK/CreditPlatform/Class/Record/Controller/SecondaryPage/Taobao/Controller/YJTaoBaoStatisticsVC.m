//
//  YJTaoBaoStatisticsVC.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoStatisticsVC.h"
#import "YJAddressStatisticsCell.h"
#import "YJMonthStatisticsCell.h"
@interface YJTaoBaoStatisticsVC ()

@end

@implementation YJTaoBaoStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    switch (self.statisticType) {
        case YJTaoBaoStatisticTypeAddress:
        {
//            self.tableView.rowHeight = 180;
            self.title = @"历史消费地址统计";
            if (self.statisticsModel.taobaoAddrStatistics.count == 0 ) {
                [self.view addSubview:[YJNODataView NODataView]];
            } else {
                [self setupFooterNODataView:NO];
            }
            
            break;
        }
        case YJTaoBaoStatisticTypeMonth:
        {
//            self.tableView.rowHeight = 40;
            self.title = @"按月消费数据统计";
            if (self.statisticsModel.taobaoConsuStatistics.count == 0 ) {
                [self.view addSubview:[YJNODataView NODataView]];
            } else {
                [self setupFooterNODataView:YES];
                [self setupHeaderView];
            }
            
            

            break;
        }
        default:
            break;
    }
    

}

- (void)setupHeaderView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_white;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB_lightGray;
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
    [bg addSubview:line];
    
   
    [bg addSubview:[self creatTitleLB:@"月份" index:0]];
     [bg addSubview:[self creatTitleLB:@"消费笔数" index:1]];
     [bg addSubview:[self creatTitleLB:@"消费金额" index:2]];
    self.tableView.tableHeaderView = bg;
    
    
}
// 底部分割线
- (void)setupFooterView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_grayLine;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
    
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = RGB_lightGray;
//    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
//    [bg addSubview:line];
//    
    self.tableView.tableFooterView = bg;
    
}


- (UILabel *)creatTitleLB:(NSString *)title index:(int)index {
    CGFloat lbW = SCREEN_WIDTH / 3;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text =title;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = Font15;
    lb.textColor = RGB_grayNormalText;
    lb.backgroundColor = [UIColor clearColor];
    lb.frame = CGRectMake(lbW * index, 0, lbW, 45);
    
    return lb;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.statisticType == YJTaoBaoStatisticTypeAddress) {
       return self.statisticsModel.taobaoAddrStatistics.count;
    } else if (self.statisticType == YJTaoBaoStatisticTypeMonth) {
        return self.statisticsModel.taobaoConsuStatistics.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.statisticType) {
        case YJTaoBaoStatisticTypeAddress:
        {
            YJAddressStatisticsCell *cell = [YJAddressStatisticsCell addressStatisticsCellWithTableView:tableView];
            cell.addrStatistic = self.statisticsModel.taobaoAddrStatistics[indexPath.row];
            
            return cell;
        }
        case YJTaoBaoStatisticTypeMonth:
        {
            YJMonthStatisticsCell *cell = [YJMonthStatisticsCell monthStatisticsCellWithTableView:tableView];
            cell.monthStatistic = self.statisticsModel.taobaoConsuStatistics[indexPath.row];
            
            return cell;
        }
        default:
            break;
    }
    
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.statisticType == YJTaoBaoStatisticTypeAddress) {
        YJTaobaoAddrStatistic *addrStatistic = self.statisticsModel.taobaoAddrStatistics[indexPath.row];

        CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) Content:addrStatistic.receiveAddress font:Font15];
        CGFloat h = (size.height <= 20) ? 20 :size.height;
        
        if (h > 20) {
            return 180+h+5 -10;
        }
        return 180+10;
    }
    
    return 40;
    
}

- (void)setupFooterNODataView:(BOOL)hasLine {
    
    
    UILabel *noDataLB = [[UILabel alloc] init];
    noDataLB.backgroundColor = [UIColor clearColor];
    noDataLB.text = @"没有更多数据了";
    noDataLB.textAlignment = NSTextAlignmentCenter;
    noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    noDataLB.font = Font15;
    noDataLB.textColor = RGB_grayPlaceHoldText;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = RGB_pageBackground;
    
    if (hasLine) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB_grayLine;
        line.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
        [bgView addSubview:line];
    }

    
    [bgView addSubview:noDataLB];
    
   
    self.tableView.tableFooterView = bgView;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
