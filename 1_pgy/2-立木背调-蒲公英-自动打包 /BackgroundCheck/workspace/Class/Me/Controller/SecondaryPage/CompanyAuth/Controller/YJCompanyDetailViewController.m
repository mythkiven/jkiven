//
//  YJCompanyDetailViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCompanyDetailViewController.h"
#import "YJBaseItem.h"
#import "CompanyDetailModel.h"
#import "YJIPhotoView.h"
#import "YJMeCell.h"
#import "YJCompanyDetailManager.h"
@interface YJCompanyDetailViewController ()<YJIPhotoViewDelegate>
    {
        UIImageView *_licenseImgView;
        UIView *_picBgView;
        CompanyDetailModel *_companyDetailModel;
        
        UIImageView *_beginAnimationView;
        CGRect _fromRect;
    }
    
    
    @property (nonatomic, strong) NSDictionary *dict;
    @end

@implementation YJCompanyDetailViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"资质认证";
    self.view.backgroundColor = RGB_pageBackground;
    
    self.companyDetailModel = [YJCompanyDetailManager companyInfo];
    //    if (self.companyDetailModel) {
    //        [self creatUI];
    //    } else {
    //        [self getCompanyInfoFromNet];
    //    }
    
    [self creatUI];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
}
- (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
            MYLog(@"企业认证成功---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
                
                weakSelf.companyDetailModel = companyDetailModel;
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                user.companyName = companyDetailModel.companyName;
                [YJUserManagerTool saveUser:user];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self creatUI];
                });
                
            } else {
                MYLog(@"企业未认证---%@",responseObj[@"data"]);
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = @"0";
                [YJUserManagerTool saveUser:user];
            }
            
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证失败---%@",error);
            
        }];
    }
    
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
}
    
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_picBgView removeFromSuperview];
    
}
    
    
    
- (void)setupAuthIngTipView {
    if ([self.companyDetailModel.status isEqualToString:@"00"]) {
        UILabel *tipLB = [[UILabel alloc] init];
        tipLB.text = @"资质认证正在审核中......";
        tipLB.textAlignment = NSTextAlignmentCenter;
        tipLB.backgroundColor = RGB(255, 243, 184);
        tipLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        tipLB.font = Font13;
        tipLB.textColor = RGB(242,65,48);
        tipLB.layer.borderColor = RGB_grayLine.CGColor;
        tipLB.layer.borderWidth = 0.5;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = RGB_pageBackground;
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        [bgView addSubview:tipLB];
        self.tableView.tableHeaderView = bgView;
    }
}
    
    
    
    
- (void)creatUI {
    [self creatgroup0];
    
    [self setupFooterView];
    
    [self setupAuthIngTipView];
    
    [self.tableView reloadData];
    
}
    
- (void)creatgroup0 {
    //    __weak typeof(self) weakSelf = self;
    
    YJBaseItem *item0 = [YJBaseItem itemWithTitle:@"企业名称" subTitle:self.companyDetailModel.companyName];
    
    YJBaseItem *item1 = [YJBaseItem itemWithTitle:@"所在地" subTitle:[NSString stringWithFormat:@"%@  %@",self.companyDetailModel.companyProvince,self.companyDetailModel.companyCity]];
    
    
    YJBaseItem *item2 = [YJBaseItem itemWithTitle:@"详细地址" subTitle:self.companyDetailModel.companyAddress];
    
    
    YJBaseItem *item3 = [YJBaseItem itemWithTitle:@"证件类型" subTitle:self.companyDetailModel.certiTypestr];
    
    NSString *title = nil;
    if ([self.companyDetailModel.certiType isEqualToString:@"00"]) {
        title = @"营业执照号";
    } else if ([self.companyDetailModel.certiType isEqualToString:@"01"]) {
        title = @"注册号";
    }
    YJBaseItem *item4 = [YJBaseItem itemWithTitle:title subTitle:self.companyDetailModel.busiLicenseCode];
    
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0,item1,item2,item3,item4];
    
    [self.dataSource addObject:group];
    
    
}
    
    
    
- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.frame = CGRectMake(15, 10, SCREEN_WIDTH - 40, 30);
    titleLB.font = Font15;
    titleLB.text = @"营业执照";
    [footerView addSubview:titleLB];
    
    UIImageView *licenseImgView = [[UIImageView alloc] init];
    _licenseImgView = licenseImgView;
    licenseImgView.userInteractionEnabled = YES;
    licenseImgView.image = [self licsencePic];
    licenseImgView.center = footerView.center;
    licenseImgView.bounds = CGRectMake(0, 0, 250, 200);
    [footerView addSubview:licenseImgView];
    
    //给licenseImgView添加事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    
    [licenseImgView addGestureRecognizer:tap];
    
    
    self.tableView.tableFooterView = footerView;
    
}
    
    /**
     *  获取营业执照
     *
     */
- (UIImage *)licsencePic {
    NSString *imgDataStr = self.companyDetailModel.busiLicensePicture;
    if (imgDataStr) {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imgDataStr options:(NSDataBase64DecodingIgnoreUnknownCharacters)] ;
        UIImage *img =[UIImage imageWithData:imageData];
        return img;
    }
    return nil;
}
    
    /**
     *  点击图片
     *
     *  @param tap 点击手势
     */
- (void)tapPicture:(UITapGestureRecognizer *)tap {
    
    
//    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect fromRect = [_licenseImgView.superview convertRect:_licenseImgView.frame toView:window];
    _fromRect = fromRect;
    
    UIImageView *beginAnimationView = [[UIImageView alloc] initWithFrame:fromRect];
    _beginAnimationView = beginAnimationView;
    beginAnimationView.image = [self licsencePic];
    beginAnimationView.clipsToBounds = YES;
    beginAnimationView.userInteractionEnabled = YES;
    beginAnimationView.contentMode = UIViewContentModeScaleAspectFit;
    beginAnimationView.backgroundColor = [UIColor blackColor];
    [window addSubview:beginAnimationView];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        beginAnimationView.layer.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        MYLog(@"---%d",finished);
        if (finished) {
            beginAnimationView.hidden = YES;
            YJIPhotoView *picView = [[YJIPhotoView alloc] init];
            picView.delegate = self;
            [window addSubview:picView];
            picView.frame = [UIScreen mainScreen].bounds;
            
            picView.pic = [self licsencePic];
        }
    }];
    
}
    
    
#pragma mark YJIPhotoViewDelegate
- (void)photoViewhandleSingleTap:(YJIPhotoView *)view {
    [view removeFromSuperview];
    _beginAnimationView.hidden = NO;
    _beginAnimationView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        _beginAnimationView.layer.frame = _fromRect;
    } completion:^(BOOL finished) {
        _beginAnimationView.hidden = YES;
        [_beginAnimationView removeFromSuperview];
    }];
    
}
    
    
    //移除
-(void)removeBigButton:(UIButton*)button{
    
    [_picBgView removeFromSuperview];//从父视图移除
}
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
    cell.textLabel.font = Font15;
    YJItemGroup *group = self.dataSource[indexPath.section];
    YJBaseItem *item = group.groups[indexPath.row];
    cell.item = item;
    [cell.accessoryArrowBtn setTitleColor:RGB_grayNormalText forState:(UIControlStateDisabled)];
    
    if (group.groups.count-1 == indexPath.row) {
        UIView *separateLine1 = [[UIView alloc] init];
        separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
        separateLine1.backgroundColor = RGB_grayLine;
        [cell.contentView addSubview:separateLine1];
        
    }
    
    return cell;
}
    
    
    
    @end

