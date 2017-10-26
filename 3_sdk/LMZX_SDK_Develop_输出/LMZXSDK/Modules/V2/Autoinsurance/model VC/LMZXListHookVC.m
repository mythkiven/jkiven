//
//  CitySelectVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "LMZXListHookVC.h"
#import "LMZXListHookCell.h"

#import "LMZXListHookModel.h"
#import "UIImage+LMZXTint.h"

#import "LMZXFactoryView.h"
#import "UIViewController+LMZXBackButtonHandler.h"

#import "LMZXWebNetWork.h"

#import "LMZXHTTPTool.h"
@interface LMZXListHookVC ()




@end

static NSCache *lmCache = nil ;

@implementation LMZXListHookVC
{
    LMZXListHookModel *_cityModel;
    BOOL normalSelectCity;//是否默认
    NSInteger _isfirst;
    UIActivityIndicatorView * _activityIndicatorView;
    UIView *_cover;
    // 信用卡的model
    NSMutableArray *_dataSource;
    //    reportCreditBillModel *_reportCreditBillModel;
    NSMutableDictionary *_ImageData;
    NSMutableDictionary *_ImgOperations;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isfirst ++;
    if (_listData.count<1 &&_isfirst>2) {
        [_activityIndicatorView startAnimating];
        switch (self.searchItemType) {
            case SearchItemTypeCreditCardBill:{ //信用卡
                break;
            }case SearchItemTypeCarSafe:{ //车险
                if (self.url) {
                    [self getData:self.url];
                } else {
                    [self getData:@"?bizType=autoinsurance"];
                }
                break;
            }case SearchItemTypeNetBankBill:{//网银
                [self getData:@"?bizType=ebank"];
                break;
            }default:
                break;
        }
    }else{
        [self.tableView reloadData];
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isfirst =1;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    indicator.center = CGPointMake(LM_SCREEN_WIDTH * 0.5, LM_SCREEN_HEIGHT * 0.5-30);
    [self.tableView addSubview:indicator];
    _activityIndicatorView = indicator;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
        self.tableView.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
        self.tableView.backgroundColor = LM_RGB(245, 245, 245);
    }
    
    [_activityIndicatorView startAnimating];
    
    _listData = [NSMutableArray arrayWithCapacity:0];
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    _ImageData = [NSMutableDictionary dictionaryWithCapacity:0];
    _ImgOperations = [NSMutableDictionary dictionaryWithCapacity:0];
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{ //信用卡
            
            break;
            
        }case SearchItemTypeCarSafe:{ //车险
            self.title = @"汽车保险";
            
            if (_listData.count<1) {
                if (self.url) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getData:self.url];
                    });
                    
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getData:@"?bizType=autoinsurance"];
                    });
                    
                }
                
            }else{
                [self creatCriteView:_listData];
            }
            
            break;
            
        }case SearchItemTypeNetBankBill:{//网银
            self.title = @"网银流水";
            
            if (_listData.count<1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getData:@"?bizType=ebank"];
                });
                
            }else{
                [self creatCriteView:_listData];
            }
            break;
            
        }default:
            break;
    }
    
    
}


-(void)getData:(NSString*)path {
    __block typeof(self) sself = self;
    
    [LMZXHTTPTool post:[LMZXSDK_ListConfig_URL stringByAppendingString:path] params:nil success:^(id obj) {
        //[LMZXWebNetWork get:[LMZXSDK_ListConfig_URL stringByAppendingString:path] timeoutInterval:0 success:^(id obj) {
        BOOL obj1 =[obj isKindOfClass:[NSNull class]];
        BOOL obj2 =[obj isKindOfClass:[NSString class]];
        
        if (obj1 | obj2) {
            dispatch_async (dispatch_get_main_queue(),^{
                [sself.view makeToast:@"数据请求失败,请稍后重试"];
                [_activityIndicatorView stopAnimating];
            });
        }else if ([obj isKindOfClass:[NSArray class]] ) {
            NSArray *arr=(NSArray*)obj;
            switch (sself.searchItemType) {
                case SearchItemTypeCreditCardBill:{ //信用卡
                    
                    break;
                    
                }case SearchItemTypeCarSafe:{ //车险
                    
                    LMZXSourceALLDataList *model = [[LMZXSourceALLDataList alloc]initWithCarInsurancDic:arr.firstObject];
                    if (_listData&&_listData.count>=1) {
                        [_listData removeAllObjects];
                    }
                    _listData = model.items;
                    
                    [sself creatCriteView:@[]];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        for (NSInteger i=0; i<_listData.count; i++) {
                            LMZXListHookModel *md = _listData[i];
                            [sself  getUrlImg:md.companyCarInsuranc.logo index:i];
                        }
                    });
                    
                    break;
                }case SearchItemTypeNetBankBill:{//网银
                    
                    LMZXSourceALLDataList *model = [[LMZXSourceALLDataList alloc]initWithEBankDic:arr.firstObject];
                    if (_listData&&_listData.count>=1) {
                        [_listData removeAllObjects];
                    }
                    _listData = model.items;
                    
                    [sself creatCriteView:@[]];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        for (NSInteger i=0; i<_listData.count; i++) {
                            LMZXListHookModel *md = _listData[i];
                            [sself  getUrlImg:md.eBankListModel.logo index:i];
                        }
                    });
                    
                    break;
                    
                }default:
                    break;
            }
            
        }
    } failure:^(NSString *error) {
        //} failure:^(NSError *error) {
        [self.view makeToast:@"数据请求失败,请稍后重试"];
        [_activityIndicatorView stopAnimating];
    }];
    
}

#pragma mark 创建视图 获取图片 -2

-(void)getUrlImg:(NSString*)urlP index:(NSInteger)index {
    
    
    if (!lmCache) {
        lmCache = [[NSCache alloc] init];
    }
    __block typeof(self) sself = self;
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:index inSection:0];
                NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
                [sself.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                
                if (_ImageData.allKeys.count>=_listData.count) {
                    //                    [sself.tableView reloadData];
                }
            });
            
            
            
        }];
        _ImgOperations[urlP] = opp;
        [queue addOperation:opp];
    }
    
}


#pragma mark - 创建页面
-(void)creatCriteView:(NSArray*)arr{
    // [_dataSource removeAllObjects];
    
    NSString*title;
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
            title = @"银行/卡号";
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            
            title = @"公司";
            
            break;
            
        }case  SearchItemTypeNetBankBill:{//网银
            title = @"银行";
            
            break;
            
        }default:
            break;
    }
    
    
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0,LM_SCREEN_WIDTH, 44)];
    header.backgroundColor =[UIColor whiteColor];
    
    UIView *line = [LMZXFactoryView JLineWithSuper:header];
    line.frame = CGRectMake(0, 0, LM_SCREEN_WIDTH, 0.5);
    
    UIView *line2 = [LMZXFactoryView JLineWithSuper:header];
    line2.frame = CGRectMake(0, 44, LM_SCREEN_WIDTH, 0.5);
    
    UILabel *label = [LMZXFactoryView JlabelWith:CGRectMake(15, 0.5, LM_SCREEN_WIDTH, 43.5) Super:header Color:[UIColor blackColor] Font:17 Alignment:0 Text:title];
    label.backgroundColor = [UIColor whiteColor];
    
    UIView *l = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH-15, 0.7)];
    l.backgroundColor = LM_RGBGrayLine;
    self.tableView.tableHeaderView = l;
    
    
    
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidden =YES;
    [_activityIndicatorView removeFromSuperview];
    _activityIndicatorView = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView reloadInputViews];
    });
    
    
}
#pragma mark - 记录查询
-(void)checkDetailReport{
    
}


#pragma mark - 首页查询
- (void)laodHouseFundData {
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
            //            return 45;
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            
            break;
            
        }default:
            break;
    }
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMZXListHookCell *cell = [LMZXListHookCell subjectCellWithTabelView:tableView];
    cell.listHookModel = self.listData[indexPath.row];
    
    
    
    switch (self.searchItemType) {
        case SearchItemTypeCarSafe:{// 车险
            LMZXListHookModel *md = self.listData[indexPath.row];
            cell.imgData =   [UIImage imageWithData:_ImageData[md.companyCarInsuranc.logo]];
            break;
        }case SearchItemTypeNetBankBill:{// 网银流水
            LMZXListHookModel *md = self.listData[indexPath.row];
            cell.imgData =   [UIImage imageWithData:_ImageData[md.eBankListModel.logo]];;
            break;
        }default:
            break;
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor whiteColor];
    cell.backgroundColor =[UIColor whiteColor];
    __block typeof(self) sself = self;
    cell.tapListHookCell =^(LMZXListHookModel *model){
        BOOL ss = model.selected;
        for (LMZXListHookModel *modelD in _listData) {
            modelD.selected = NO;
        }
        model.selected = ss;
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself.tableView reloadData];
        });
        if (sself.searchItemType == SearchItemTypeCarSafe | sself.searchItemType == SearchItemTypeNetBankBill) {// 车险 //网银
            if (sself.selectedOneCity) {
                sself.selectedOneCity(model);
            }
            [sself jPopSelfWith:0.3];
            
        }else if (sself.searchItemType == SearchItemTypeCreditCardBill){// 信用卡
            
            //            YJRepoortCreditEmailBillDetailsVC *vc =[[YJRepoortCreditEmailBillDetailsVC alloc] init];
            //            vc.mainModel = _dataSource[indexPath.row];
            //            [self performSelector:@selector(pushCreditEmailBillDetailsVC:) withObject:vc afterDelay:0.3];
            
        }
        
        
        
    };
    
    
    
    return cell;
    
}
-(void)pushCreditEmailBillDetailsVC:(UIViewController*)vc{
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    //    __weak typeof(self) weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    return @[action];
}

@end

