//
//  YJTypeMenu.m
//  下拉菜单
//
//  Created by yj on 16/9/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTypeMenu.h"
#import "YJTypeMenuButton.h"
#import "YJPackageServiceModel.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width


@interface YJTypeMenu ()
{
    NSMutableArray *_btnArr;
    
    CGFloat _menuH;
}
@property (nonatomic, weak) UIButton *currentBtn;

/**
 标准消费
 */
@property (nonatomic, strong) NSMutableArray *titlesArraySpend;
@property (nonatomic, strong) NSMutableDictionary *menuBizTypeDictSpend;

/**
 套餐消费
 */
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableDictionary *menuBizTypeDict;

@end
@implementation YJTypeMenu
- (NSMutableArray *)titlesArray {
    
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray arrayWithObjects:@"全部", nil];
    }
    return _titlesArray;
}
- (NSMutableDictionary *)menuBizTypeDict {
    if (!_menuBizTypeDict) {
        _menuBizTypeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"全部", nil];
    }
    return _menuBizTypeDict;
}

- (NSMutableArray *)titlesArraySpend {
    
    if (!_titlesArraySpend) {
        _titlesArraySpend = [NSMutableArray arrayWithObjects:@"全部", nil];
    }
    return _titlesArraySpend;
}
- (NSMutableDictionary *)menuBizTypeDictSpend {
    if (!_menuBizTypeDictSpend) {
        _menuBizTypeDictSpend = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"全部", nil];
    }
    return _menuBizTypeDictSpend;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _btnArr = [NSMutableArray arrayWithCapacity:2];

//        [self setupSubviews];
        
        

    }
    return self;
}

- (void)setMenuType:(YJMenuType)menuType {
    _menuType = menuType;
    
    if (_menuType == YJMenuTypeRecharge) {
        _contentView.frame =  CGRectMake(0, 0, self.frame.size.width, 175);

        [self setupSubviewsWithMenuTypeRecharge];// 充值
        
    } else if (_menuType == YJMenuTypePurchase) {
        _contentView.frame =  CGRectMake(0, 0, self.frame.size.width, 135);
        [self setupSubviewsWithMenuTypePurchase];// 标准消费
        
    } else if (_menuType == YJMenuTypeComboPurchase) {
        _contentView.frame =  CGRectMake(0, 0, self.frame.size.width, 145);

        [self setupSubviewsWithMenuTypeComboPurchase];// 套餐消费
        
    }
    

    
}

/**
 套餐消费
 */
- (void)setupSubviewsWithMenuTypeComboPurchase {
//    NSArray *titles = [self menuTypeComboPurchaseTitles];
    
    [self loadComboPurchaseData];
    
}

#pragma mark   加载用户套餐信息
- (void)loadComboPurchaseData {
    
    NSDictionary *dict = @{@"method" :      urlJK_queryUserPackageService,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_0,
                           };
    __weak typeof(self) weakSelf = self;
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryUserPackageService] params:dict success:^(id obj) {
        
        MYLog(@"套餐类型--------%@",obj);
        
        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            
            NSArray *array = [YJPackageServiceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (YJPackageServiceModel *model in array) {
                    
                   [weakSelf.titlesArray addObject:model.servicePackageName];
                    
                   [weakSelf.menuBizTypeDict setObject:model.servicePackageId forKey:model.servicePackageName];
                    
                }
                NSArray *titles = weakSelf.titlesArray;
                
                int count = (int)titles.count;
                
                for (int i = 0; i < count ; i ++) {
                    YJTypeMenuButton *btn = [self menuBtnWithTitle:titles[i]];
                    if (i == 0) {
                        self.currentBtn.selected = NO;
                        btn.selected = YES;
                        self.currentBtn = btn;
                    }
                    [_btnArr addObject:btn];
                    [self setNeedsLayout];
                }
                
            });
        }
    } failure:^(NSError *error) {
        MYLog(@"套餐类型失败---%@",error.localizedDescription);
    }];
    
}




// 充值类型
- (void)setupSubviewsWithMenuTypeRecharge {
    int count = (int)[self menuTypeRechargeTitles].count;
    
    for (int i = 0; i < count ; i ++) {
        YJTypeMenuButton *btn = [self menuBtnWithTitle:[self menuTypeRechargeTitles][i]];
        if (i == 0) {
            self.currentBtn.selected = NO;
            btn.selected = YES;
            self.currentBtn = btn;
        }
        [_btnArr addObject:btn];
    }
    
    
}

    

// 消费类型
- (void)setupSubviewsWithMenuTypePurchase {
    
//    NSDictionary *dict = @{@"method" :      urlJK_getSpendRecordService,
//                           @"mobile" :      kUserManagerTool.mobile,
//                           @"userPwd" :     kUserManagerTool.userPwd,
//                           @"appVersion":   VERSION_APP_1_3_0,
//                           };
//    __weak typeof(self) weakSelf = self;
//    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_getSpendRecordService] params:dict success:^(id obj) {
//
//        MYLog(@"1111----%@",obj);
//
//
//
//
//        if (![obj[@"list"] isKindOfClass:[NSNull class]]) {
//
//            if ([obj[@"list"] isKindOfClass:[NSArray class]]) {
//                NSArray *array = [QueryUserPackageServiceModel mj_objectArrayWithKeyValuesArray:obj[@"list"]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    for (QueryUserPackageServiceModel *model in array) {
//
//                        [weakSelf.titlesArraySpend addObject:model.apiTypeName];
//
//                        [weakSelf.menuBizTypeDictSpend setObject:model.apiType forKey:model.apiTypeName];
//
//                    }
//                    NSArray *titles = weakSelf.titlesArraySpend;
//
//                    int count = (int)titles.count;
//
//                    for (int i = 0; i < count ; i ++) {
//                        YJTypeMenuButton *btn = [self menuBtnWithTitle:titles[i]];
//                        if (i == 0) {
//                            self.currentBtn.selected = NO;
//                            btn.selected = YES;
//                            self.currentBtn = btn;
//                        }
//                        [_btnArr addObject:btn];
//                        [self setNeedsLayout];
//                    }
//
//                });
//            }
//
//        }
//    } failure:^(NSError *error) {
//        MYLog(@"套餐类型失败---%@",error.localizedDescription);
//    }];
    
//    
    int count = (int)[self menuTypePurchaseTitles].count;
    
    for (int i = 0; i < count ; i ++) {
        YJTypeMenuButton *btn = [self menuBtnWithTitle:[self menuTypePurchaseTitles][i]];
        if (i == 0) {
            self.currentBtn.selected = NO;
            btn.selected = YES;
            self.currentBtn = btn;
        }
        [_btnArr addObject:btn];
    }
    
}


- (YJTypeMenuButton *)menuBtnWithTitle:(NSString *)title {
    YJTypeMenuButton *btn = [[YJTypeMenuButton alloc] init];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn.titleLabel sizeToFit];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_scrollView addSubview:btn];

    [btn addTarget:self action:@selector(btnClcik:) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}


- (void)btnClcik:(YJTypeMenuButton *) item {
    
    [self hide];

    
//    if (self.currentBtn == item) {
//        
//        return;
//    }
    
    // 1.控制选中状态
    self.currentBtn.selected = NO;
    item.selected = YES;
    self.currentBtn = item;
    
    NSString *type = nil;
    switch (_menuType) {
        case YJMenuTypeRecharge:
        {
            
            type = @"statusType";
            [[NSNotificationCenter defaultCenter] postNotificationName:YJApiTypeDidChangeNotification object:nil userInfo:@{type:[self menuPurchaseBizType][item.titleLabel.text]}];
            break;
        }
        case YJMenuTypePurchase:// 标准消费
        {
            type = @"apiType";
            [[NSNotificationCenter defaultCenter] postNotificationName:YJApiTypeDidChangeNotification object:nil userInfo:@{type:[self menuTypePurchaseTitles]}];
//            [[NSNotificationCenter defaultCenter] postNotificationName:YJApiTypeDidChangeNotification object:nil userInfo:@{type:self.menuBizTypeDictSpend[item.titleLabel.text]}];
            break;
        }
            
        case YJMenuTypeComboPurchase:
        {
            type = @"packageId";
            
            [[NSNotificationCenter defaultCenter] postNotificationName:YJApiTypeDidChangeNotification object:nil userInfo:@{type:self.menuBizTypeDict[item.titleLabel.text]}];
            
            break;
        }
        default:
            break;
    }
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 24;
    
    CGFloat btnH = 40;
    int count = (int)_btnArr.count;

    
    switch (_menuType) {
        case YJMenuTypeRecharge:
        {
            CGFloat btnW = SCREEN_WIDTH - margin;
            for (int i = 0; i < count; i ++) {
                
                UIButton *btn = _btnArr[i];
                CGFloat btnX = margin;
                CGFloat btnY = i * btnH;

                btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
                if (i == count - 1) {
                    _menuH = CGRectGetMaxY(btn.frame) +15;
                }
                
            }
            _scrollView.contentSize = CGSizeMake(0, _menuH);

            _scrollView.frame =  CGRectMake(0, 0, self.frame.size.width, _menuH);

            break;
        }
        case YJMenuTypePurchase:
        {
            CGFloat btnW = SCREEN_WIDTH - margin;
            for (int i = 0; i < count; i ++) {
                
                UIButton *btn = _btnArr[i];
                CGFloat btnX = margin;
                CGFloat btnY = i * btnH;
                
                btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
                if (i == count - 1) {
                    _menuH = CGRectGetMaxY(btn.frame) +15;
                }
                
            }
            _scrollView.contentSize = CGSizeMake(0, _menuH);
            
            _scrollView.frame =  CGRectMake(0, 0, self.frame.size.width, _menuH);

            break;
        }
        case YJMenuTypeComboPurchase:
        {
            CGFloat btnW = SCREEN_WIDTH - margin;
            for (int i = 0; i < count; i ++) {
                
                UIButton *btn = _btnArr[i];
                CGFloat btnX = margin;
                CGFloat btnY = i * btnH;
                
                btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
                if (i == count - 1) {
                    _menuH = CGRectGetMaxY(btn.frame) +15;
                }
                
            }
            _scrollView.contentSize = CGSizeMake(0, _menuH);

            _scrollView.frame =  CGRectMake(0, 0, self.frame.size.width, _menuH);

            break;
        }
        default:
            break;
    }
    
    
    
//    _contentView.frame =  CGRectMake(0, 0, self.frame.size.width, _menuH);
    
}



/**
 *  目前四个业务模块
 *
 */
- (NSArray *)menuTypePurchaseTitles{
    return @[@"全部",@"基础版",@"标准版"];
//    return @[@"全部",@"公积金",@"社保",@"央行征信",@"运营商",@"京东",@"淘宝",@"脉脉",@"领英",@"学历学籍",@"信用卡账单",@"失信被执行",@"汽车保险",@"网银流水",@"携程",@"滴滴打车",@"身份证实名检验",@"手机号实名检验",@"银行三要素检验",@"银行四要素检验"];
}


- (NSDictionary *)menuPurchaseBizType {
    
    
    return  @{@"全部":@"",
              @"基础版":@"housefund",
              @"标准版":@"socialsecurity",
              @"公积金":@"housefund",
              @"社保":@"socialsecurity",
              @"央行征信":@"credit",
              @"运营商":@"mobile",
              @"京东":@"jd",
              @"学历学籍":@"education",
              @"淘宝":@"taobao",
              @"脉脉":@"maimai",
              @"领英":@"linkedin",
              @"信用卡账单":kBizType_bill,
              @"失信被执行":kBizType_shixin,
              @"汽车保险" :kBizType_autoinsurance,
              @"网银流水" :kBizType_ebank,
              @"携程":kBizType_ctrip,
                  @"滴滴打车":kBizType_diditaxi,
                  @"身份证实名检验":kBizType_idcheck,
                  @"手机号实名检验":kBizType_mobilecheck,
                  @"银行三要素检验":kBizType_bankcard3check,
                  @"银行四要素检验":kBizType_bankcard4check,
              @"待支付":@"1",
              @"交易成功":@"2",
              @"交易关闭":@"3"};
}

/**
 *  充值状态
 *
 */
- (NSArray *)menuTypeRechargeTitles{
    return @[@"全部",@"待支付",@"交易成功",@"交易关闭"];
}
/**
 *  套餐消费
 *
 */
- (NSArray *)menuTypeComboPurchaseTitles{
    return @[@"全部",@"A套餐",@"B套餐",@"C套餐"];
}




/*
 套餐类型--------{
	code = 0000,
	success = 1,
	data = [
 {
	id = <null>,
	packageRate = <null>,
	servicePackageName = A套餐,
	channel = <null>,
	createDate = 1477623065601,
	servicePackageId = c26b236695ba11e691b5000c29dca631,
	userId = <null>,
	endTime = <null>,
	updateDate = 1477623065601,
	remark = <null>,
	startTime = <null>,
	status = 00
 }
 ],
	msg = 处理成功,
	list = <null>
 }
 */
@end
