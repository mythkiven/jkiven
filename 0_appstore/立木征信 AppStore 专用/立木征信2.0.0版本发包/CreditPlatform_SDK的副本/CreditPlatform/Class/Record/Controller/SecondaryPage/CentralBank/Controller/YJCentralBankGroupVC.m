//
//  YJCentralBankGroupVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankGroupVC.h"
#import "YJCentralBankLableCell.h"
#import "YJCentralBankModel.h"

@interface YJCentralBankGroupVC ()

@end

@implementation YJCentralBankGroupVC

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

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YJCentralBankDetail *det = self.dataArray[section];
    return  det.item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJCentralBankLableCell *cell = [YJCentralBankLableCell centralBankLableCell:tableView];
    YJCentralBankDetail *det = self.dataArray[indexPath.section];
    cell.content = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,det.item[indexPath.row]];
    
    if (indexPath.row == 0) { // 上分割线
        UIView *separateLine1 = [[UIView alloc] init];
        separateLine1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        separateLine1.backgroundColor = RGB_grayLine;
        [cell.contentView addSubview:separateLine1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJCentralBankDetail *det = self.dataArray[indexPath.section];

    NSString *str = det.item[indexPath.row];
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [self.tableView cellHeightForIndexPath:indexPath model:str keyPath:@"content" cellClass:[YJCentralBankLableCell class] contentViewWidth:[self cellContentViewWith]];
    
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    YJCentralBankDetail *det = self.dataAray[section];
//    return det.headTitle;
//}




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
    YJCentralBankDetail *det = self.dataArray[section];
    UILabel *lb = [[UILabel alloc] init];
    lb.text = det.headTitle;
    lb.textColor = RGB_grayNormalText;
    lb.backgroundColor = [UIColor clearColor];
    lb.numberOfLines = 0;
    lb.font = Font15;
    CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) Content:det.headTitle font:Font15];
    lb.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, size.height+17);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, size.height+17)];
    bgView.backgroundColor = RGB_pageBackground;
    [bgView addSubview:lb];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YJCentralBankDetail *det = self.dataArray[section];
    return [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) Content:det.headTitle font:Font15].height + 17;
}



@end
