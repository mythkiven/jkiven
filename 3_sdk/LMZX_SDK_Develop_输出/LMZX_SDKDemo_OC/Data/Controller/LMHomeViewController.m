//
//  LMHomeViewController.m
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/28.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMHomeViewController.h"
#import "LMCollectionReusableView.h"
#import "LMHomeCollectionViewCell.h"
#import "LMHomeTypeModel.h"
#import <CommonCrypto/CommonDigest.h>
#import "LMResultShowVC.h"
#import "LMNavigationController.h"


@interface LMHomeViewController ()
{
    LMZXSDK *_lmzxSDK;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic, strong) NSArray *dataSource;

@end

static NSString *cellId = @"LMHomeCollectionViewCellId";
static NSString *reusableViewId = @"LMCollectionReusableViewId";
@implementation LMHomeViewController
- (NSArray *)dataSource {
    if (!_dataSource) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"homeType" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            LMHomeTypeModel *model = [LMHomeTypeModel homeTypeModelWithDict:dict];
            [temp addObject:model];
        }
        _dataSource = temp;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupUI];
    

    [self initSDK];
    

    [self showResult];
    
    
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -  初始化SDK / 自定义UI

#pragma mark 自定义全局通用的 SDK
- (void)initSDK {

    _lmzxSDK = [LMZXSDK lmzxSDKWithApikey:APIKEY uid:UID callBackUrl:CALLBACKURL];
    
//    // 调试地址 路径中无需拼接 path
//    _lmzxSDK.lmzxTestURL = @"https://t.limuzhengxin.cn";
    // 以下写法错误
    _lmzxSDK.lmzxTestURL = @"https://t.limuzhengxin.cn:3443/api/gateway";

    
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
    
    // 自定义失败时,是否需要退出   默认为NO 不退出
    // _lmzxSDK.lmzxQuitOnFail = NO;
    
    // 自定义查询成功时,是否需要退出   默认为 YES  退出
   //  _lmzxSDK.lmzxQuitOnSuccess = YES;
    
}

#pragma mark 可分别自定义不同功能的回调地址,协议名称,协议 URL,业务模式
// 如果单独设置某一个
-(void)setCustomSDKWithFunction:(NSString*)function{
    // 获取最新的 UID:
    _lmzxSDK.lmzxUid = @"666";
    
    if ([function isEqualToString:@"mobile"]){ // 运营商的 回调地址,业务模式, UI 和其余的功能不同
        // 回调地址
        _lmzxSDK.lmzxCallBackUrl    = @"www.mobilecarrie.com";
        // 业务模式
        _lmzxSDK.lmzxQuitOnSuccess  = NO;
        // 导航条颜色
        _lmzxSDK.lmzxThemeColor =  [UIColor whiteColor];
        // 协议 URL
        _lmzxSDK.lmzxProtocolUrl = @"自主协议";
    }else{
        // 回调地址
        _lmzxSDK.lmzxCallBackUrl    = @"默认 URL";
        // 业务模式
        _lmzxSDK.lmzxQuitOnSuccess  = YES;
        // 导航条颜色
        _lmzxSDK.lmzxThemeColor =  RGB(48, 113, 242);
        // 协议 URL
        _lmzxSDK.lmzxProtocolUrl = @"默认协议";
    }
}
#pragma mark - 启动不同的功能

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LMHomeTypefunction *functionModel = [self.dataSource[indexPath.section] functionModels][indexPath.item];
    __weak typeof(self) wself = self;
    NSString *functionType = functionModel.type ;
    
    
//    // 自定义功能
//    [self setCustomSDKWithFunction:functionType];
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    
    if ([functionType isEqualToString:@"housefund"]) {
        
        // 自定义功能
        //[self setCustomSDKWithFunction:LMZXSDKFunctionHousingFund];
        
        [_lmzxSDK startFunction:LMZXSDKFunctionHousingFund
                   authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"socialsecurity"]) {
        [_lmzxSDK startFunction:LMZXSDKFunctionSocialSecurity authCallBack:^(NSString *authInfo) {
           [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"mobile"]) {
        
        [_lmzxSDK startFunction:LMZXSDKFunctionMobileCarrie authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
    } else if ([functionType isEqualToString:@"jd"]) {
        
        [_lmzxSDK startFunction:LMZXSDKFunctionJD authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"taobao"]) {
        
        
        
        [_lmzxSDK startFunction:LMZXSDKFunctionTaoBao authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"education"]) {
        
        [_lmzxSDK startFunction:LMZXSDKFunctionEducation authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"credit"]) {
      
        [_lmzxSDK startFunction:LMZXSDKFunctionCentralBank authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"bill"]) {
        // 分别设置协议名
        //_lmzxSDK.lmzxProtocolTitle =  @"《163协议》**《126协议》**《qq协议》**《sina协议》**《139协议》";
        [_lmzxSDK startFunction:LMZXSDKFunctionCreditCardBill authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"ebank"]) {
        
        [_lmzxSDK startFunction:LMZXSDKFunctionEBankBill authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
        
    } else if ([functionType isEqualToString:@"autoinsurance"]) {
        [_lmzxSDK startFunction:LMZXSDKFunctionAutoinsurance authCallBack:^(NSString *authInfo) {
            [wself post:authInfo];
        }];
    }
}


#pragma mark - 监听结果回调
- (void)showResult {
    
    __block typeof(self) weakSelf = self;
    __block typeof(_lmzxSDK) weakLMSDK = _lmzxSDK;
    _lmzxSDK.lmzxResultBlock = ^(NSInteger code, LMZXSDKFunction function, id obj, NSString * token){
        NSLog(@"SDK回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
        
        // 登录成功退出 SDK
        if (weakLMSDK.lmzxQuitOnSuccess==NO && code==2) {
            NSLog(@"登录成功:SDK回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            // 运营商结果处理
            if (function == LMZXSDKFunctionMobileCarrie) {
                NSLog(@"查询成功:运营商回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            }
            // 淘宝结果处理
            else if (function == LMZXSDKFunctionTaoBao) {
                NSLog(@"查询成功:淘宝回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            }
            // ....
        }
        // 查询成功退出 SDK
        else if (weakLMSDK.lmzxQuitOnSuccess==YES&& code==0) {
            // 运营商结果展示
            if (function == LMZXSDKFunctionMobileCarrie) {
                NSLog(@"查询成功:运营商回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            }
            // 淘宝结果展示
            else if (function == LMZXSDKFunctionTaoBao) {
                NSLog(@"查询成功:淘宝回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            }
            // ....
        }else{
            NSLog(@"查询失败:SDK回调结果==%ld,%d,%@,%@",(long)code,function,obj,token);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LMResultShowVC *resultVc = [[LMResultShowVC alloc] init];
            resultVc.function = function;
            resultVc.taskId = token;
            LMNavigationController *navResultVC = [[LMNavigationController alloc]
                                                   initWithRootViewController:resultVc];
            [weakSelf presentViewController:navResultVC
                                   animated:YES
                                 completion:nil];
        });
        
    };
    
    
}

#pragma mark - 签名

#pragma mark 模拟服务器端加签
- (void)post:(NSString*)authInfo{
    
    
    
    __block typeof(self) wself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:
                                       [NSURL URLWithString:@"www.baidu.com"]
                                       cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        
        [request setHTTPMethod:@"GET"];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [wself sign:authInfo];
            
        }];
        
        [dataTask resume];
    });
    
}

//签名算法如下：
//1. 将立木回调参数 authInfo 和 APISECRET 直接拼接；
//2. 将上述拼接后的字符串进行SHA-1计算，并转换成16进制编码；
//3. 将上述字符串转换为全小写形式后即获得签名串
- (void )sign:(NSString*)string
{
    
    NSString *sign = [string stringByAppendingString:APISECRET];
    NSMutableString *mString = [NSMutableString stringWithString:sign];
    NSString *newsign ;
    // 3、对该字符串进行SHA-1计算，得到签名，并转换成16进制小写编码,得到签名串
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [mString dataUsingEncoding: NSUTF8StringEncoding];
    
    if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
        NSMutableString *digestString = [NSMutableString stringWithCapacity:
                                         CC_SHA1_DIGEST_LENGTH];
        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            unsigned char aChar = digest[i];
            [digestString appendFormat:@"%02X", aChar];
        }
        newsign =[digestString lowercaseString];
        
    }
    
    [[LMZXSDK shared] sendReqWithSign:newsign];
    
}


#pragma mark -

- (void)setupUI {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LMHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LMCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewId];
    self.collectionView.showsVerticalScrollIndicator = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSource[section] functionModels].count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LMHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.functionModel = [self.dataSource[indexPath.section] functionModels][indexPath.item];
    
    
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LMCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewId forIndexPath:indexPath];
    headerView.title = [self.dataSource[indexPath.section] groupTitle];
     headerView.lineColor = [self.dataSource[indexPath.section] titleColor];
    return headerView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width*0.5, 65);
}







@end
