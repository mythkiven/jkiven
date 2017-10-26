//
//  ReportCompanyInfoBusinessPublishVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCompanyInfoBusinessPublishVC.h"

@interface ReportCompanyInfoBusinessPublishVC ()

@end

@implementation ReportCompanyInfoBusinessPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case ReportCompanyInfoBusinessPublishTpyeLogin :{ // 登记信息
            self.title = @"登记信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeRecord :{ // 备案信息
            self.title = @"备案信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeMoveProperty :{ // 动产抵押
            self.title = @"动产抵押登记信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeStock :{ // 股权出质
            self.title = @"股权出质登记信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeAdministrationPunish :{ // 行政处罚
            self.title = @"行政处罚信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeOperateError :{ // 经营异常
            self.title = @"经营异常信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeBreakLaw :{ // 严重违法
            self.title = @"严重违法信息";
            break;
            
        }case ReportCompanyInfoBusinessPublishTpyeCheck :{ // 抽查检查
            self.title = @"抽查检查信息";
            break;
            
        }default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
