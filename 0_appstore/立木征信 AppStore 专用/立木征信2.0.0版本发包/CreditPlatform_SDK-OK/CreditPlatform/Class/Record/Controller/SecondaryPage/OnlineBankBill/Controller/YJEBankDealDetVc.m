//
//  YJEBankDealDetVc.m
//  CreditPlatform
//
//  Created by yj on 2016/11/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJEBankDealDetVc.h"
#import "YJNetBankBillDealDetCell.h"
@interface YJEBankDealDetVc ()

@end

@implementation YJEBankDealDetVc
static NSString *eBankDealDetVcCellID = @"YJNetBankBillDealDetCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.rowHeight = 210;
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"交易明细";
    
    [self.tableView registerClass:[YJNetBankBillDealDetCell class] forCellReuseIdentifier:eBankDealDetVcCellID];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YJNetBankBillDealDetCell" bundle:nil] forCellReuseIdentifier:eBankDealDetVcCellID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.billDets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJNetBankBillDealDetCell *cell = [tableView dequeueReusableCellWithIdentifier:eBankDealDetVcCellID forIndexPath:indexPath];
    
    
    cell.eBankBill = self.billDets[indexPath.row];
    
    return cell;
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
