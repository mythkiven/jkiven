//
//  YJIdeaVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJIdeaVC.h"
#import "YJTextView.h"
#import "YJAddPicturesView.h"
#import "ImagePickerVC.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AssertMacros.h>
#import <ImageIO/ImageIO.h>

#import "YJPhotoAlbumVC.h"
//#import "YJPhotoItemModel.h"
@interface YJIdeaVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate, YJAddPicturesViewDelegate>
{
    UIScrollView *_scrollView;
    
    UIView *_contentView;
    
    YJTextView *_textView;
    
    YJAddPicturesView *_addPicView;
    
    UIView *_bottomLine;
    
    CGFloat _textViewH;
    
    
    UIButton *_commitBtn;
    
    
}

/**
 *  男法师的那份
 *
 */
@property (nonatomic, strong) NSMutableArray *imageDataBase64Arr;
@end

@implementation YJIdeaVC

- (NSMutableArray *)imageDataBase64Arr {
    if (_imageDataBase64Arr == nil) {
        _imageDataBase64Arr = [NSMutableArray arrayWithCapacity:0];

    }
    
    return _imageDataBase64Arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _textViewH = 150;
    [self setupScrollView];
    
    [self setupContentView];
    
    [self setupTextView];
    
    [self setupPictureView];
    
    [self setupCommitBtn];
    
}

/**
 *  设置UIScrollView
 */
- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT+20);
    _scrollView.delegate = self;
    _scrollView.backgroundColor = RGB_pageBackground;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}
#pragma mark ---UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_textView resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

}

- (void)setupContentView {
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(0, kMargin_10, SCREEN_WIDTH, _textViewH+kMargin_10*2);
    _contentView.backgroundColor = RGB_white;
    [_scrollView addSubview:_contentView];
    
    UIView *topLine = [self line];
    topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
    [_contentView addSubview:topLine];
    
//    
//    UIView *bottomLine = [self line];
//    _bottomLine = bottomLine;
//    bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame)-.5, SCREEN_WIDTH, .5);
//    [_contentView addSubview:bottomLine];
    
}

- (UIView *)line {
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = RGB_lightGray;
    
    return line;
}


- (void)setupTextView {
    
    _textView = [[YJTextView alloc] init];
    _textView.frame = CGRectMake(15, 10, SCREEN_WIDTH-30, _textViewH);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.placehoder = @"请输入遇到的问题或对产品的建议...";
    [_contentView addSubview:_textView];
    
    // 监听输入文本变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:_textView];
    
    //
    //    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //
    //    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_textView.text.length == 0) {
        _commitBtn.enabled = NO;
    } else {
        _commitBtn.enabled = YES;
    }
    
}



- (void)setupPictureView {
    
    __weak typeof(self) weakSelf = self;

    _addPicView = [[YJAddPicturesView alloc] init];
    
    _addPicView.deletePicBlock = ^(int index) {
        
        [weakSelf.imageDataBase64Arr removeObjectAtIndex:index];
    };
    
    _addPicView.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), SCREEN_WIDTH, kIdeaImageWH+15);
    _addPicView.delegate = self;
    [_scrollView addSubview:_addPicView];
    
}

- (void)setupCommitBtn {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _commitBtn = btn;
    btn.frame =CGRectMake(15, self.view.height - 45 - 20 -64, SCREEN_WIDTH-30, 45);
    [btn setTitle:@"确认提交" forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    btn.enabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [btn setTitleColor:RGB_white forState:UIControlStateNormal];
    [btn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(commitBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

#pragma mark--提交意见反馈
- (void)commitBtnClcik {
    
    NSString *content = _textView.text;
    
    content = [content stringByReplacingOccurrencesOfString: @" " withString: @""];
    content = [content stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    
    
    // 验证
    if (content.length == 0) {
        [self.view makeToast:@"请输入反馈意见"];
        return;
    } else if (content.length >= 500) {
        [self.view makeToast:@"反馈意见不能超过500字"];
        return;
    }
    
    
    // 提交
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:
                                 @{@"method" : urlJK_appSuggestions,
                                   @"mobile" : kUserManagerTool.mobile,
                                   @"userPwd" : kUserManagerTool.userPwd,
                                   @"appVersion" : ConnectPortVersion_1_0_0,
                                   @"content": content}];
    
    for (int i = 0; i < 8; i ++) {
        NSString *key = [NSString stringWithFormat:@"attachFile%d",i];
        
        if (i < self.imageDataBase64Arr.count) {
            [dict setObject:self.imageDataBase64Arr[i] forKey:key];

        } else {
            [dict setObject:@"" forKey:key];
        }
    }
    

    
    
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_appSuggestions] params:dict success:^(id responseObj) {
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJShortLoadingView yj_hideToastActivityInView:self.view];

                [weakSelf.view makeToast:@"上传成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                });
                
            });
            MYLog(@"上传成功---%@",responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            [weakSelf.view makeToast:@"上传失败"];
        });
        
        MYLog(@"上传失败---%@",error);
        
    }];
    
    
    
    
    
    
}


#pragma mark--选取照片
- (void)addPicturesViewDidClickAddImageView:(YJAddPicturesView *)addPicturesView {
    [self alertSheet];
    
    
}

- (void)addPicturesView:(YJAddPicturesView *)addPicturesView didClickImageView:(int)tag {
//    imageViewController *imageVc = [[imageViewController alloc] init];
//    imageVc.imageArray = [NSMutableArray arrayWithArray:[addPicturesView totalImages]];
//    imageVc.selectedIndex = tag;
//    [self.navigationController pushViewController:imageVc animated:YES];
    
}


#pragma mark 设置头像
- (void)alertSheet {
    __weak typeof(self) weakSelf = self;
    //    if ( iOS8) {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
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

#pragma mark--UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self openAlbum];
            
            break;
        case 1:
            [self openCamera];
            
            break;
        default:
            break;
    }
    
}





#pragma mark 打开相机
- (void)openCamera {
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        MYLog(@"支持相机");
    }else{
        [self.view makeToast:@"不支持相机，请修改设置，允许访问相机"];
        return;
    }
    
        [WTAuthorizationTool requestCameraAuthorization:^(WTAuthorizationStatus status) {
            if(status == WTAuthorizationStatusAuthorized){
                
                ImagePickerVC * imagePicker = [[ImagePickerVC alloc]init];
                //    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //    imagePicker.allowsEditing = YES;
                //    imagePicker.allowsImageEditing=YES;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            }else if (status == WTAuthorizationStatusDenied){
                [self goSettingWithMessage:@"相机"];
                return ;
            }else{
                [self.view makeToast:@"无法访问相机"];
                return ;
            }
        }];
 
}

#pragma mark 打开相册
- (void)openAlbum {
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        MYLog(@"支持相册");
    }else{
        [self.view makeToast:@"系统不允许查看相册，请修改设置，允许访问相册"];
        return;
    }
    
        [WTAuthorizationTool requestImagePickerAuthorization:^(WTAuthorizationStatus status) {
            if(status == WTAuthorizationStatusAuthorized){
                __weak typeof(self) weakSelf = self;
                YJPhotoAlbumVC *vc = [[YJPhotoAlbumVC alloc] init];
                int count = (int)[[_addPicView totalImages] count];
                vc.totalCount = 8 - count;
                vc.photosBlock = ^(NSMutableArray *photoBase64Arr) {
                    // 2.base64
                    for (NSString *str in photoBase64Arr) {
                        [weakSelf.imageDataBase64Arr addObject:str];
                        
                        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
                        UIImage *image = [UIImage imageWithData:imgData];
                        [_addPicView addImage:image];
                    }
                };
                YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
                return;
                
                
            }else if (status == WTAuthorizationStatusDenied){
                [self goSettingWithMessage:@"相册"];
                return ;
            }else{
                [self.view makeToast:@"无法访问相册"];
                return ;
            }
        }];
    
    
    
}

- (void)goSettingWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"系统拒绝访问%@，请修改设置",message] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}






#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block typeof(self) weakSelf = self;
    //获取图片信息
    __block NSString *imageType;
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
                     imageType = @"JPG";
                 else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
                     imageType = @"PNG";
                 else
                     imageType = (__bridge NSString*)imageUTI;
                 
                 if (imageUTI) {
                     CFRelease(imageUTI);
                 }
                 
             }
            failureBlock:^(NSError *error) {
                
            }];
    
    
    
    NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
    
    NSString *imgStr = [imageData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    
    [self.imageDataBase64Arr addObject:imgStr];
    [_addPicView addImage:image];

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
