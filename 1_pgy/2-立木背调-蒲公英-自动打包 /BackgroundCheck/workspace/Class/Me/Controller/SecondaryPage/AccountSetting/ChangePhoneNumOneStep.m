//
//  ChangePhoneNumOneStep.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/22.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ChangePhoneNumOneStep.h"
#import "ChangePhoneNumTwoStep.h"
@interface ChangePhoneNumOneStep ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet JEConfirmButton *confirmBtn;
@property (strong, nonatomic) NSString * phoneNum;
@end

@implementation ChangePhoneNumOneStep
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
    self.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave];
    if (self.phoneNum.length>10) {
        self.phone.text = [self.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    [_confirmBtn loadConfigEnable:YES];
}

- (IBAction)clickedBtn:(UIButton *)sender {
    ChangePhoneNumTwoStep *t = [[ChangePhoneNumTwoStep alloc]init];
    t.oldPhone = self.phoneNum;
    [self.navigationController pushViewController:t animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
