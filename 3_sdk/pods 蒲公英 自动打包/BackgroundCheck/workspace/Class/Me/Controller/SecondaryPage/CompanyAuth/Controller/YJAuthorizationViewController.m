//
//  YJAuthorizationViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  企业认证

#import "YJAuthorizationViewController.h"
#import "YJBaseItem.h"
#import "YJTextItem.h"
#import "YJLicenseView.h"
#import "YJMeCell.h"
#import "YJHTTPTool.h"
#import "ImagePickerVC.h"
#import "YJCompanyDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssertMacros.h>
#import <ImageIO/ImageIO.h>
#import "CompanyDetailModel.h"
#import "YJCompanyDetailManager.h"
#import "YJCityPickerView.h"
#define PickerComponent 2


@interface YJAuthorizationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,YJLicenseViewDelegate> {
    
    YJLicenseView *_liscenseView;
    UIPickerView *_picker;
    YJArrowItem *_item3;
    YJTextItem *_item4;
    
    
    
}
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (nonatomic, strong) NSArray *cities;

@property (nonatomic, strong) YJArrowItem *item1;

@property (nonatomic, strong) YJCityPickerView *cityPicker;

/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *companyName;
/**
 *  所在省
 */
@property (nonatomic, copy) NSString *province;
/**
 *  所在市
 */
@property (nonatomic, copy) NSString *city;
/**
 *  详细地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  执照类型
 *  00-营业执照
 *  0-注册号
 */
@property (nonatomic, copy) NSString *licenseType;
/**
 *  执照号码
 */
@property (nonatomic, copy) NSString *licenseNum;
/**
 *  执照照片字符流
 */
@property (nonatomic, copy) NSString *licenseDataStr;




@end

@implementation YJAuthorizationViewController

- (YJCityPickerView *)cityPicker {
    if (_cityPicker == nil) {
        _cityPicker = [[YJCityPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kDatePickerViewHeight)];
    }
    return _cityPicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资质认证";

    self.companyDetailModel = [YJCompanyDetailManager companyInfo];
    
    [self creatUI];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);



}
- (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败   
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                MYLog(@"企业认证详情---%@",responseObj[@"data"]);
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
                
                weakSelf.companyDetailModel = companyDetailModel;
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                [YJUserManagerTool saveUser:user];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf creatUI];
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
- (void)creatUI {
    [self creatgroup0];
    
    [self setupFooter];
    
    [self setupNotification];
    
    [self.tableView reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:RGB(115, 115, 115)];
    
//    // 企业名称--主动获取焦点
//    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_cityPicker hidden];

}




#pragma mark 注册监听文本的输入
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

/**
 *  开始编辑
 *
 */
- (void)textFieldTextDidBeginEditing:(NSNotification *)noti {
    
    [_cityPicker hidden];

    
}

/**
 *  结束编辑
 *
 */
- (void)textFieldTextDidEndEditing:(NSNotification *)noti {
    
//    UITextField *tf = (UITextField *)noti.object;
//    
//    YJMeCell *editeCell  = (YJMeCell *)[tf superview];
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
//    
////        MYLog(@"textFieldTextDidChange--------%@-====%ld------%ld",editeCell,indexPath.row,indexPath.section);
//    
//    NSString *result = tf.text;
//    
//    switch (indexPath.row) {
//        case 0:
//            self.companyName = @"";
//            self.companyName = result;
//            self.companyDetailModel.companyName = result;
//            break;
//        case 2:
//            self.address = @"";
//            self.address = result;
//            self.companyDetailModel.companyAddress = result;
//
//            break;
//        case 4:
//            self.licenseNum = @"";
//            self.licenseNum = result;
//            self.companyDetailModel.busiLicenseCode = result;
//
//            break;
//        default:
//            break;
//    }
}
/**
 *  正在编辑
 *
 */
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    YJMeCell *editeCell  = (YJMeCell *)[textField superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    NSString *result = textField.text;
    int strLength = 0;
    switch (indexPath.row) {
        case 0:
            strLength = 50;
//            MYLog(@"公司名字---%@----%@",self.companyName,textField.text);
            self.companyName = result;
            self.companyDetailModel.companyName = result;
            break;
        case 2:
            strLength = 200;
//            MYLog(@"地址-------%@----%@",self.address,textField.text);
            self.address = result;
            self.companyDetailModel.companyAddress = result;
            break;
        case 4:
            strLength = 30;
//            MYLog(@"号码-------%@----%@",self.licenseNum,textField.text);
            self.licenseNum = result;
            self.companyDetailModel.busiLicenseCode = result;
            break;
        default:
            break;
    }

    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > strLength) {
                textField.text = [toBeString substringToIndex:strLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > strLength) {
            textField.text = [toBeString substringToIndex:strLength];
        }  
    }  
}



- (void)creatgroup0 {
    NSString *subTitle1 = nil;
    NSString *subTitle3 = nil;
    if (self.companyDetailModel) {
        [self setupAuthFailTipView];
        
        subTitle1 = [NSString stringWithFormat:@"%@  %@",self.companyDetailModel.companyProvince,self.companyDetailModel.companyCity];
        self.province = self.companyDetailModel.companyProvince;
        self.city = self.companyDetailModel.companyCity;
        
        subTitle3 = self.companyDetailModel.certiTypestr;
        self.licenseType = self.companyDetailModel.certiType;
        
        self.licenseDataStr = self.companyDetailModel.busiLicensePicture;
        
    } else {
        subTitle1 = @"请选择企业所在地";
        subTitle3 = @"请选择你的证件类型";//统一社会信用代码
    }
    

    
    __weak typeof(self) weakSelf = self;
    
    YJBaseItem *item0 = [YJTextItem itemWithTitle:@"企业名称"];
    
    YJArrowItem *item1 = [YJArrowItem itemWithTitle:@"所在地" subTitle:subTitle1 destVc:NULL];
    _item1 = item1;
    item1.option = ^(NSIndexPath *indexPath){
        
        [weakSelf.view endEditing:YES];
        
        [weakSelf showCityMenu];
        
        weakSelf.selectIndexPath = indexPath;
        
        
    };
    

    YJBaseItem *item2 = [YJTextItem itemWithTitle:@"详细地址"];
    
    
    
    YJArrowItem *item3 = [YJArrowItem itemWithTitle:@"证件类型" subTitle:subTitle3];
    _item3 = item3;
    item3.option = ^(NSIndexPath *indexPath) {
        weakSelf.selectIndexPath = indexPath;
        
        [weakSelf alertSheetLiscenseType];
        
    };
    NSString *item4Title = nil;
    if ([self.companyDetailModel.certiType isEqualToString:@"00"]) {
        item4Title = @"营业执照号";
    } else if ([self.companyDetailModel.certiType isEqualToString:@"01"]) {
        item4Title = @"注册号";
    } else {
        item4Title = @"营业执照号";
    }
    YJTextItem *item4 = [YJTextItem itemWithTitle:item4Title];
    _item4 = item4;
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0,item1,item2,item3,item4];
    
    [self.dataSource addObject:group];
    
    
}

#pragma mark--设置审核失败的提示
- (void)setupAuthFailTipView {
    if ([self.companyDetailModel.status isEqualToString:@"99"]) {
        UILabel *tipLB = [[UILabel alloc] init];
        CGSize size = [NSString calculateTextSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) Content:self.companyDetailModel.remark font:Font13];
        
        tipLB.text = self.companyDetailModel.remark;
        tipLB.textAlignment = NSTextAlignmentLeft;
//        tipLB.backgroundColor = RGB(255, 243, 184);
        tipLB.backgroundColor = [UIColor clearColor];
        tipLB.numberOfLines = 0;
        tipLB.frame = CGRectMake(15, 0, size.width, size.height+10);
        tipLB.font = Font13;
        tipLB.textColor = RGB(242,65,48);
        
        UIView *bgView1 = [[UIView alloc] init];
        bgView1.backgroundColor = RGB(255, 243, 184);
        bgView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, size.height+10);
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = RGB_pageBackground;
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, size.height+15);
        [bgView addSubview:bgView1];
        [bgView addSubview:tipLB];
        self.tableView.tableHeaderView = bgView;
    }
}

/**
 *  设置底部选取图片、提交控件
 */
- (void)setupFooter {

    
    YJLicenseView *liscenseView = [YJLicenseView licenseView] ;
    _liscenseView = liscenseView;
    liscenseView.delegate = self;
    liscenseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    [bg addSubview:liscenseView];
    self.tableView.tableFooterView = bg;
    
    if (self.companyDetailModel) {
        NSString *imgDataStr = self.companyDetailModel.busiLicensePicture;
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imgDataStr options:(NSDataBase64DecodingIgnoreUnknownCharacters)] ;
        UIImage *img =[UIImage imageWithData:imageData];
        _liscenseView.licenseImage = img;
    }
}

/**
 *  证件类型选择
 */
- (void)alertSheetLiscenseType {
    [_cityPicker hidden];

    __weak typeof(self) weakSelf = self;
    //    __block NSString *liscenseType = nil;
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"普通营业执照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf chooseLiscenseType:@"普通营业执照"];
        weakSelf.licenseType = @"00";
        
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"多证合一营业执照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf chooseLiscenseType:@"多证合一营业执照"];
        weakSelf.licenseType = @"01";
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [sheet addAction:action1];
    [sheet addAction:action2];
    [sheet addAction:cancleAction];
    
    
    [self presentViewController:sheet animated:YES completion:^{
        
    }];


    
}


- (void)chooseLiscenseType:(NSString *)type {
    _item3.subTitle = type;
    if ([type isEqualToString:@"多证合一营业执照"]) {
        _item4.title = @"注册号";
    } else if ([type isEqualToString:@"普通营业执照"]) {
        _item4.title = @"营业执照号";
    }
    
//    self.city = _item1.subTitle;
    [self.tableView reloadData];
//    [self.tableView reloadRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark -- 展示城市选择器
- (void)showCityMenu {
    
    [self.view endEditing:YES];
    
    __weak typeof(self)weakSelf = self;
    if (!self.cityPicker.superview) {
        
        [self.view.superview addSubview:self.cityPicker];
        
        // 显示
        [self.cityPicker show];
        self.cityPicker.resultCallBack = ^(NSString *p,NSString *c,int index) {
            if (index == 1) {
                MYLog(@"-----%@,%@",p,c);
                
                if (_selectIndexPath != nil) {
                    weakSelf.province = p;
                    weakSelf.city = c;
                    weakSelf.item1.subTitle = [NSString stringWithFormat:@"%@  %@",weakSelf.province,weakSelf.city];
                    
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[weakSelf.selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }
            }
            
        };

    }
    
    

  
}



#pragma mark --YJLicenseViewDelegate

#pragma mark 选取营业执照
- (void)licenseViewChooseLicensePic:(YJLicenseView *)licenseView {
    [self alertSheetlicensePic];
    
}

- (void)alertSheetlicensePic {
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openAlbum];
        
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openCamera];
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [sheet addAction:cameraAction];
    [sheet addAction:albumAction];
    [sheet addAction:cancleAction];
    
    
    [self presentViewController:sheet animated:YES completion:^{
        
    }];
    
}


/**
 *  打开相机
 */
- (void)openCamera {
    ImagePickerVC * imagePicker = [[ImagePickerVC alloc]init];

//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum {
    ImagePickerVC * imagePicker = [[ImagePickerVC alloc]init];

//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}



#pragma mark 提交数据
- (void)commitLicenseInfoBtnClick:(YJLicenseView *)licenseView {
    // 判断数据是否齐全
    
    if (self.companyName == nil || self.city == nil || self.address == nil || self.licenseNum == nil || self.licenseType == nil || _liscenseView.licenseImage == nil) {
        [self.view makeToast:@"请完善信息"];
        
        return;
    }
    
    if ([self.companyName isEqualToString:@""] || [self.city isEqualToString:@""] || [self.address isEqualToString:@""] || [self.licenseNum isEqualToString:@""] || [self.licenseType isEqualToString:@""] || _liscenseView.licenseImage == nil) {
        [self.view makeToast:@"请完善信息"];
        
        return;
    }
    
    if (self.licenseDataStr == nil) {
        [self.view makeToast:@"正在压缩图片，请稍等!"];
    }
    
    MYLog(@"%@-%@-%@-%@-%@--%@--",self.companyName,self.province,self.city,self.address,self.licenseNum,self.licenseType);

    
    [self commitLicenseDataToService];
    
    
}

- (void)commitLicenseDataToService {
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict = @{@"method" : @"memberAuth",
                           @"mobile" : kUserManagerTool.mobile,
                           @"userPwd" : kUserManagerTool.userPwd,
                           @"companyName" : self.companyName,
                           @"companyProvince": self.province,
                           @"companyCity": self.city,
                           @"companyAddress" : self.address,
                           @"certiType": self.licenseType,
                           @"busiLicenseCode" : self.licenseNum,
                           @"busiLicensePicture": self.licenseDataStr};
    
    MYLog(@"-%@------%@",kUserManagerTool.mobile,kUserManagerTool.userPwd);
    
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_memberAuth] params:dict success:^(id responseObj) {
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJShortLoadingView yj_hideToastActivityInView:self.view];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [weakSelf.view makeToast:@"上传成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                });
                
            });
            MYLog(@"上传成功---%@",responseObj);
            [YJCompanyDetailManager getCompanyInfoFromNet];
        }

        
    } failure:^(NSError *error) {       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            [weakSelf.view makeToast:@"上传失败"];
        });
        
        MYLog(@"上传失败---%@",error);
        
    }];
    
    
    /*
    NSMutableArray *formDataArray = [NSMutableArray arrayWithCapacity:0];
    YJFormData *formData = [[YJFormData alloc] init];
    formData.data = imageData;
    formData.name = @"pic";
    formData.filename = @"";
    formData.mimeType = @"image/jpeg";
    [formDataArray addObject:formData];
    
    // 发送请求
    [YJHTTPTool postWithURLStr:urlStr parameters:dict formDataArray:formDataArray success:^(id data) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD bwm_showTitle:@"上传成功" toView:self.view hideAfter:1.6];
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD bwm_showTitle:@"上传失败" toView:self.view hideAfter:1.6];
        });
        
        
    }];
    
*/
    
}






#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block typeof(self) weakSelf = self;
    //获取图片信息
    NSString *imageType;
    __block typeof(imageType) imgT = imageType;
    __block long H = 0;
    __block long W = 0;
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
    } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:assetURL
             resultBlock:^(ALAsset *asset) {
                 
                 //图片size
                 NSDictionary* imageMetadata = [[NSMutableDictionary alloc] initWithDictionary:asset.defaultRepresentation.metadata];
                 
                 H = [[imageMetadata objectForKey:@"PixelHeight"] longValue];
                 W = [[imageMetadata objectForKey:@"PixelWidth"] longValue];
                 
                 //图片类型：
                 NSString *extension = [assetURL pathExtension];
                 CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
                 if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
                     imgT = @"JPG";
                 else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
                     imgT = @"PNG";
                 else
                     imgT = (__bridge NSString*)imageUTI;
                 
                 if (imageUTI) {
                     CFRelease(imageUTI);
                 }
                 
             }
            failureBlock:^(NSError *error) {
                
            }];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//       
//        NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
//        
//        MYLog(@"---------%ld",imageData.length);
//        weakSelf.licenseDataStr = nil;
//        
//        weakSelf.licenseDataStr = [imageData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//        
//    });
    
    NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
    
    MYLog(@"---------%ld",(unsigned long)imageData.length);
    weakSelf.licenseDataStr = nil;
    
    weakSelf.licenseDataStr = [imageData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];

    
    _liscenseView.licenseImage = image;

    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    


}

#pragma mark----重写父类方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
    cell.textLabel.font = Font15;
    YJItemGroup *group = self.dataSource[indexPath.section];
    YJBaseItem *item = group.groups[indexPath.row];
    cell.item = item;
    
    if ([self.companyDetailModel.status isEqualToString:@"99"]) {  // 企业认证失败
        switch (indexPath.row) {
            case 0:
                cell.textField.text = self.companyDetailModel.companyName;
                self.companyName = self.companyDetailModel.companyName;
                break;
            case 2:
                cell.textField.text = self.companyDetailModel.companyAddress;
                self.address = self.companyDetailModel.companyAddress;
                
                break;
            case 4:
                cell.textField.text = self.companyDetailModel.busiLicenseCode;
                self.licenseNum = self.companyDetailModel.busiLicenseCode;
                break;
            default:
                break;
        }
    }

    
    return cell;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [super scrollViewWillBeginDragging:scrollView];
    [_cityPicker hidden];


}




- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
  

    
}
@end
