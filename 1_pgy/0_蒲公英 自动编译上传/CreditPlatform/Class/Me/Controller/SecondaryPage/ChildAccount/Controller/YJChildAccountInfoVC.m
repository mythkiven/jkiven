//
//  YJChildAccountInfoVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountInfoVC.h"
#import "YJChildAccountManagerCell.h"
#import "YJChildAccountListModel.h"
#import "YJChildAccountInfoView.h"
#import "YJChildAccountUpdateVC.h"
#import "YJAlertView.h"
@interface YJChildAccountInfoVC ()
{
    NSArray *_optionTitles;
    YJChildAccountInfoView *_headerView;
    
    __block int _status;
    
    UIView *_bg;
    
    UIView *_disableView;
    
    BOOL _isUpdate;
    
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UIView *midLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteBtnWidth;

@end

@implementation YJChildAccountInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"子账户管理";
    self.tableView.rowHeight = 45;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 45, 0);
//    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.backgroundColor = RGB_pageBackground;
//    self.tableView.alwaysBounceVertical = YES;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    // 1：可用  2：禁用
    _status = [self.childAccountModel.operatorStatus intValue];

    
    [self setupHeaderViewWithStatus:_status];
    
    if (_status == 1) {
        _optionTitles = @[@"修改名称", @"修改密码"];
        self.deleteBtnWidth.constant = SCREEN_WIDTH*.5;
    
    } else if (_status == 2){
        _optionTitles = @[@"解除禁用"];
        
        self.deleteBtnWidth.constant = SCREEN_WIDTH;
        self.midLine.hidden = YES;
        
    }
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(clcikBackBtn)];
    
    
}

- (void)clcikBackBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (!_isUpdate) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    
    
}

- (void)setupHeaderViewWithStatus:(int)status {
    
    CGFloat headerViewY = 0;
    CGFloat bgH = 0;
    
    if (!_bg) {
        _bg = [[UIView alloc] init];
    }
    
    if (!_headerView) {
        _headerView = [YJChildAccountInfoView childAccountInfoView];
    }
    _headerView.nameLB.text = self.childAccountModel.name;
    _headerView.accountLB.text = self.childAccountModel.fullName;

    CGFloat maxW = SCREEN_WIDTH - kMargin_15*3 - 40;
    CGFloat nameLbH = [_headerView.nameLB heightOfLabelMaxWidth:maxW];
    CGFloat headerH = 0;
    if (nameLbH > 30) {
        _headerView.nameHeightConstraint.constant = nameLbH;
        headerH = 115;
    } else {
        _headerView.nameHeightConstraint.constant = 22;
        headerH = 94;
    }
    
    
    if (status == 1) {
        bgH = headerH + 10;
        _bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, bgH);

    } else if (status == 2){
        headerViewY = 45;
        bgH = headerH + 10 + 45;
        _bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, bgH);

        if (!_disableView) {
            _disableView = [self disableView];
        }
        [_bg addSubview:_disableView];
    }
    

    if (status == 1) {
        _headerView.nameLB.textColor = RGB_black;
        _headerView.accountLB.textColor = RGB_black;
        
    } else if (status == 2){
        _headerView.nameLB.textColor = RGB_grayNormalText;
        _headerView.accountLB.textColor = RGB_grayNormalText;
    }
    
    
    _headerView.frame = CGRectMake(0, headerViewY, SCREEN_WIDTH, headerH);

    [_bg addSubview:_headerView];
    
    self.tableView.tableHeaderView = _bg;
    
    
    
    _headerView.nameLB.textAlignment = NSTextAlignmentRight;
    
    
}


/**
 已禁用标签
 */
- (UIView *)disableView {
    UIView *disableView = [[UIView alloc] init];
    disableView.backgroundColor = RGB_white;
    UIView *line = [UIView separationLine];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    [disableView addSubview:line];
    
    UIButton *disBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    disBtn.userInteractionEnabled = NO;
    disBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    disBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [disBtn setImage:[UIImage imageNamed:@"icon_ChildAccount_disable"] forState:(UIControlStateNormal)];
    [disBtn setTitle:@"已禁用" forState:(UIControlStateNormal)];
    [disBtn setTitleColor:RGB_redText forState:(UIControlStateNormal)];
    disBtn.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 45);
    [disableView addSubview:disBtn];
    disableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    return disableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _optionTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJChildAccountManagerCell *cell = [YJChildAccountManagerCell childAccountManagerCellWithTableView:tableView];
    cell.title = _optionTitles[indexPath.row];
    
    if (indexPath.row == _optionTitles.count - 1) {
        cell.bottomLine.hidden = NO;
    } else {
        cell.bottomLine.hidden = YES;
    }
    
    return cell;
}

#pragma mark - Table view data delegate
#pragma mark - 修改名称/密码
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJChildAccountManagerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.title isEqualToString:@"解除禁用"]) {
        YJAlertView *alertView = [[YJAlertView alloc] initWithTitle:@"解除禁用" message:@"解除禁用后，子账号将恢复服务"];
        alertView.titleLB.textAlignment = NSTextAlignmentCenter;
        alertView.messageLB.textAlignment = NSTextAlignmentCenter;
        [alertView addButtonWithTitle:@"取消"];
        [alertView addButtonWithTitle:@"解除"];
        alertView.handler = ^(int index) {
            switch (index) {
                case 0:
                    
                    break;
                case 1://openUserOperator
                    
                    [self openUserOperator];
                    break;
                default:
                    break;
            }
        };
        [alertView show];
        
    } else { // 修改名称、密码
        
        YJChildAccountUpdateVC *updateVc = [[YJChildAccountUpdateVC alloc] init];
        
        updateVc.childAccountModel = self.childAccountModel;
        updateVc.optionName = cell.title;
        
        __weak typeof(self) weakSelf = self;

        if ([cell.title isEqualToString:@"修改名称"]) { // 修改名称成功回调
            updateVc.updateNameSuccess = ^(NSString *newName) {
//                _headerView.nameLB.text = newName;
                
                weakSelf.childAccountModel.name = newName;
                
                [weakSelf setupHeaderViewWithStatus:1];
                
                _isUpdate = YES;
                
                
            };
        } else  if ([cell.title isEqualToString:@"修改密码"]) {// 修改密码成功回调
            updateVc.updatePasswordSuccess = ^(NSString *newPW) {
                
                _isUpdate = YES;
            };
        }
        
     
        [self.navigationController pushViewController:updateVc animated:YES];


        

    }
    
    
    
}

#pragma mark---点击删除
- (IBAction)deleteBtnClcik:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;

    YJAlertView *alertView = [[YJAlertView alloc] initWithTitle:@"删除子账号" message:@"删除后，子账号将无法恢复"];
    alertView.titleLB.textAlignment = NSTextAlignmentCenter;
    alertView.messageLB.textAlignment = NSTextAlignmentCenter;
    [alertView addButtonWithTitle:@"取消"];
    [alertView addButtonWithTitle:@"确定删除"];
    alertView.handler = ^(int index) {
        switch (index) {
            case 0:
                
                break;
            case 1:
                
                [weakSelf childAccountOption:urlJK_deleteUserOperator];
                break;
            default:
                break;
        }
    };
    [alertView show];

}

#pragma mark---点击禁用
- (IBAction)closeBtnClcik:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    
    YJAlertView *alertView = [[YJAlertView alloc] initWithTitle:@"禁用子账号" message:@"禁用后，子账号将无法查询征信服务"];
    alertView.titleLB.textAlignment = NSTextAlignmentCenter;
    alertView.messageLB.textAlignment = NSTextAlignmentCenter;
    [alertView addButtonWithTitle:@"取消"];
    [alertView addButtonWithTitle:@"确定禁用"];
    alertView.handler = ^(int index) {
        switch (index) {
            case 0:
                
                break;
            case 1:
                
                [weakSelf childAccountOption:urlJK_closeUserOperator];
                break;
            default:
                break;
        }
    };
    [alertView show];
    
}

#pragma mark---点击解除禁用
- (void)openUserOperator {
    [self childAccountOption:urlJK_openUserOperator];
}

#pragma mark---子账号《解除禁用、删除、禁用》网络请求
- (void)childAccountOption:(NSString *)option {
    NSDictionary *dict = @{@"method" : option,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_1,
                           @"id":self.childAccountModel.id
                           };
    __weak typeof(self) weakSelf = self;
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,option] params:dict success:^(id obj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([obj[@"code"] isEqualToString:@"0000"]) { // 操作成功
                
                _isUpdate = YES;
                //刷新UI
                [weakSelf refreshUIWithOption:option];
                
                
            } else {
                [weakSelf.view makeToast:obj[@"msg"]];
            }
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *tip = nil;
            if ([option isEqualToString:urlJK_openUserOperator]) {//解除禁用
                tip = @"子账号解除禁用失败，请重试！";
                
            } else if ([option isEqualToString:urlJK_deleteUserOperator]) {//删除
                 tip = @"子账号删除失败，请重试！";
            } else if ([option isEqualToString:urlJK_closeUserOperator]) {//禁用
                 tip = @"子账号禁用失败，请重试！";
            }
            [weakSelf.view makeToast:tip];
            
        });
    }];
    
}



#pragma mark--刷新UI
- (void)refreshUIWithOption:(NSString *)option {
    NSString *tip = nil;
    if ([option isEqualToString:urlJK_openUserOperator]) {//解除禁用
        [self openUserOperatorRefreshUI];
        tip = @"子账号解除禁用成功";
    } else if ([option isEqualToString:urlJK_deleteUserOperator]) {//删除
        [self deleteUserOperatorRefreshUI];
        tip = @"子账号删除成功";
    } else if ([option isEqualToString:urlJK_closeUserOperator]) {//禁用
        [self closeUserOperatorRefreshUI];
        tip = @"子账号禁用成功";
    }
    
    [self.view makeToast:tip];

    
}

#pragma mark--解除禁用成功，刷新UI
- (void)openUserOperatorRefreshUI {
    
    [self setupHeaderViewWithStatus:1];
    _optionTitles = @[@"修改名称", @"修改密码"];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.deleteBtnWidth.constant = SCREEN_WIDTH*.5;
        self.midLine.hidden = NO;
    }];
}

#pragma mark--禁用成功，刷新UI
- (void)closeUserOperatorRefreshUI {
    
    [self setupHeaderViewWithStatus:2];
    _optionTitles = @[@"解除禁用"];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.deleteBtnWidth.constant = SCREEN_WIDTH;
        self.midLine.hidden = YES;
    }];
}

#pragma mark--删除成功，刷新UI
- (void)deleteUserOperatorRefreshUI {
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:.25];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
