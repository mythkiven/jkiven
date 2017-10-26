//
//  CommonSearchBaseVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//


#import "LMZXSearchBaseVC.h"

#import "LMZXWebViewController.h"
#import "UIImage+LMZXTint.h"

#import "LMZXDemoAPI.h"
@interface LMZXSearchBaseVC ()

@property (nonatomic, strong) NSDictionary *dataList;

@end

@implementation LMZXSearchBaseVC

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 0;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { return nil;}

- (LMZXQueryInfoModel *)lmQueryInfoModel {
    if (!_lmQueryInfoModel) {
        _lmQueryInfoModel = [[LMZXQueryInfoModel alloc] init];
    }
    return _lmQueryInfoModel;
}

- (LMZXBaseSearchDataTool *)searchtool {
    if (!_searchtool) {
        _searchtool = [[LMZXBaseSearchDataTool alloc] init];
    }
    return _searchtool;
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    MYLog(@"====%@销毁了",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefault];
    [self initTotalView];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

#pragma mark 设置默认value
-(void)setDefault{
    
    if (self.searchItemType  == LMZXSearchItemTypeHousingFund
        |self.searchItemType == LMZXSearchItemTypeSocialSecurity
        |self.searchItemType == LMZXSearchItemTypeCarSafe
        |self.searchItemType == LMZXSearchItemTypeNetBankBill)
        _showAllowCell = YES;
    else
        _showAllowCell = NO;
    
    
   
//    if (self.searchItemType == SearchItemTypeLostCredit)
//        _showProtocol = NO;
//    else
        _showProtocol = YES;
    
    
    // 数据源处理
    if (!self.commonCellData) {
        self.commonCellData = [NSMutableArray arrayWithCapacity:1];
    }else{
        [self.commonCellData removeAllObjects];
    }
    
    // 设置页面背景色
    self.view.backgroundColor = self.lmzxPageBackgroundColor?self.lmzxPageBackgroundColor:[UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 设置页面背景色
    self.tableView.backgroundColor = self.lmzxPageBackgroundColor?self.lmzxPageBackgroundColor:[UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled =NO;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.rowHeight = 45;
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    
    self.bottomView =[[UIView alloc]init];
    self.bottomView.backgroundColor = self.lmzxPageBackgroundColor?self.lmzxPageBackgroundColor:[UIColor whiteColor];
}






#pragma mark 初始化子类通用view: 所有的
- (void)initTotalView{
    
    LMZXSearchCellModel *model;
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"lmzxResource" ofType:@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithPath:path];
//    NSString *plistPath = [bundle pathForResource:@"LMZXSearchList" ofType:@"plist"];
//    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    LMLog(@"data:%@",data);
    
    // 读取标题
    NSArray *titleArr = self.dataList[@"title"];
    self.title = titleArr[self.searchItemType];
    
    
    // 读取cell内容 计算宽度
    NSArray *dicArr = self.dataList[@"cellList"][self.searchItemType];
    for (int i=0;i<dicArr.count;i++) {
        CGFloat width=[dicArr[i][@"title"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
        self.titleWidth = (width>=self.titleWidth ? width:self.titleWidth);
    }
    for (int i=0;i<dicArr.count;i++) {
        model = [[LMZXSearchCellModel alloc]init];
        if (dicArr.count==2) {
            if (i==0) {
                model.location = 1;
            }else{
                model.location = 3;
            }
        } else if (dicArr.count==3) {
            model.location = i+1;
        }
        
        model.Name = dicArr[i][@"title"];
        model.type = [dicArr[i][@"icon"] integerValue];
        model.placeholdText = dicArr[i][@"hold"];
        model.maxLength = self.titleWidth;
        model.searchItemType = self.searchItemType;
        [self.commonCellData addObject:model];
        
    }
    if (_showAllowCell) {
        self.verifyNum = dicArr.count-1;
    }else{
        self.verifyNum = dicArr.count;
    }
    
    // 查询按钮
    
    
    self.bottomView.frame = CGRectMake(0,20, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT -64 -45*3);
    
    if (self.showProtocol) {
//        // 选框
        _btnSelected = [LMZXFactoryView btnWithSEL:@selector(didSelectedBtn:) And:self];
        _btnSearch.selected = YES;
//        [self.bottomView addSubview:_btnSelected];
//        // 同意
//        UILabel *label1 = [LMZXFactoryView labelWithMaxX:_btnSelected.frame withY:_btnSelected.frame];
//        [self.bottomView addSubview:label1];
        
         // 同意
        UILabel *label1 = [LMZXFactoryView labelTY];
        [self.bottomView addSubview:label1];
        
        NSString *urlStr =  self.lmzxProtocolTitle;
        if (self.searchItemType == LMZXSearchItemTypeCreditCardBill) {
            if ( self.protocolTitle && self.protocolTitle.length) {
                urlStr =  self.protocolTitle;
            }
        }
        // 协议
        UIButton *btnDetail = [LMZXFactoryView   btnWithTitleColor:(self.lmzxProtocolTextColor?self.lmzxProtocolTextColor:[UIColor blackColor])
                                                             title:urlStr
                                                             frame:label1.frame
                                                           WithSEL:@selector(didClickedDetail)
                                                            And:self];
        
        [self.bottomView addSubview:btnDetail];
        // 央行征信验证码
        if (self.searchItemType == LMZXSearchItemTypeCentralBank) {
            UIButton *btnDetailf = [LMZXFactoryView btnWithHeight:btnDetail.frame WithMinY:self.bottomView.frame WithSEL:@selector(didClickedForget:) And:self];
            [self.bottomView addSubview:btnDetailf];
        }
        self.btnSearch = [LMZXFactoryView creatButtonWithX:_btnSelected.frame WithY:btnDetail.frame WithSEL:nil And:self];
        [self.bottomView addSubview:self.btnSearch];
        
        // 展示联名卡
        _markLabel = [LMZXFactoryView JlabelWithSuper:self.view Color:LM_RGB(239, 83, 68)  Font:15 Alignment:1  Text:@"如已办理联名卡，则必须输入，否则无需输入"];
        _markLabel.backgroundColor = LM_RGB(255, 243, 184);
        _markLabel.frame = CGRectMake(0, 0, LM_SCREEN_WIDTH, 45);
        _markLabel.alpha =0;
        _markLabel.hidden=YES;
        [self.bottomView addSubview:_markLabel];
        
    }else{
        self.btnSearch = [LMZXFactoryView creatButtonWithX:CGRectMake(15,0,0,0) WithY:CGRectMake(0, 0, 0, 0) WithSEL:nil And:self];
        [self.bottomView addSubview:self.btnSearch];
    }
    
    LMZXSDK *lmSdk = [LMZXSDK shared];

    if (lmSdk.lmzxSubmitBtnColor) {
        [self.btnSearch setBackgroundImage:[UIImage resizedImageWithColor:lmSdk.lmzxSubmitBtnColor] forState:(UIControlStateNormal)];
        [self.btnSearch setBackgroundImage:[UIImage resizedImageWithColor:lmSdk.lmzxSubmitBtnColor] forState:(UIControlStateHighlighted)];
    } else {
        [self.btnSearch setBackgroundImage:[UIImage resizedImageWithColor:lmSdk.lmzxThemeColor] forState:(UIControlStateNormal)];
        [self.btnSearch setBackgroundImage:[UIImage resizedImageWithColor:lmSdk.lmzxThemeColor] forState:(UIControlStateHighlighted)];
    }
    
    if (lmSdk.lmzxSubmitBtnTitleColor) {
        [self.btnSearch setTitleColor:lmSdk.lmzxSubmitBtnTitleColor forState:(UIControlStateNormal)];
        [self.btnSearch setTitleColor:lmSdk.lmzxSubmitBtnTitleColor forState:(UIControlStateHighlighted)];
    } else {
        [self.btnSearch setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.btnSearch setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    }
    
    
    self.tableView.tableFooterView = self.bottomView;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
       UIView* _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,  0, LM_SCREEN_WIDTH, 0.5)];
        _bottomLine.backgroundColor = LM_RGBGrayLine;
        [self.bottomView addSubview:_bottomLine];
        
    } else {
        [self.tableView sendSubviewToBack:self.tableView.tableFooterView];
    }
    [self.tableView reloadData];
    
}



#pragma mark -  勾选同意框
- (void)didSelectedBtn:(UIButton*)btn{
    _btnSelected.selected = !_btnSelected.selected;
    
}

#pragma mark -  获取验证码
-(void)didClickedForget:(UIButton*)btn{
    LMZXWebViewController *ss = [[ LMZXWebViewController alloc] init];
    ss.url = SERVE_URL_YZM;
    ss.viewTitle  = @"如何获取身份验证码";
    [self.navigationController pushViewController:ss animated:YES];
    
}
#pragma mark -  查看协议内容
- (void)didClickedDetail{
    LMZXWebViewController *ss = [[ LMZXWebViewController alloc] init];
    ss.viewTitle = self.lmzxProtocolTitle ;
    ss.viewTitle = [ss.viewTitle substringWithRange:NSMakeRange(1, ss.viewTitle.length-2)];


    NSString *urlStr =  [LMZXSDK shared].lmzxProtocolUrl;
    if ( urlStr && urlStr.length) {
        ss.url = urlStr;
    }else{
        ss.url = LMZXSDK_GetProtocol_URL ;
    }
    [self.navigationController pushViewController:ss animated:YES];
    
    
    
}


#pragma  mark - textfiled  结束编辑
- (void)textFieldTextDidEndEditingSuper:(NSNotification *)noti {
    _zeroTextField = nil;
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != LM_TagCommonSearchCellTextfiled) {
        return;
    }
    
    //LMZXCommonSearchCell  *editeCell;
    UIView *editeCell;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        editeCell  = [tf superview];
        while (![editeCell isKindOfClass:[UITableViewCell class]]) {
            editeCell = [editeCell superview];
        }
    }else{
       editeCell  = [[tf superview] superview];
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(LMZXCommonSearchCell  *)editeCell];
    NSString *result = tf.text;
    
    if ((self.searchItemType == LMZXSearchItemTypeOperators)&&(indexPath.row == 0)) {
        return;
    }
    
    [editeCell endEditing:YES];
    
    if (self.showAllowCell) {// 有allowcell 0 allowcell  1账号 2密码 3其他
        switch (indexPath.row) {
            case 0:{// zeroTextField
                break;
            }case 1:{// firstTextField
                self.firstTextField = @"";
                self.firstTextField = result;
                break;
            }case 2:{// twoTextField
                self.twoTextField = @"";
                self.twoTextField = result;
                break;
            } case 3:{// threeTextField
                self.threeTextField = @"";
                self.threeTextField = result;
                break;
            }default:
                break;
        }

    } else {
        switch (indexPath.row) {//箭头 cell               //没有allowcell 0账号 1密码 2其他
            case 0:{// firstTextField
                self.firstTextField = @"";
                self.firstTextField = result;
                break;
            }case 1:{// twoTextField
                self.twoTextField = @"";
                self.twoTextField = result;
                break;
            }case 2:{// threeTextField
                self.threeTextField = @"";
                self.threeTextField = result;
                break;
            } case 3:{//
                
                break;
            }default:
                break;
        }

    }
    
    
}

#pragma mark-- 配置页面的字典数据
- (NSDictionary *)dataList {
    if (!_dataList) {
        
        _dataList = @{
                      @"title" : @[@"公积金",@"运营商",@"京东",@"淘宝",@"学历学籍",
                                   @"社保", @"汽车保险",@"网银流水", @"央行征信",@"信用卡账单",
                                    @"脉脉",@"领英",@"携程查询",@"滴滴查询"],
                      @"cellList" : @[
                              /// 公积金 0
                              @[@{
                                    @"hold" : @"请选择城市",
                                    @"title" : @"所在城市",
                                    @"icon" : @"1"},
                                @{
                                    @"hold" : @"公积金账号",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              // 运营商 1
                              @[@{
                                    @"hold" : @"请输入手机号",
                                    @"title" : @"手机号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"请输入服务密码",
                                    @"title" : @"服务密码",
                                    @"icon" : @"2"
                                    }],
                              /// JD 2
                              @[@{
                                    @"hold" : @"邮箱/用户名/手机号",
                                    @"title" : @"京东账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"京东密码",
                                    @"icon" : @"2"
                                    }],
                              // 淘宝 3
                              @[@{
                                    @"hold" : @"邮箱/用户名/手机号",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              // 学信 4
                              @[@{
                                    @"hold" : @"邮箱/手机号/身份证号",
                                    @"title" : @"学信网账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"学信网密码",
                                    @"icon" : @"2"
                                    }],
                              // 社保 5
                              @[@{
                                    @"hold" : @"请选择城市",
                                    @"title" : @"所在城市",
                                    @"icon" : @"1"
                                    },
                                @{
                                    @"hold" : @"社保账号",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                              //// 车险 6
                              @[@{
                                    @"hold" : @"车险",
                                    @"title" : @"车险",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              /////网银 7
                              @[@{
                                    @"hold" : @"请选择银行",
                                    @"title" : @"银行",
                                    @"icon" : @"1"
                                    },
                                @{
                                    @"hold" : @"银行卡号",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                              
                              ////央行 8
                              @[@{
                                    @"hold" : @"央行征信登录名",
                                    @"title" : @"登录名",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    },
                                @{
                                    @"hold" : @"身份验证码",
                                    @"title" : @"身份验证码",
                                    @"icon" : @"3"
                                    }],
                              //// 信用卡 9
                              @[@{
                                    @"hold" : @"请输入账号",
                                    @"title" : @"邮箱",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"请输入密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                              
                              //// 脉脉 10
                              @[@{
                                    @"hold" : @"手机号/脉脉号",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"请输入密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              //// 领英 11
                              @[@{
                                    @"hold" : @"手机号/邮箱",
                                    @"title" : @"账号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"请输入密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                      
                              //// 携程 12
                              @[@{
                                    @"hold" : @"国内手机号/用户名/邮箱/卡号",
                                    @"title" : @"手机号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"请输入密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                              //// 滴滴 13
                              @[@{
                                    @"hold" : @"请输入手机号",
                                    @"title" : @"手机号",
                                    @"icon" : @"3"
                                    },
                                @{
                                    @"hold" : @"密码",
                                    @"title" : @"密码",
                                    @"icon" : @"2"
                                    }],
                              
                              
                              ]
                      
//                      /////// 失信 10
//                      @[@{
//                            @"hold" : @"被执行人姓名/名称",
//                            @"title" : @"名称",
//                            @"icon" : @"3"
//                            },
//                        @{
//                            @"hold" : @"身份证号码/组织机构代码",
//                            @"title" : @"号码",
//                            @"icon" : @"3"
//                            }],
//                      
                      
                      };
        
    }
    return _dataList;
}


@end
