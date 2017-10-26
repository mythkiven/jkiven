//
//  LMZXCreditBillGuideVC.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/9.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXCreditBillGuideVC.h"
#import "LMZXDemoAPI.h"
#import "LMZXCreditBillWebVC.h"
#import "LMZXFactoryView.h"
#import "LMZXListHookModel.h"
//#import "UIButton+LMZXWebCache.h"
#import "LMZXImageBtn.h"
#import "LMZXTool.h"
#import "LMZXCreditBillNativeVC.h"


// 成功 URL
#define LMZX_LocationSuccess_TypeURL @"LM_ZXLocationSuccSesstion_TypeURL"
// 登录 URL
#define LMZX_LocationLogin_TypeURL @"LM_ZXLocationLogiSesstion_TypeURL"
// 信用卡账单 当前哪个功能
#define LMZX_LocationFunction_TypeURL @"LM_ZXLocationfuncSesstion_TypeURL"


@interface LMZXCreditBillGuideVC ()
@property (assign,nonatomic) BOOL    saveCookie;



@end



static NSCache *lmCache = nil ;

@implementation LMZXCreditBillGuideVC
{
    LMZXCreditCardBillMailType _type;
    NSMutableArray *_listData;
    NSMutableDictionary *_ImageData;
    NSMutableDictionary *_ImageOData;
    NSMutableDictionary *_ImgOperations;
    UIActivityIndicatorView * _activityIndicatorView;
    NSMutableDictionary *_webviewConfig;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡账单";
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    indicator.center = CGPointMake(LM_SCREEN_WIDTH * 0.5, LM_SCREEN_HEIGHT * 0.5-30);
    [self.view addSubview:indicator];
    _activityIndicatorView = indicator;
    
    _listData = [NSMutableArray arrayWithCapacity:0];
    [self addDemoView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.activityIndicatorView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_listData.count ) {
        [_activityIndicatorView startAnimating];
    }else{
    }
    
}



#pragma mark - 创建视图 -1
-(void)addDemoView{
    if (!_ImageData) {
        _ImageData = [[NSMutableDictionary alloc]init];
    }
    if (!_ImgOperations) {
        _ImgOperations = [[NSMutableDictionary alloc]init];
    }
    
    __block typeof(self) sself = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [LMZXWebNetWork get:[LMZXSDK_ListConfig_URL stringByAppendingString:@"?bizType=bill"] timeoutInterval:LMZX_WebTimeIntervale success:^(id obj) {
            BOOL obj1 =[obj isKindOfClass:[NSNull class]];
            BOOL obj2 =[obj isKindOfClass:[NSString class]];
            
            if (obj1 | obj2) {
                dispatch_async (dispatch_get_main_queue(),^{
                    [sself.view makeToast:@"数据请求失败,请稍后重试"];
                    [_activityIndicatorView stopAnimating];
                });
            }else if ([obj isKindOfClass:[NSArray class]] ) {
                NSArray *arr = obj;
                if (arr.count==1) {
                    
                    LMZXSourceALLDataList *model = [[LMZXSourceALLDataList alloc]initWithEBankDic:arr.firstObject];
                    if (_listData) {
                        [_listData removeAllObjects];
                    }
                    _listData =  [model.items mutableCopy];
                    
                    if (_listData.count==5) {
                        // [self.seeBTn setImage:[UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_eye_hide"] forState:(UIControlStateNormal)];
                        NSArray *arr = @[@"lmzx_xy_126",@"lmzx_xy_163",@"lmzx_xy_139",@"lmzx_xy_qq",@"lmzx_xy_sina"];
                        BOOL too=YES;
                        if (!_ImageData) {
                            _ImageData = [NSMutableDictionary dictionaryWithCapacity:0];
                        }
                        if (_ImageData.count>1) {
                            [_ImageData removeAllObjects];
                        }
                        for (int i=0;i<_listData.count;i++) {
                            UIImage *image = [UIImage imageFromBundle:@"lmzxResource" name:arr[i]];
                            if (!image) {
                                too =NO;
                            }else{
                                LMZXListHookModel *md = _listData[i];
                                if ([md.eBankListModel.code isEqualToString:@"126"]) {
                                    [_ImageData setObject: UIImagePNGRepresentation([UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_xy_126"])  forKey:md.eBankListModel.logo];
                                } else if ([md.eBankListModel.code isEqualToString:@"163"]) {
                                    [_ImageData setObject: UIImagePNGRepresentation([UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_xy_163"])  forKey:md.eBankListModel.logo];
                                }else if ([md.eBankListModel.code isEqualToString:@"139"]) {
                                    [_ImageData setObject: UIImagePNGRepresentation([UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_xy_139"])  forKey:md.eBankListModel.logo];
                                }else if ([md.eBankListModel.code isEqualToString:@"qq"]) {
                                    [_ImageData setObject: UIImagePNGRepresentation([UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_xy_qq"])  forKey:md.eBankListModel.logo];
                                }else if ([md.eBankListModel.code isEqualToString:@"sina"]) {
                                    [_ImageData setObject: UIImagePNGRepresentation([UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_xy_sina"])  forKey:md.eBankListModel.logo];
                                }
                            }
                        }
                        if (too==NO) { // 本地无数据,从网络加载
                            [_ImageData removeAllObjects];
                            for (LMZXListHookModel *md in _listData) {
                                [sself  getUrlImg:md.eBankListModel.logo];
                            }
                        }else{ // 本地有数据,直接加载本地数据
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [sself initView];
                            });
                        }
                    }else{
                        for (LMZXListHookModel *md in _listData) {
                            [sself  getUrlImg:md.eBankListModel.logo];
                        }
                    }
                    
                    
                    
                    dispatch_async (dispatch_get_main_queue(),^{
                        [_activityIndicatorView stopAnimating];
                    });
                }else{
                    dispatch_async (dispatch_get_main_queue(),^{
                        [sself.view makeToast:@"数据请求失败,请稍后重试"];
                        [_activityIndicatorView stopAnimating];
                    });
                }
                
                
            }else{
                dispatch_async (dispatch_get_main_queue(),^{
                    [sself.view makeToast:@"数据请求失败,请稍后重试"];
                    [_activityIndicatorView stopAnimating];
                });
            }
            
        } failure:^(NSError *error) {
            dispatch_async (dispatch_get_main_queue(),^{
                [sself.view makeToast:@"数据请求失败,请稍后重试"];
                [_activityIndicatorView stopAnimating];
            });
            
        }];
        
        
    });
    
    
    
}

#pragma mark 创建视图 获取图片 -2

-(void)getUrlImg:(NSString*)urlP {
    
    if (!lmCache) {
        lmCache = [[NSCache alloc] init];
    }
    
    __block NSData * data;
    NSURL *url = [NSURL URLWithString:urlP];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *opp = _ImgOperations[urlP];
    if (opp == nil) {
        [lmCache setObject:[NSNull null] forKey:urlP];
        
        opp = [NSBlockOperation blockOperationWithBlock:^{
            data = [NSData dataWithContentsOfURL:url];
            if (data == nil) {
                [_ImgOperations removeObjectForKey:urlP];
                return ;
            }
            [lmCache setObject:data forKey:urlP];
            [_ImageData setObject:data forKey:urlP];
            [_ImgOperations removeObjectForKey:urlP];
            if (_ImageData.allKeys.count>=5) {
                
                dispatch_queue_t asynchronousQueue = dispatch_get_main_queue();
                dispatch_async(asynchronousQueue, ^{
                    [self initView];
                });
                
                
            }
            
        }];
        _ImgOperations[urlP] = opp;
        [queue addOperation:opp];
    }
    
}
#pragma mark 创建视图 添加图片 -3
-(void)initView{
    
    __block typeof(self) sself =self;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)];
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        scrollView.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    } else {
        scrollView.backgroundColor =[UIColor whiteColor];
    }
    
    [self.view addSubview:scrollView];
    //        NSArray *Img = @[@"lmzx_yx_163_",@"lmzx_yx_126_",@"lmzx_yx_139_",@"lmzx_yx_sina_",@"lmzx_yx_QQ_",];
    UILabel*title = [LMZXFactoryView labelWithFrame:CGRectMake(15, 0, LM_SCREEN_WIDTH-15, 40) super:scrollView Color:[UIColor blackColor] Font:15.0 Alignment:0 Text:@"请选择信用卡账单邮箱"];
    
    [LMZXFactoryView JLineWith:CGRectMake(0, CGRectGetMaxY(title.frame), LM_SCREEN_WIDTH, 0.5) Super:scrollView tag:0];
    
    
    
    if (_listData.count) {
        for(int i = 0;i < _listData.count; i++){
            
            
            LMZXListHookModel *model = _listData[i];
            LMZXEBankListModel *mm = model.eBankListModel;
            
            LMZXImageBtn *newbtn = [[LMZXImageBtn alloc] initWithFrame:CGRectMake(0, 40.5+(70+1)*i, LM_SCREEN_WIDTH, 70)];
            [newbtn setBackgroundColor:[UIColor whiteColor]];
            
            // LMZXCreditCardBillMailType163 = 0,
            //LMZXCreditCardBillMailType126 , //1
            //LMZXCreditCardBillMailType139,//2
            //LMZXCreditCardBillMailTypesina,//3
            //LMZXCreditCardBillMailTypeQQ  ,//4
            //LMZXCreditCardBillMailTypealiyun,
            
            if ([mm.code isEqualToString:@"126"]) {
                newbtn.tag = 91;
            } else if ([mm.code isEqualToString:@"163"]) {
                newbtn.tag = 90;
            }else if ([mm.code isEqualToString:@"139"]) {
                newbtn.tag = 92;
            }else if ([mm.code isEqualToString:@"qq"]) {
                newbtn.tag = 94;
            }else if ([mm.code isEqualToString:@"sina"]) {
                newbtn.tag = 93;
            }
            UIImage *img = [UIImage imageWithData:_ImageData[mm.logo]];
            
            [newbtn setImage:img forState:UIControlStateNormal];
            [newbtn setImage:img forState:UIControlStateSelected];
            [newbtn setImage:img forState:UIControlStateHighlighted];
            newbtn.contentMode  = UIViewContentModeScaleAspectFill;
            [newbtn addTarget:self action:@selector(importCredit:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollView addSubview:newbtn];
            
            [LMZXFactoryView JLineWith:CGRectMake(0, CGRectGetMaxY(newbtn.frame)+0.5, LM_SCREEN_WIDTH, 0.5) Super:scrollView tag:0];
        }
    }
    
    
    [self.view addSubview: scrollView];
    [self.view reloadInputViews];
    
    [_activityIndicatorView stopAnimating];
    
    dispatch_async (dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [sself GET:nil];
    });
    
    
}

#pragma mark  跳转
-(void)importCredit:(UIButton*)btn{
    _type = (int)(btn.tag - 90);
    
    NSArray *tArr=nil;
    if ([LMZXSDK shared].lmzxProtocolTitle) {
        tArr = [[LMZXSDK shared].lmzxProtocolTitle componentsSeparatedByString:@"**"];
        if (tArr.count==5) {
        }else{
            tArr = nil;
        }
    }
    NSString*protocolStr=nil;
    
    //  0  1  2   3    4   5
    // 163 126 qq sina 139 顺序
    
    if (_webviewConfig.allValues.count>0) {
        LMZXAnalysisWebModel *mm ;
        switch (_type) {
            case LMZXCreditCardBillMailType163:{
                mm =  _webviewConfig[@"163"];
                if (tArr) {
                    protocolStr = tArr[0];
                }else{
                    protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
                }
                
                break;
            }case LMZXCreditCardBillMailType126:{
                mm =  _webviewConfig[@"126"];
                if (tArr) {
                    protocolStr = tArr[1];
                }else{
                    protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
                }
                break;
            }case LMZXCreditCardBillMailType139:{
                mm =  _webviewConfig[@"139"];
                if (tArr) {
                    protocolStr = tArr[4];
                }else{
                    protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
                }
                break;
            }case LMZXCreditCardBillMailTypesina:{
                mm =  _webviewConfig[@"sina"];
                if (tArr) {
                    protocolStr = tArr[3];
                }else{
                    protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
                }
                break;
            }case LMZXCreditCardBillMailTypeQQ:{
                mm =  _webviewConfig[@"qq"];
                if (tArr) {
                    protocolStr = tArr[2];
                }else{
                    protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
                }
                break;
            }case LMZXCreditCardBillMailTypealiyun:{
                mm =  _webviewConfig[@"aliyun"];
                break;
            }
            default:
                break;
        }
        
        LMZXCreditBillWebVC *jvc = [[LMZXCreditBillWebVC alloc] init];
        jvc.analyModel = mm;
        
        if ([jvc.analyModel.items.isWebLogin isEqualToString:@"1"]) {
            [self jumpH5:jvc];
        }else{
            // 原生页面
            LMZXCreditBillNativeVC *nati =[[LMZXCreditBillNativeVC alloc]init];
            nati.lmzxThemeColor  = [LMZXSDK shared].lmzxThemeColor;
            nati.lmzxTitleColor  = [LMZXSDK shared].lmzxTitleColor;
            nati.lmzxProtocolTextColor  = [LMZXSDK shared].lmzxProtocolTextColor;
            nati.lmzxSubmitBtnColor  = [LMZXSDK shared].lmzxSubmitBtnColor;
            nati.lmzxPageBackgroundColor   = [LMZXSDK shared].lmzxPageBackgroundColor;
            nati.lmzxProtocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            nati.lmzxProtocolTitle =  [LMZXSDK shared].lmzxProtocolTitle;
            nati.searchItemType = SearchItemTypeCreditCardBill;
            nati.type = _type;
            nati.protocolTitle = protocolStr;
            [self.navigationController pushViewController:nati animated:YES];
            
        }
        
    } else {
        [self GET:@"NULL"];
    }
    
    
    
    
}


-(void)jumpH5:(LMZXCreditBillWebVC*)_lmzxWebView{
    
    // 主题颜色
    _lmzxWebView.lmzxThemeColor =  [LMZXSDK shared].lmzxThemeColor;
    // title 颜色
    _lmzxWebView.lmzxTitleColor = [LMZXSDK shared].lmzxTitleColor;
    // 协议文字颜色
    _lmzxWebView.lmzxProtocolTextColor = [LMZXSDK shared].lmzxProtocolTextColor;
    // 提交按钮颜色
    _lmzxWebView.lmzxSubmitBtnColor = [LMZXSDK shared].lmzxSubmitBtnColor;
    // 页面背景色
    _lmzxWebView.lmzxPageBackgroundColor =  [LMZXSDK shared].lmzxPageBackgroundColor;
    
    // 协议    protocolUrl:
    _lmzxWebView.lmzxProtocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
    _lmzxWebView.lmzxProtocolTitle = [LMZXSDK shared].lmzxProtocolTitle;
    _lmzxWebView.saveCookie = _saveCookie;
    //默认 QQ
    _lmzxWebView.type = _type;
    
    [self.navigationController pushViewController:_lmzxWebView animated:YES];
}


#pragma mark - 网络请求 设置拦截 URL
-(void)GET:(NSString*)str{
    if (!_webviewConfig) {
        _webviewConfig = [NSMutableDictionary dictionaryWithCapacity:0];
    } else {
        [_webviewConfig removeAllObjects];
    }
    
    __block typeof(self) sself =self;
    [LMZXWebNetWork get:[LMZXSDK_webConfig_URL stringByAppendingString:@"?bizType=bill"] timeoutInterval:LMZX_WebTimeIntervale success:^(id obj) {
        
        BOOL obj1 =[obj isKindOfClass:[NSNull class]];
        BOOL obj2 =[obj isKindOfClass:[NSString class]];
        
        if (obj1 | obj2) {
            dispatch_async (dispatch_get_main_queue(),^{
                [sself.view makeToast:@"数据请求失败,请稍后重试"];
                [_activityIndicatorView stopAnimating];
            });
        }else if ([obj isKindOfClass:[NSArray class]] ) {
            
            NSArray *arr = (NSArray*)obj;
            
            if (arr.count) {
                for (NSDictionary *dic in arr) {
                    LMZXAnalysisWebModel *model  = [[LMZXAnalysisWebModel alloc]initWithDic:dic];
                    NSString *key = [model.type componentsSeparatedByString:@"-"].lastObject;
                    [_webviewConfig setValue:model  forKey:key];
                }
                
                if ([str isEqualToString:@"NULL"]) {
                    [self importCredit:nil];
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


@end
