//
//  YJLicenseView.m
//  CreditPlatform
//
//  Created by yj on 16/7/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJLicenseView.h"

@interface YJLicenseView ()
{
    UILabel *_lb;
    UIImageView *_imgView;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *licensePic;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIView *picBgView;

@end

@implementation YJLicenseView

+ (instancetype)licenseView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJLicenseView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"上传营业执照";
    lb.textColor= RGB_grayNormalText;
    _lb = lb;
    lb.font = Font15;
    lb.textAlignment = NSTextAlignmentCenter;
    [self.licensePic addSubview:lb];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.backgroundColor = [UIColor clearColor];
    [self.licensePic addSubview:_imgView];
    

    
    self.picBgView.layer.borderWidth = 0.5;
    self.picBgView.layer.borderColor = RGB(224, 224, 224).CGColor;
    
    self.commitBtn.layer.cornerRadius = 2;
    self.commitBtn.layer.masksToBounds = YES;
    [self.commitBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.commitBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    
    
    [self.commitBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.commitBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    
}

- (void)setLicenseImage:(UIImage *)licenseImage {
    _licenseImage = licenseImage;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;

    _imgView.image = licenseImage;
    
    
}

- (IBAction)clickLIcensePic:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(licenseViewChooseLicensePic:)]) {
        [self.delegate licenseViewChooseLicensePic:self];
    }
    
//    if ([self.delegate respondsToSelector:@selector(licenseView:chooseLicenseType:)]) {
//        [self.delegate licenseView:self chooseLicenseType:YJLicenseTypePicture];
//    }    
}

- (IBAction)commiteBtnClick:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(commitLicenseInfoBtnClick:)]) {
        [self.delegate commitLicenseInfoBtnClick:self];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _lb.sd_layout
    .leftSpaceToView(self.licensePic,0)
    .rightSpaceToView(self.licensePic,0)
    .bottomSpaceToView(self.licensePic,20)
    .heightIs(21);
    
    _imgView.sd_layout
    .leftSpaceToView(self.licensePic,0)
    .rightSpaceToView(self.licensePic,0)
    .bottomSpaceToView(self.licensePic,0)
    .topSpaceToView(self.licensePic,0);
    

    
}

@end
