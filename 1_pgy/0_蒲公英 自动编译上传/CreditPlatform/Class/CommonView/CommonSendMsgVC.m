//
//  OperationSendMsgVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSendMsgVC.h"
#import "OperatorsReportMainVC.h"
#import "OperatorsDataTool.h"
@interface CommonSendMsgVC ()

// 顶部的label
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
// 左侧的验证码提示语  Btn
@property (weak, nonatomic) IBOutlet UIButton *LeftBtn;
// textfiled
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
// 验证码重发Btn 已经隐藏
@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;
// 底部注册Btn
@property (weak, nonatomic) IBOutlet UIButton *zcBtn;


// 底部注册Btn点击事件
- (IBAction)clickedLogin:(UIButton *)sender;
// 验证码重发点击事件
- (IBAction)clickedYZM:(UIButton *)sender;
// 顶部label的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLH;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CommonSendMsgVC
{
    OperatorsDataTool *_operatorsDataTool;
    BOOL _NOData;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground;
    self.zcBtn.layer.cornerRadius = 2;
    self.zcBtn.layer.masksToBounds = YES;
    
    NSString *msg;
    if ([NSString  isMobileNumber:self.msg]) {
        msg =  [_msg stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        msg = _msg;
//        msg = @"手机";
    }
    switch (self.sendMsgType) {
        case CommonSendMsgTypeNormal:{
            self.title = @"信息验证";
            self.topLabel.text = [NSString stringWithFormat:@"验证码已发送至%@，请注意查收",msg];
            self.topLabel.adjustsFontSizeToFitWidth = YES;
            break;
        }case CommonSendMsgTypePhone:{
            self.title = @"短信验证";
            self.topLabel.text = [NSString stringWithFormat:@"短信验证码已发送至%@，请注意查收",msg];
            self.topLabel.adjustsFontSizeToFitWidth = YES;
            break;
        }case CommonSendMsgTypeMail:{
            self.title = @"验证邮箱";
            self.topLabel.text = [NSString stringWithFormat:@"验证码已发送至%@，请注意查收",msg];
            self.topLabel.adjustsFontSizeToFitWidth = YES;
            break;
        }case CommonSendMsgTypeJLDX:{
            self.title = @"验证手机";
            self.topLabel.text = [NSString stringWithFormat:@"请用%@发送CXXD至10001获取验证码",msg];
            break;
        }case CommonSendMsgTypeQQCredit:{// 信用卡-- QQ邮箱
            self.title = @"QQ独立密码";
            self.topLabel.text = [NSString stringWithFormat:@"请输入QQ独立密码"];
            [self.LeftBtn setTitle:@"密码" forState:UIControlStateNormal];
            self.yanzhengma.placeholder = @"QQ独立密码";
            break;
        }default:
            break;
    }
    
    [self.zcBtn setTitle:@"生成报告" forState:UIControlStateNormal];
    if (self.msg.length<1) {
        self.topLabel.text = @"";
        self.topLH.constant = 10;
    }
    
    // 以下保留  历史数据
    self.num = 300;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
    self.yzmBtn.enabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.Sure && self.Cancel) {
        [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
        UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
        item.title = @"";
        [item setTintColor:RGB_gray];
        self.navigationItem.backBarButtonItem = item;
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:(UIBarButtonItemStyleDone) target:self action:@selector(Back)];
    }
    
}


#pragma mark 点击下一步
- (IBAction)clickedLogin:(UIButton *)sender {
    if (![self verificateData]) {
        return;
    }
    [self.view endEditing:YES];
    if (_operatorsDataTool) {
        [_operatorsDataTool removeTimer];
    }
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    //确认回调
    if (self.Sure) {
        self.Sure(_yanzhengma.text);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark 点击返回
-(void)Back{
    [self.view endEditing:YES];
    if (self.Cancel) {
        self.Cancel(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark 校验格式
-(BOOL)verificateData {
    if (self.sendMsgType == CommonSendMsgTypeQQCredit) {
     
        if ((_yanzhengma.text == nil)|[_yanzhengma.text isEqualToString:@""]){
            [self.view makeToast:@"请输入QQ独立密码" ifSucess:NO];
            return NO;
            
        }

    } else {
        
        if ((_yanzhengma.text == nil)|[_yanzhengma.text isEqualToString:@""]){
            if (!_yzmBtn.isEnabled) {
                [self.view makeToast:@"请输入验证码" ifSucess:NO];
            } else {
                [self.view makeToast:@"请点击发送验证码并输入验证码" ifSucess:NO];
            }
            return NO;
        }

        
    }
    
    return YES;
}

#pragma mark - 其他
 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark -
#pragma mark - 弃用
#pragma mark 重新发验证码
- (IBAction)clickedYZM:(UIButton *)sender {
    __block typeof(self) sself = self;
    if (![self verificateData]) {
        return;
    }
    if (_operatorsDataTool) {
        [_operatorsDataTool removeTimer];
    }
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _operatorsDataTool = [[OperatorsDataTool alloc] init];
    _operatorsDataTool.isfrom = 91;
    //    _operatorsDataTool.searchType = self.searchType;
    NSDictionary *dic = @{@"username":self.msg,
                          @"password":self.password,
                          @"otherInfo":self.otherInfo};
    [_operatorsDataTool searchInfo:dic OperatorsDataSuccesssuccess:^(id obj) {
        MYLog(@"无验证码-----OK-------%@",obj);
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        //          [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        NSString *errorStr = nil;
        if (error.domain &&error.code == 105) {
            errorStr = error.domain;
        } else {
            errorStr =@"数据请求失败";
        }
        [sself.view makeToast:errorStr];
        [sself performSelector:@selector(outself) withObject:nil afterDelay:errorDelay];
    }];
    
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



@end
