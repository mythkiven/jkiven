;//
//  YJSearchViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LoginVC.h"
#import "YJCycleModel.h"
#import "CommonSearchVC.h"
#import "YJRadarScanView.h"
#import "YJHomeItemModel.h"
#import "YJHomeCell.h"
#import "YJAlertView.h"
#import "YJHomeCollectionViewCell.h"
//#import "YJFooterLineView.h"
#import "YJHeaderLineView.h"
#import "YJReportCompanyInfoMainVC.h"

#import "YJCitySelectedVC.h"

#import "CarInsurancSearchVC.h"

#import "YJReportCarInsurancTypeVC.h"

#import "JLoadingReportBaseVC.h"

#import "JHousingFundSocialSecurityVC.h"
#import <CommonCrypto/CommonDigest.h>
//#import "LMResultShowVC.h"
#import "YJAuthorizationViewController.h"
#import "YJAuthTipModalView.h"

#import "ResultWebViewController.h"
#import "YJReportHoseFundDetailsVC.h"
#import "YJReportSocialSecurityDetailsVC.h"

@interface YJSearchViewController ()<UIScrollViewDelegate,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIBarButtonItem *_leftItem;
    
    YJRadarScanView *_radarView;
    

    UITableView *_tableView;
    
    UICollectionView *_collectionView;
    
    BOOL _isRefreshPrice;
    NSString *_signSever;
//    NSInteger __II;
    
}
/**
 *  存放循环滚动的模型数据
 */
@property (nonatomic, strong) NSArray *cycleDataArr;



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@property (nonatomic, strong) CLLocationManager *locManager;

@property (nonatomic, strong) CLGeocoder *reverseGeo;

@property (nonatomic, strong) NSArray *homeSearchItems;

@property (nonatomic, strong) YJAuthTipModalView *authTipModalView;



@end

static NSString *collectionIdentifier = @"homeCollectionViewCell";
//static NSString *footerCollectionIdentifier = @"footerCollectionIdentifier";
static NSString *headerCollectionIdentifier = @"headerCollectionIdentifier";

@implementation YJSearchViewController
{
    LMZXSDK *_lmzxSDK;
}
/**
 *  存放循环滚动的模型数据
 */
- (NSArray *)cycleDataArr {
    if (!_cycleDataArr) {
        
        self.cycleDataArr = [YJCycleModel mj_objectArrayWithFilename:@"image.plist"];
        
    }
    return _cycleDataArr;
}

// 定位管理类
- (CLLocationManager *)locManager {
    if (!_locManager) {
        
        _locManager = [[CLLocationManager alloc] init];
        _locManager.delegate = self;
        [_locManager requestAlwaysAuthorization];
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.distanceFilter = kCLDistanceFilterNone;
        
    }
    return _locManager;
}
// 反地理编码
- (CLGeocoder *)reverseGeo {
    if (!_reverseGeo) {
        _reverseGeo = [[CLGeocoder alloc] init];
    }
    return _reverseGeo;
}

- (NSArray *)homeSearchItems {
    if (_homeSearchItems == nil) {
        _homeSearchItems = [NSArray array];
        
        _homeSearchItems = [YJHomeItemModel mj_objectArrayWithFilename:@"homeSearchItem.plist"];
        
    }
    return _homeSearchItems;
}

- (YJAuthTipModalView *)authTipModalView {
    if (_authTipModalView == nil) {
        _authTipModalView = [[YJAuthTipModalView alloc] init];
    }
    return _authTipModalView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    if(iOS11){
    }else{
        self.navigationItem.title = @"首页";
    }
    
    self.view.backgroundColor = RGB(246, 246, 246);
    
    _signSever =nil;
    
    

   
    
    [self creatUI];
    
    
    if ([kUserManagerTool isLogin]) {
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
// 监听登录成功和退出登录，刷新价格
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPriceData) name:YJNotificationUserLogout object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPriceData) name:YJNotificationUserLogin object:nil];
    
    
}

#pragma mark -  初始化SDK
- (void)initSDK {
    

    // 特殊处理, 可以配置测试环境
    [LMZXSDK shared].lmzxTestURL = lm_url;
    
    if (kUserManagerTool.apiKey  ) {
        lm_APIKEY = kUserManagerTool.apiKey;
//        lm_APIKEY = @"8240517622587971";
    }
//    if (kUserManagerTool.aesKey  ) {
//        lm_APISECRET =  kUserManagerTool.aesKey;
////        lm_APISECRET =  @"7310r3sn1t1REt68rRcZWFOW7Ly5rx7y" ;
//    }
    if (kUserManagerTool.username ) {
        lm_UID =kUserManagerTool.username;
    }else if (kUserManagerTool.mobile ) {
        lm_UID =kUserManagerTool.mobile;
    }else {
        lm_UID = @"lm_UID";
    }
    
    
    
    MYLog(@"lm_APIKEY====%@",lm_APIKEY);
    if(!_lmzxSDK){
        _lmzxSDK = [LMZXSDK lmzxSDKWithApikey:lm_APIKEY uid:lm_UID callBackUrl:lm_CALLBACKURL];
    }
    // 切换了用户
    if(![_lmzxSDK.lmzxApiKey isEqualToString:kUserManagerTool.apiKey]){
        _lmzxSDK.lmzxApiKey = kUserManagerTool.apiKey;
        _lmzxSDK.lmzxUid = lm_UID;
    }
    
    // 导航条颜色
    _lmzxSDK.lmzxThemeColor =  RGB(48, 113, 242);
    // 返回按钮文字\图片颜色,标题颜色
    _lmzxSDK.lmzxTitleColor = [UIColor whiteColor];
    // 查询页面协议文字颜色,和查询动画页面的动画颜色,文字颜色相同
    _lmzxSDK.lmzxProtocolTextColor = RGB(48, 113, 242) ;
    // 提交按钮颜色
    _lmzxSDK.lmzxSubmitBtnColor = RGB(57, 179, 27);
    // 页面背景颜色
    _lmzxSDK.lmzxPageBackgroundColor = RGB(245, 245, 245);
    
}
#pragma mark SDK结果回调
- (void)handleResult:(NSString *)functionType {
    
    __block typeof(self) weakSelf = self;
    
    _lmzxSDK.lmzxResultBlock = ^(NSInteger code, LMZXSDKFunction function, id obj, NSString * token){
        NSLog(@"SDK结果回调:%ld,%d,%@,%@",(long)code,function,obj,token);
        if (code == 0 &&token.length>0&functionType.length>0 ) {
            
            // 使用原生的, 在第三步,获取 getresult 获取结果时,需要加签,否则会报验签失败.
//            if (function == 0) { // 公积金 ===> 原生
//                YJReportHoseFundDetailsVC *reportHoseFundVC = [[YJReportHoseFundDetailsVC alloc] init];
//                reportHoseFundVC.sdkEnter = YES;
//                reportHoseFundVC.sdktoken = token;
//                YJNavigationController *navResultVC = [[YJNavigationController alloc]
//                                                       initWithRootViewController:reportHoseFundVC];
//                [weakSelf presentViewController:navResultVC
//                                       animated:YES
//                                     completion:nil];
//
//            } else if (function == 5) {//社保  ===> 原生
//                YJReportSocialSecurityDetailsVC *socialSecurityVC = [[YJReportSocialSecurityDetailsVC alloc] init];
//                socialSecurityVC.sdktoken = token;
//                socialSecurityVC.sdkEnter =YES;
//                YJNavigationController *navResultVC = [[YJNavigationController alloc]
//                                                       initWithRootViewController:socialSecurityVC];
//                [weakSelf presentViewController:navResultVC
//                                       animated:YES
//                                     completion:nil];
//            }else {
                ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
                resultVc.token = token;
                resultVc.biztype = functionType;
                resultVc.getResult = @"1";
                resultVc.url = result_web_url_;
                YJNavigationController *navResultVC = [[YJNavigationController alloc]
                                                       initWithRootViewController:resultVc];
                
                [weakSelf presentViewController:navResultVC
                                       animated:YES
                                     completion:nil];
//            }
            
            

            
        } else {
            
            
        }
    
    };
}




#pragma mark SDK签名
- (void)sign:(NSString*)string {
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:@"sign"] params:@{@"param":string} success:^(id responseObj) {
        NSString * ss = responseObj[@"data"];
        if (ss.length) {
           [[LMZXSDK shared] sendReqWithSign:ss];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
 
    // param=xxxx
    
//    NSString *sign = [string stringByAppendingString:lm_APISECRET];
//    NSMutableString *mString = [NSMutableString stringWithString:sign];
//    NSString *newsign ;
//    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
//    NSData *stringBytes = [mString dataUsingEncoding: NSUTF8StringEncoding];
//    
//    if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
//        NSMutableString *digestString = [NSMutableString stringWithCapacity:
//                                         CC_SHA1_DIGEST_LENGTH];
//        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
//            unsigned char aChar = digest[i];
//            [digestString appendFormat:@"%02X", aChar];
//        }
//        newsign =[digestString lowercaseString];
//        
//    }
//    NSLog(@"%@",newsign);
//     [[LMZXSDK shared] sendReqWithSign:newsign];
}


#pragma mark - --加载价格信息
- (void)loadPriceData {
    NSDictionary *dict = nil;
    if (kUserManagerTool.isLogin) {
        dict = @{@"method":urlJK_packageTypeOneAmt,
                 @"mobile":kUserManagerTool.mobile,
                 @"userPwd":kUserManagerTool.userPwd,
                 @"appVersion":VERSION_APP_1_4_2
                };
        
        MYLog(@"-------登录");
    } else {
        MYLog(@"-------？登录");
        dict = @{@"method":urlJK_packageTypeOneAmt,
                 @"mobile":@"",
                 @"userPwd":@"",
                 @"appVersion":VERSION_APP_1_4_2
                               };
    }
   
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_packageTypeOneAmt] params:dict success:^(id responseObj) {
//        NSDictionary *dict = responseObj[@"data"];
        MYLog(@"官方售价--：%@",responseObj);
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            _isRefreshPrice = NO;

        } else {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
            
            
            [responseObj[@"data"] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *value = obj;
                
                [dict setObject:[value stringByAppendingString:@"元/次"] forKey:key];
                
            }];
            
            
            for (YJHomeItemModel *item in self.homeSearchItems) {
                switch (item.searchItemType) {
                    case SearchItemTypeHousingFund:
                        item.subTitle = dict[@"housefundAmt"];
                        break;
                    case SearchItemTypeSocialSecurity:
                        item.subTitle = dict[@"socialsecurityAmt"];
                        break;
                    case SearchItemTypeCentralBank:
                        item.subTitle = dict[@"creditAmt"];
                        break;
                    case SearchItemTypeOperators:
                        item.subTitle = dict[@"mobileAmt"];
                        break;
                    case SearchItemTypeE_Commerce:
                        item.subTitle = dict[@"jdAmt"];
                        break;
                    case SearchItemTypeTaoBao:
                        item.subTitle = dict[@"taobaoAmt"];
                        break;
                    case SearchItemTypeMaimai:
                        item.subTitle = dict[@"maimaiAmt"];
                        break;
                    case SearchItemTypeLinkedin:
                        item.subTitle = dict[@"linkedinAmt"];
                        break;
                    case SearchItemTypeEducation:
                        item.subTitle = dict[@"educationAmt"];
                        break;
                    case SearchItemTypeCreditCardBill:
                        item.subTitle = dict[@"billAmt"];
                        break;
                    case SearchItemTypeLostCredit:
                        item.subTitle = dict[@"shixinAmt"];
                        break;
                    case SearchItemTypeCarSafe:
                        item.subTitle = dict[@"autoinsuranceAmt"];
                        break;
                    case SearchItemTypeNetBankBill:
                        item.subTitle = dict[@"ebankAmt"];
                        break;
                    default:
                        break;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
                _isRefreshPrice = YES;
                
            });
            
        }
        
        
        
    } failure:^(NSError *error) {
        _isRefreshPrice = NO;
        MYLog(@"----错误：%@",error.localizedDescription);
    }];
    
    
}





- (void)creatUI {
    // 雷达
    _radarView = [[YJRadarScanView alloc] init];
    CGFloat radarViewH = 209;
    if (iPhone4s || iPhone5) {
        radarViewH = 178.5;
    }
    _radarView.frame = CGRectMake(0, -64, SCREEN_WIDTH, radarViewH);
    [self.view addSubview:_radarView];
    
    // 初始化tableview
//    [self setupTableView];
    [self creatCollectionView];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//     如果价格没有刷新成功，继续刷新
//    if (!_isRefreshPrice) {
//        [self loadPriceData];
//    }
    
    
    
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:NO];
    
    
    [self checkNet];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_radarView startRadarScan];

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_radarView stopRadarScan];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark--初始化CollectionView
- (void)creatCollectionView {
    // (UICollectionViewLayout *)决定他的布局方式
    
    CGFloat margin = 0;
    
    CGFloat photoW = (SCREEN_WIDTH -margin) * .5;
    CGFloat photoH = 90;

    if (iPhone5 || iPhone4s) {
        photoH = 80;
    }
    
    //平铺方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(photoW, photoH); //设置cell的大小
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    
    
    self.view.backgroundColor = RGB_pageBackground;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_radarView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-_radarView.height-44) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = RGB_pageBackground;

//    [_collectionView registerClass:[YJHomeCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
//    
//    CGFloat bottomEdge = 10;
//    if (iPhone6P) {
//        bottomEdge = 40;
//    }
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YJHomeCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:collectionIdentifier];
    [_collectionView registerClass:[YJHeaderLineView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectionIdentifier];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    [self.view addSubview:_collectionView];
    
    

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeSearchItems.count; 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    cell.homeItemModel = self.homeSearchItems[indexPath.row];
    

    return cell;
}


/**
 将头部控件做成一条线

 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectionIdentifier forIndexPath:indexPath];
        header.backgroundColor = RGB_grayLine;
        
        return header;
    }
    
    return nil;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
//        header.backgroundColor = RGB_grayLine;
//
//        return header;
//    }
//    
//    return nil;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(100, .5);

}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(100, .5);
//}

#define mark - SDK

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // http://192.168.117.239:8185/data/query?token=&bizType=jd
    
    
    
    YJHomeItemModel *itemModel = self.homeSearchItems[indexPath.row];

    
    NSString *functionType;
    LMZXSDKFunction sdkFunction=-1;
    
    __block typeof(self) wself = self;

    if (itemModel.searchItemType == SearchItemTypeHousingFund) { // 公积金
        sdkFunction = LMZXSDKFunctionHousingFund;
        functionType = kBizType_housefund;
    } else if (itemModel.searchItemType == SearchItemTypeSocialSecurity) {//  社保
        sdkFunction = LMZXSDKFunctionSocialSecurity;
        functionType = kBizType_socialsecurity;
    } else if (itemModel.searchItemType == SearchItemTypeOperators) {// 运营商
        sdkFunction = LMZXSDKFunctionMobileCarrie;
        functionType = kBizType_mobile;
    } else if (itemModel.searchItemType == SearchItemTypeE_Commerce) {// JD
        sdkFunction = LMZXSDKFunctionJD;
        functionType = kBizType_jd;
    } else if (itemModel.searchItemType == SearchItemTypeTaoBao) {// 淘宝
        sdkFunction = LMZXSDKFunctionTaoBao;
        functionType = kBizType_taobao;
    } else if (itemModel.searchItemType == SearchItemTypeEducation) {// 学历
        sdkFunction = LMZXSDKFunctionEducation;
        functionType = kBizType_education;
    } else if (itemModel.searchItemType == SearchItemTypeCentralBank) {// 央行
        sdkFunction = LMZXSDKFunctionCentralBank;
        functionType = kBizType_credit;
    } else if (itemModel.searchItemType == SearchItemTypeCreditCardBill) {// 信用卡
        sdkFunction = LMZXSDKFunctionCreditCardBill;
        functionType = kBizType_bill;
    } else if (itemModel.searchItemType == SearchItemTypeNetBankBill) {// 网银
        sdkFunction = LMZXSDKFunctionEBankBill;
        functionType = kBizType_ebank;
    } else if (itemModel.searchItemType == SearchItemTypeCarSafe) {// 车险
         sdkFunction = LMZXSDKFunctionAutoinsurance;
        functionType = kBizType_autoinsurance;
    }else if (itemModel.searchItemType == SearchItemTypeMaimai) {// 脉脉
        sdkFunction = LMZXSDKFunctionMaimai;
        functionType = kBizType_maimai;
    }else if (itemModel.searchItemType == SearchItemTypeLinkedin) { // linkedin
        sdkFunction = LMZXSDKFunctionLinkedin;
        functionType = kBizType_linkedin;
    }else if (itemModel.searchItemType == SearchItemTypeCtrip) {// 携程
        sdkFunction = LMZXSDKFunctionCtrip;
        functionType = kBizType_ctrip;
    }else if (itemModel.searchItemType == SearchItemTypeDidiTaxi) {//滴滴
        sdkFunction = LMZXSDKFunctionDiDiTaxi;
        functionType = kBizType_diditaxi;
    }else if (itemModel.searchItemType == SearchItemTypeLostCredit) {//失信
        if ([kUserManagerTool isLogin]) {
            // 如果认证成功方可查询
            
            //        MYLog(@"如果认证成功方可查询%@",[kUserManagerTool authStatus]);
            if ([[kUserManagerTool authStatus] intValue] == 20) {
                
                if (itemModel.searchItemType == SearchItemTypeMore) {
                    return;
                }
                YJHomeItemModel *itemModel = self.homeSearchItems[indexPath.row];
                CommonSearchVC *cvc = [[CommonSearchVC alloc]init];
                cvc.searchItemType = itemModel.searchItemType;
                [self.navigationController pushViewController:cvc animated:YES];
            } else { // 提示认证
                [self.authTipModalView showInRect:self.view.frame];
                self.authTipModalView.authBlock = ^(){
                    YJAuthorizationViewController  *VC = [[YJAuthorizationViewController alloc] init];
                    [wself.navigationController pushViewController:VC animated:YES];
                };
                
            }
        } else {
            LoginVC *ll = [[LoginVC alloc]init];
            YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
            [self presentViewController:nav animated:YES completion:nil];
        }
        return;
    }
    

    
    if ([kUserManagerTool isLogin]) {
        // 如果认证成功方可查询
        
//        MYLog(@"如果认证成功方可查询%@",[kUserManagerTool authStatus]);
        if ([[kUserManagerTool authStatus] intValue] == 20) {
            
            [self initSDK];
            _lmzxSDK.channel = kChannelSDK;
            [_lmzxSDK startFunction:sdkFunction authCallBack:^(NSString *authInfo) {
                 [wself sign:authInfo];
            }];
            // 结果回调
            [self handleResult:functionType];
            
            
        } else { // 提示认证
            
            [self.authTipModalView showInRect:self.view.frame];
            
            
            self.authTipModalView.authBlock = ^(){
                YJAuthorizationViewController  *VC = [[YJAuthorizationViewController alloc] init];
                
                [wself.navigationController pushViewController:VC animated:YES];
            };
            
            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未认证，或者正在审核中" preferredStyle:(UIAlertControllerStyleAlert)];
//            
//            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去认证" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            
//            [alert addAction:action1];
//            [alert addAction:action2];
//            
//            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
    }

    
    
//    // 之前逻辑:
//    
//    if ([kUserManagerTool isLogin]) {
//        if (itemModel.searchItemType == SearchItemTypeMore) {
//            return;
//        }
//        YJHomeItemModel *itemModel = self.homeSearchItems[indexPath.row];
//        if (itemModel.searchItemType == SearchItemTypeCarSafe) {//车险
//            CarInsurancSearchVC *cvc = [[CarInsurancSearchVC alloc]init];
//            cvc.searchItemType = itemModel.searchItemType;
//            [self.navigationController pushViewController:cvc animated:YES];
//        }else if ((itemModel.searchItemType == SearchItemTypeHousingFund)|
//                  (itemModel.searchItemType == SearchItemTypeSocialSecurity)) {//公积金社保
//            JHousingFundSocialSecurityVC *cvc = [[JHousingFundSocialSecurityVC alloc]init];
//            cvc.searchItemType = itemModel.searchItemType;
//            [self.navigationController pushViewController:cvc animated:YES];
//        }else{
//            CommonSearchVC *cvc = [[CommonSearchVC alloc]init];
//            cvc.searchItemType = itemModel.searchItemType;
//            [self.navigationController pushViewController:cvc animated:YES];
//        }
//    } else {
//        LoginVC *ll = [[LoginVC alloc]init];
//        //        ll.isFrom = 103;
//        YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
//        [self presentViewController:nav animated:YES completion:nil];
//    }
    
    
    
}



#pragma mark ---检查网络
- (void)checkNet {
    
    __weak typeof(self) weakSelf = self;
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"联网失败，请检查手机网络状态" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
    

        
}


#pragma mark 登录
- (void)showLoginView {
    //    if (![Tool objectForKey:JIsLoginUser]) {
    LoginVC *login = [[LoginVC alloc] init];
//    login.isFrom = 103;
    YJNavigationController *LL = [[YJNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:LL animated:YES completion:^{
        
    }];
    //    }
}











#pragma mark - -定位功能

/**
 *  开启定位
 */
- (void)location {
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locManager startUpdatingLocation];
    } else {
        // 检测网络或者打开定位服务
        
        
    }
}

#pragma mark - -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations firstObject];
    
    [self.reverseGeo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && placemarks.count > 0) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            
            UIButton *locationBtn = _leftItem.customView;
            
            [locationBtn setTitle:placemark.addressDictionary[@"City"] forState:(UIControlStateNormal)];
            
            
            MYLog(@"字典addressDictionary：%@",placemark.addressDictionary);
            
            
            
        } else {
            MYLog(@"编码失败%@",error.localizedDescription);
        }
        
    }];
    
    [manager stopUpdatingLocation];
}





@end
