//
//  YJCentralBankContentVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/21.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankContentVC.h"
#import "YJCentralBankSearchDetailCell.h"
#import "YJCentralBankCreditRecordCell.h"
#import "YJCentralBankModel.h"
@interface YJCentralBankContentVC ()

@end

@implementation YJCentralBankContentVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat rowH = 0;
    if ([self.det.type isEqualToString:@"个人查询记录明细"]) {
        rowH = 175;
        self.dataArray = self.det.item;

    } else if ([self.det.type isEqualToString:@"机构查询记录明细"]) {
        self.dataArray = self.det.item;
        rowH = 175;
    } else {
        rowH = 116;
    }
    
    self.tableView.rowHeight = rowH;
    MYLog(@"------%ld",self.dataArray.count);
    
    if (self.dataArray.count == 0) {
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
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj = self.dataArray[0];
    
    if ([obj isKindOfClass:[YJCentralBankSearchRecordDetItem class]]) {
        int type = 0;
        if ([self.det.type isEqualToString:@"个人查询记录明细"]) {
            type = YJCentralBankCellTypePerson;
        } else if ([self.det.type isEqualToString:@"机构查询记录明细"]) {
            type = YJCentralBankCellTypeOrganizer;
        }
        // 个人、机构记录查询明细
        YJCentralBankSearchDetailCell *cell = [YJCentralBankSearchDetailCell centralBankSearchDetailCellWithTableView:tableView cellType:(type)];
        MYLog(@"=======%ld",self.dataArray.count);
        cell.centralBankSearchRecordDetItem = self.dataArray[indexPath.row];
        return cell;
        
    } else if ([obj isKindOfClass:[YJCentralBankSummary class]]) {
        YJCentralBankCreditRecordCell *cell = [YJCentralBankCreditRecordCell creditRecordCellWithTabelView:tableView];
        cell.summaryModel = self.dataArray[indexPath.row];
        return cell;
        
    }

    return nil;
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
