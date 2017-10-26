//
//  CommonSearchVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXCreditBillNativeVC.h"


// 键盘延时弹出时间:有些特殊键盘加载时间较长,如果是页面没有完全弹出之前,加载键盘,会卡顿.
#define LM_TextfiledPopDelay 0.5

@interface LMZXCreditBillNativeVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSString *_emailType;
    
}

@end



@implementation LMZXCreditBillNativeVC


#pragma mark - 生命周期
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 监听 textfile 的状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    
    // 确认按钮 点击事件添加
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 主要 UIView 在父控制器中创建
    
}





- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isVCOut = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isVCOut = NO;
}




#pragma mark - tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 统一加载的 plist cell 配置
    return self.commonCellData.count;
}

// 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 通用 cell 创建
    LMZXCommonSearchCell *cell = [LMZXCommonSearchCell initCommonCellWith:tableView];
    cell.searchItemType = self.searchItemType;
    cell.model = self.commonCellData[indexPath.row];
    switch (self.type) {
        case LMZXCreditCardBillMailType163 :
            cell.creditMail = @"@163.com";
            _emailType = @"@163.com";
            break;
        case LMZXCreditCardBillMailType126 :
            cell.creditMail = @"@126.com";
            _emailType = @"@126.com";
            break;
        case LMZXCreditCardBillMailType139 :
            cell.creditMail = @"@139.com";
            _emailType = @"@139.com";
            break;
        case LMZXCreditCardBillMailTypesina :
            cell.creditMail = @"@sina.com";
            _emailType = @"@sina.com";
            break;
        case LMZXCreditCardBillMailTypeQQ :
            cell.creditMail = @"@qq.com";
            _emailType = @"@qq.com";
            break;
        default:
            break;
    }
    
    
    // 键盘响应
    if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
//        [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:LM_TextfiledPopDelay];
        [cell.textField becomeFirstResponder];
    }else{
        [cell.textField canBecomeFirstResponder];
    }
    // 键盘类型
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    cell.textField.clearsOnBeginEditing = NO;
    
    return cell;
}
// 选中 cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 无此事件
    
}


#pragma mark - 点击查询报告
- (void)didClickedSearch{
    
    [self.view endEditing:YES];
    
    // 校验
    if (![self verificateData ]) {
        return;
    }
    [self scrollViewWillBeginDragging:self.tableView];
    
    

    
    
    LMZXQueryInfoModel *model = [[LMZXQueryInfoModel alloc]init];
    [model setDataCreditBillWithUserName:[self.firstTextField stringByAppendingString:_emailType] password:self.twoTextField accessType:@"sdk" cookie:@"" idNO:@"idcard" idName:@"idname" loginType:@"normal" bankCode:@"ALL" billType:@"email"];
    
    self.lmQueryInfoModel = model;
    LMZXLoadingReportBaseVC *loadingVc = [[LMZXLoadingReportBaseVC alloc] init];
    loadingVc.lmQueryInfoModel = model;
    loadingVc.searchType = self.searchItemType;
    loadingVc.creditCardMailType = self.type;
    
    [self.navigationController pushViewController:loadingVc animated:YES];
    
    
    
}


#pragma mark  校验格式
-(BOOL)verificateData {
    //    LMLog(@"格式校验：first:%@-twO:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
    
    
    if (!self.firstTextField.length) {
        [self.view makeToast:@"请输入账号" ifSucess:NO];
        return NO;
    } else if (!self.twoTextField.length) {
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    
    //协议
    if (!self.btnSelected.selected) {
        [self.view makeToast:@"不同意协议无法进行下一步" ifSucess:NO];
        return NO;
    }
    
    
    return YES;
}




#pragma mark - 键盘处理
-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}

#pragma  mark textfiled 结束编辑
- (void)textFieldTextDidEndEditingQ:(NSNotification *)noti {
    if (self.isVCOut) {
        return;
    }
    
    [super textFieldTextDidEndEditingSuper:noti];
    
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != LM_TagCommonSearchCellTextfiled) {
        return;
    }
    
    
    LMZXCommonSearchCell  *editeCell  = (LMZXCommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    
    if ((self.searchItemType == LMZXSearchItemTypeOperators)&&(indexPath.row == 0)) {
        return;
    }
    
    [editeCell endEditing:YES];
    
}





//#pragma  mark  textfiled 开始编辑
//
//- (void)textFieldTextDidBeginEditingQ:(NSNotification *)noti {
//
//}
//#pragma mark textfiled 改变
//-(void)textFiledEditChangedQ:(NSNotification *)obj{
//
//}





#pragma mark - 其他通用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

-(NSArray *)cellsForTableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    NSMutableArray *cells = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [cells addObject:[tableView cellForRowAtIndexPath:indexPath]];
        }
    }
    return cells;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end

