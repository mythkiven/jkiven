//
//  YJTaoBaoOrderDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoOrderDetailsVC.h"
#import "YJTaoBaoGoodsDetailVC.h"
#import "YJTaoBaoOrderDetailsCell.h"
@interface YJTaoBaoOrderDetailsVC ()<UIViewControllerPreviewingDelegate>
{
    UILabel *_titleLB;
}
@end

@implementation YJTaoBaoOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.rowHeight = 246;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if (self.orderDetails.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    } else {
        [self setupFooterNODataView];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.orderDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTaoBaoOrderDetailsCell *cell = [YJTaoBaoOrderDetailsCell taoBaoOrderDetailsCellWithTableView:tableView];
    cell.orderDetails = self.orderDetails[indexPath.row];
    
    if (iOS9_OR_LATER) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
            
        }
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTaoBaoOrderDetails *orderDetails = self.orderDetails[indexPath.row];

    CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) Content:orderDetails.taoBaoLogisticsInfo.receiveAddress font:Font15];
    CGFloat h = (size.height <= 20) ? 20 :size.height;
    
    if (h > 20) {
        return 246 + h+5 -10;
    }
    return 246+10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YJTaoBaoGoodsDetailVC *goodsDetailVC = [[YJTaoBaoGoodsDetailVC alloc] init];
    goodsDetailVC.orderDetails = self.orderDetails[indexPath.row];
    
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
    
}
#pragma mark---UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if (self.presentedViewController) {
        return nil;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
    YJTaoBaoGoodsDetailVC *goodsDetailVC = [[YJTaoBaoGoodsDetailVC alloc] init];
    
    goodsDetailVC.orderDetails = self.orderDetails[indexPath.row];

    
    return goodsDetailVC;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
//    YJTaoBaoGoodsDetailVC *goodsDetailVC =  (YJTaoBaoGoodsDetailVC *)viewControllerToCommit;
//    goodsDetailVC.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 60, 0);
//    
//
//    [goodsDetailVC.titleView removeFromSuperview];
    
    
    [self showViewController:viewControllerToCommit sender:self];
    
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
