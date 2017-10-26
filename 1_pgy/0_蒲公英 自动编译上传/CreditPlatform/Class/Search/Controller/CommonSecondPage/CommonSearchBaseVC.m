//
//  CommonSearchBaseVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//


#import "CommonSearchBaseVC.h"

#import "WebViewController.h"


@interface CommonSearchBaseVC ()

@end

@implementation CommonSearchBaseVC

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefault];
    [self initTotalView];
    
    
}
#pragma mark 设置默认value
-(void)setDefault{
    
    if (self.searchItemType  == SearchItemTypeHousingFund
        |self.searchItemType == SearchItemTypeSocialSecurity
        |self.searchItemType == SearchItemTypeCarSafe)
        _showAllowCell = YES;
    else
        _showAllowCell = NO;
    
    
    if (self.searchItemType == SearchItemTypeOperators)
        _isPhone = YES;
    else
        _isPhone = NO;
   
    if (self.searchItemType == SearchItemTypeLostCredit)
        _showProtocol = NO;
    else
        _showProtocol = YES;
    
    
    // 数据源处理
    if (!self.commonCellData) {
        self.commonCellData = [NSMutableArray arrayWithCapacity:1];
    }else{
        [self.commonCellData removeAllObjects];
    }
    
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled =NO;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.rowHeight = 45;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    self.bottomView =[[UIView alloc]init];
}

#pragma mark 初始化子类通用view
- (void)initTotalView{
    
    
    CommonSearchCellModel *model;
    NSString *protocolText;
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CommonSearchList" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    // 读取标题
    NSArray *titleArr = data[@"title"];
    self.title =titleArr[self.searchItemType-20];
    
    // 读取协议
    NSArray *protocolArr = data[@"protocol"];
    protocolText= protocolArr[self.searchItemType-20];
    _protocolData = data[@"protocolURL"];
    _protocolTitleData =data[@"protocol"];
    
    //读取内容 计算宽度
    NSArray *dicArr = data[@"cellList"][self.searchItemType-20];
    for (int i=0;i<dicArr.count;i++) {
        CGFloat width=[dicArr[i][@"title"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
        self.titleWidth = (width>=self.titleWidth ? width:self.titleWidth);
    }
    for (int i=0;i<dicArr.count;i++) {
        model = [[CommonSearchCellModel alloc]init];
        model.location = i+1;
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
    
    // footerview
    self.bottomView.backgroundColor = RGB_pageBackground;
    self.bottomView.frame = CGRectMake(0,20, SCREEN_WIDTH, 300);
    if (self.showProtocol) {
        // 选框
        _btnSelected = [JFactoryView btnWithSEL:@selector(didSelectedBtn:) And:self];
        [self.bottomView addSubview:_btnSelected];
        // 同意
        UILabel *label1 = [JFactoryView labelWithMaxX:_btnSelected.frame withY:_btnSelected.frame];
        [self.bottomView addSubview:label1];
        // 协议
        UIButton *btnDetail = [JFactoryView btnWithTitle:protocolText frame:label1.frame WithSEL:@selector(didClickedDetail) And:self];
        [self.bottomView addSubview:btnDetail];
        // 央行征信验证码
        if (self.searchItemType == SearchItemTypeCentralBank) {
            UIButton *btnDetailf = [JFactoryView btnWithHeight:btnDetail.frame WithMinY:btnDetail.frame WithSEL:@selector(didClickedForget:) And:self];
            [self.bottomView addSubview:btnDetailf];
        }
        self.btnSearch = [JFactoryView creatButtonWithX:_btnSelected.frame WithY:btnDetail.frame WithSEL:nil And:self];
        [self.bottomView addSubview:self.btnSearch];
        
        // 展示联名卡
        _markLabel = [JFactoryView JlabelWithSuper:self.view Color:RGB_red  Font:15 Alignment:1  Text:@"如已办理联名卡，则必须输入，否则无需输入"];
        _markLabel.backgroundColor = RGB_yellowBg;
        _markLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        _markLabel.alpha =0;
        _markLabel.hidden=YES;
        [self.bottomView addSubview:_markLabel];
        
    }else{
        self.btnSearch = [JFactoryView creatButtonWithX:CGRectMake(15,0,0,0) WithY:CGRectMake(0, 0, 0, 0) WithSEL:nil And:self];
        [self.bottomView addSubview:self.btnSearch];
    }
    
    
    self.tableView.tableFooterView = self.bottomView;
    [self.tableView sendSubviewToBack:self.tableView.tableFooterView];
    [self.tableView reloadData];
    
}


#pragma mark -  勾选同意框
- (void)didSelectedBtn:(UIButton*)btn{
    _btnSelected.selected = !_btnSelected.selected;
    
}

#pragma mark -  获取验证码
-(void)didClickedForget:(UIButton*)btn{
    WebViewController *ss = [[ WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    ss.url = SERVE_URL_YZM;
    ss.viewTitle  = @"如何获取身份验证码";
    [self.navigationController pushViewController:ss animated:YES];
    
}
#pragma mark -  查看协议内容
- (void)didClickedDetail{
    WebViewController *ss = [[ WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    NSInteger index = self.searchItemType;
    ss.viewTitle = _protocolTitleData[index-20] ;
    ss.viewTitle = [ss.viewTitle substringWithRange:NSMakeRange(1, ss.viewTitle.length-2)];
    ss.url = [@"https://www.limuzhengxin.com/" stringByAppendingString: _protocolData[index -20]];
    [self.navigationController pushViewController:ss animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma  mark - textfiled  结束编辑
- (void)textFieldTextDidEndEditingSuper:(NSNotification *)noti {
    _zeroTextField = nil;
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != TagCommonSearchCellTextfiled) {
        return;
    }
    
    CommonSearchCell  *editeCell  = (CommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    NSString *result = tf.text;
    
    if ((self.searchItemType == SearchItemTypeOperators)&&(indexPath.row == 0)) {
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
        switch (indexPath.row) {//没有allowcell 0账号 1密码 2其他
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

 

@end
