//
//  OperationSendMsgVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "OperationSendMsgVC.h"
#import "OperatorsReportMainVC.h"
#import "OperatorsDataTool.h"
@interface OperationSendMsgVC ()
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;
@property (weak, nonatomic) IBOutlet UIButton *zcBtn;
- (IBAction)clickedLogin:(UIButton *)sender;

- (IBAction)clickedYZM:(UIButton *)sender;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@end

@implementation OperationSendMsgVC
{
    OperatorsDataTool *_operatorsDataTool;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground;
    self.zcBtn.layer.cornerRadius = 2;
    self.zcBtn.layer.masksToBounds = YES;
    
    self.title = @"验证手机";
    [self.zcBtn setTitle:@"提交，生成报告" forState:UIControlStateNormal];
    
    self.num = 600;
    
    NSString *str =  [_phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.topLabel.text = [NSString stringWithFormat:@"短信验证码已经发送至%@，请注意查收",str];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
    self.yzmBtn.enabled = NO;
    
//    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 验证码
- (IBAction)clickedYZM:(UIButton *)sender {
    if (_operatorsDataTool) {
        [_operatorsDataTool removeTimer];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _operatorsDataTool = [[OperatorsDataTool alloc] init];
    _operatorsDataTool.isfrom = 91;
    NSDictionary *dic = @{@"username":self.phone,
                          @"password":self.password,
                          @"otherInfo":self.otherInfo};
    [_operatorsDataTool searchInfo:dic OperatorsDataSuccesssuccess:^(id obj) {
        MYLog(@"无验证码-----OK-------%@",obj);
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
    
}
#pragma mark 下一步
- (IBAction)clickedLogin:(UIButton *)sender {
    if (_operatorsDataTool) {
        [_operatorsDataTool removeTimer];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationReault_meaasga object: nil userInfo:@{@"key":_yanzhengma.text}];
        [self.navigationController popViewControllerAnimated:YES];

    
    
    
}
#pragma mark 定时器
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    
    [self.yzmBtn setTitle:[NSString stringWithFormat:@"%lds",self.num] forState:UIControlStateNormal];
    if (self.num==0) {
        self.yzmBtn.enabled = YES;
        
        [self.yzmBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer =nil;
        self.num=600;
        return;
    }
}

#pragma mark 校验格式
-(BOOL)verificateData
{
    if ((_yanzhengma.text == nil)|[_yanzhengma.text isEqualToString:@""])
    {
        if (!_yzmBtn.isEnabled) {
            [self.view makeToast:@"请输入验证码" ifSucess:NO];
        } else {
            [self.view makeToast:@"请点击发送验证码并输入验证码" ifSucess:NO];
        }
        
        return NO;
    }
    return YES;
}

#pragma mark - 其他
//退回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
    
}

@end
