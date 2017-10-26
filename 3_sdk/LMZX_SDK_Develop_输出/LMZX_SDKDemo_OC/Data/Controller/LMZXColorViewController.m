//
//  LMZXColorViewController.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/16.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXColorViewController.h"
#import "LMZXColorImageView.h"
#import "UIColor+Extension.h"
#import "LMZXAlphaView.h"
//#import "LMZXRGBView.h"

#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@interface LMZXColorViewController ()<UITextFieldDelegate,LMZXAlphaViewDelegate>
{
    UIView *_colorView;
    UITextField *_colorTf;
    LMZXAlphaView *_alphaView;
    
    NSDictionary *_RGB;
    
    BOOL _isHexColor;
    
}
@end

@implementation LMZXColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =LM_RGB(245, 245, 245);
    
    UILabel *leftLb = [[UILabel alloc] init];
    leftLb.frame = CGRectMake(20, 10, 100, 40);
    leftLb.text = @"Hex Color #";
    leftLb.font = [UIFont systemFontOfSize:15];
    leftLb.textColor = [UIColor blackColor];
    [self.view addSubview:leftLb];
    
    UITextField *colorTf = [[UITextField alloc] init];
    colorTf.borderStyle = UITextBorderStyleRoundedRect;
    colorTf.frame = CGRectMake(130, 10, 100, 40);
    colorTf.returnKeyType = UIReturnKeyDone;
    colorTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    colorTf.delegate = self;
    [self.view addSubview:colorTf];
    _colorTf = colorTf;
    
    
    
    
    
    
    
    _colorView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-60), 10, 40, 40)];
    _colorView.layer.cornerRadius = 10;
    _colorView.clipsToBounds = YES;
    _colorView.layer.borderWidth = 0.5;
    _colorView.layer.borderColor = [UIColor colorWithHexString:@"#f1f1f1"].CGColor;
    _colorView.backgroundColor = _testColor;
    [self.view addSubview:_colorView];
    
    
    
    
    
    
    CGFloat w = 300;
    LMZXColorImageView *ws = [[LMZXColorImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-w)*0.5, CGRectGetMaxY(_colorView.frame)+40, w, w)];
    [self.view addSubview:ws];
    
    ws.currentColorBlock1 = ^(NSDictionary *RGB){
        _isHexColor = NO;
        _RGB = RGB;
         _colorView.backgroundColor = [UIColor colorWithRed:[RGB[@"R"] floatValue] green:[RGB[@"G"] floatValue] blue:[RGB[@"B"] floatValue] alpha:1];
        
        [_alphaView setAlphaTo1];

    };
    
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(selectColor)];
    
    
    LMZXAlphaView *alphaView = [[LMZXAlphaView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)*0.5, 500, 250, 25)];
    alphaView.delegate = self;
    _alphaView = alphaView;
    [self.view addSubview:alphaView];
    
    

    

}

#pragma mark- LMZXAlphaViewDelegate
- (void)alphaView:(LMZXAlphaView *)alphaView changeAlpha:(CGFloat)alpha {
    
    if (_isHexColor) {
        _colorView.backgroundColor = [UIColor colorWithHexString:[@"#" stringByAppendingString:_colorTf.text] alpha:alpha];
    } else {
        _colorView.backgroundColor = [UIColor colorWithRed:[_RGB[@"R"] floatValue] green:[_RGB[@"G"] floatValue] blue:[_RGB[@"B"] floatValue] alpha:alpha];

        
    }
    
    
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    _colorView.backgroundColor = [UIColor colorWithHexString:[@"#" stringByAppendingString:textField.text]];
    [textField endEditing:YES];
    
    _isHexColor = YES;
    
    [_alphaView setAlphaTo1];

    return YES;
}


- (void)selectColor {
    
    if (self.colorBlock) {
        self.colorBlock(_colorView.backgroundColor);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
