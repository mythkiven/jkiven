//
//  YJTaoBaoAddressesVC.m
//  CreditPlatform
//
//  Created by yj on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoAddressesVC.h"
#import "YJTaoBaoDeliveryAddressCell.h"
@interface YJTaoBaoAddressesVC ()

@end

@implementation YJTaoBaoAddressesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.rowHeight = 150;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if (self.addresses.count == 0) {
        [self.view addSubview:[YJNODataView NODataView]];
    } else {
        [self setupFooterNODataView];
    }
    

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
    return self.addresses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTaoBaoDeliveryAddressCell *cell = [YJTaoBaoDeliveryAddressCell taoBaoDeliveryAddressCellWithTableView:tableView];
    cell.addressModel = self.addresses[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTaoBaoAddresses *addressModel = self.addresses[indexPath.row];
    
    CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-90, MAXFLOAT) Content:addressModel.address font:Font15];
    CGFloat h = (size.height <= 20) ? 20 :size.height;

    if (h > 20) {
        return 150 + h+5 -10;
    }
    
    return 150+10;
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
