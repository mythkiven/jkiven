//
//  YJOnlineRechargeAmountVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJOnlineRechargeAmountVC.h"
#import "YJOnlineRechargeTypeVC.h"
@interface YJOnlineRechargeAmountVC ()<UITextFieldDelegate>

/**
 *  输入金额
 */
@property (weak, nonatomic) IBOutlet UITextField *amountTf;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation YJOnlineRechargeAmountVC
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线充值";
    self.sureBtn.layer.cornerRadius = 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.amountTf.font = [UIFont boldSystemFontOfSize:25];
    self.sureBtn.enabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_amountTf];

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)textViewTextDidChange:(NSNotification *)noti {
    if ([_amountTf.text intValue] < 500) {
        _sureBtn.enabled = NO;
    } else {
        _sureBtn.enabled = YES;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.amountTf becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.amountTf resignFirstResponder];
    
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    
    if ([self.amountTf.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入充值金额"];
        return;
    }
    
    
    
//    float amount = [self.amountTf.text floatValue];

//#warning -----测试充值后打开

 int amount = [self.amountTf.text intValue];
 
 if (amount < 500) {
 [self.view makeToast:@"最小充值金额为500元"];
 return;
 }
 
 if (amount > 200000) {
 [self.view makeToast:@"最大充值金额为20万元"];
 return;
 }


    YJOnlineRechargeTypeVC *vc = [[YJOnlineRechargeTypeVC alloc] init];
    vc.amount = [NSString stringWithFormat:@"%d",amount];
    
//    vc.amount = [NSString stringWithFormat:@"%.2f",amount];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mrak--UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (([string isEqualToString:@"0"]||[string isEqualToString:@"."]) && NSEqualRanges(range, NSMakeRange(0, 0))) {
        return NO;
    }
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
//    MYLog(@"-------%@",newStr);
    
    if (newStr.length>6) {
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
