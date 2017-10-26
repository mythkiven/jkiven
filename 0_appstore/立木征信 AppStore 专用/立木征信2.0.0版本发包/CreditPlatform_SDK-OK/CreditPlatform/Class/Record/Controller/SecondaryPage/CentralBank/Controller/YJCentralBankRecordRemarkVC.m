//
//  YJCentralBankRecordRemarkVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankRecordRemarkVC.h"
#import "YJCentralBankLableCell.h"
@interface YJCentralBankRecordRemarkVC ()

@end

@implementation YJCentralBankRecordRemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    
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
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJCentralBankLableCell *cell = [YJCentralBankLableCell centralBankLableCell:tableView];

    cell.content = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB_grayLine;
        line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:line];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = self.dataArray[indexPath.section];
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [self.tableView cellHeightForIndexPath:indexPath model:str keyPath:@"content" cellClass:[YJCentralBankLableCell class] contentViewWidth:[self cellContentViewWith]];
    
    
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



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *lb = [[UILabel alloc] init];
    lb.text = [NSString stringWithFormat:@"备注%ld",section+1];
    lb.textColor = RGB_grayNormalText;
    lb.backgroundColor = [UIColor clearColor];
    lb.numberOfLines = 0;
    lb.font = Font15;

    lb.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 35);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    bgView.backgroundColor = RGB_pageBackground;
    [bgView addSubview:lb];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
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
