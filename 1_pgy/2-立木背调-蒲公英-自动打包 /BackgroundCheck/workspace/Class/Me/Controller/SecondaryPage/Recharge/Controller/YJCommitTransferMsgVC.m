//
//  YJCommitTransferMsgVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssertMacros.h>
#import <ImageIO/ImageIO.h>
#import "YJCommitTransferMsgVC.h"
#import "KSDatePicker.h"
#import "YJDatePickerView.h"
#import "YJTextView.h"
#import "ImagePickerVC.h"

@interface YJCommitTransferMsgVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>
{
//    YJDatePickerView* _picker;
}
/**
 *  付款户名
 */
@property (weak, nonatomic) IBOutlet UITextField *accountTf;
/**
 *  转账金额
 */
@property (weak, nonatomic) IBOutlet UITextField *moneyTf;
/**
 *  转账时间
 */
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet YJTextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIView *picBgView;
@property (weak, nonatomic) IBOutlet UIButton *evidencePic;

@property (nonatomic, copy) NSString *evidenceDataStr;

- (IBAction)evidencePicClick:(UIButton *)sender;


@property (nonatomic, strong) YJDatePickerView* picker;
@end

@implementation YJCommitTransferMsgVC



- (YJDatePickerView *)picker {
    if (_picker == nil) {
        _picker = [[YJDatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, kDatePickerViewHeight)];
        _picker.maximumDate = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:-1];//设置最小时间为：当前时间前推1个月
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        _picker.minimumDate = minDate;
    }
    return _picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交转账信息";
    
    self.remarkTextView.placehoder = @"请输入备注说明(限50字)";
    self.picBgView.layer.borderColor = RGB_grayLine.CGColor;
    self.picBgView.layer.borderWidth = .5;
    
    
    self.remarkTextView.delegate = self;
    [self setupCommitBtn];


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.accountTf becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.accountTf resignFirstResponder];
    
}







- (void)setupCommitBtn {
    
    self.commitBtn.layer.cornerRadius = 2;
    self.commitBtn.layer.masksToBounds = YES;
    [self.commitBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.commitBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.commitBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.commitBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
}

#pragma mark--选择日期
- (IBAction)dateBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (!self.picker.superview) {
        [self.view addSubview:self.picker];
        // 显示
        [_picker show];
        self.picker.resultCallBack = ^(NSDate *currentDate,int index) {
            if (index == 1) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                [sender setTitle:[formatter stringFromDate:currentDate] forState:(UIControlStateNormal)];
                [sender setTitleColor:RGB_black forState:(UIControlStateNormal)];
            }
        };
    }
    
}



#pragma mark--UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_picker hidden];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.moneyTf) {
        // 用string 替换 range 位置的字符串
        NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (newStr.length>10) {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark--选取照片
- (IBAction)evidencePicClick:(UIButton *)sender {
    [_picker hidden];
    [self.view endEditing:YES];
    
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
    
    NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
    

    
    self.evidenceDataStr = [imageData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    
    self.evidencePic.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.evidencePic setImage:[UIImage imageWithData:imageData] forState:(UIControlStateNormal)];
    self.evidencePic.backgroundColor = RGB_white;
    
   
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    
    
}

#pragma mark--提交转账信息
- (IBAction)commitBtnClick:(UIButton *)sender {
    if ([self.accountTf.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入付款户名"];
        return;
    }
    
    if (self.accountTf.text.length > 100) {
        [self.view makeToast:@"输入户名过长"];
        return;
    }
    
    if ([self.moneyTf.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入转账金额"];
        return;
    }
    if ([self.moneyTf.text floatValue] <= 0 ) {
        [self.view makeToast:@"请输入正确的金额"];
        return;
    }
    if ([self.dateBtn.titleLabel.text  hasPrefix:@"请"]) {
        [self.view makeToast:@"请选择转账时间"];
        return;
    }
    if (self.evidenceDataStr.length == 0) {
        [self.view makeToast:@"请上传转账凭证"];
        return;
    }
    
    [self commitEvidenceDataToService];
    
}


/**
 *  请求
 */
- (void)commitEvidenceDataToService {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *transAmount = [NSString stringWithFormat:@"%.2f",[self.moneyTf.text floatValue]];
    
    NSDictionary *dict = @{@"method" : @"submitTransferInfo",
                           @"mobile" : kUserManagerTool.mobile,
                           @"userPwd" : kUserManagerTool.userPwd,
                           @"appVersion" : ConnectPortVersion_1_0_0,
                           @"transAmount": transAmount,
                           @"remank":@"",//备注
                           @"transDate": self.dateBtn.titleLabel.text,
                           @"paymentName": self.accountTf.text,
                           @"voucherPic":self.evidenceDataStr,
                           };
    
    MYLog(@"dict------%@",dict);
    
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    self.commitBtn.enabled = NO;
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_submitTransferInfo] params:dict success:^(id responseObj) {
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJShortLoadingView yj_hideToastActivityInView:self.view];
                //                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [weakSelf.view makeToast:@"上传成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.commitBtn.enabled = YES;

                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                });
                
            });
            MYLog(@"上传成功---%@",responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            [weakSelf.view makeToast:@"上传失败"];
            self.commitBtn.enabled = YES;
        });
        
        MYLog(@"上传失败---%@",error);
        
    }];
    
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [_picker hidden];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [_picker hidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
