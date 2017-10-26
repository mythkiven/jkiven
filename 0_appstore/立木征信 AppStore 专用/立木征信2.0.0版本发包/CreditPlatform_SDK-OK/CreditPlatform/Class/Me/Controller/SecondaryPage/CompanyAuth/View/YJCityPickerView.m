//
//  YJCityPickerView.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCityPickerView.h"
#import "YJCityModel.h"
#import "YJProvinceModel.h"
#define PickerComponent 2

@interface YJCityPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_line;
    UIView *_line1;
    UIButton  *_cancelBtn;
    UIButton   *_commitBtn;
    UIPickerView *_picker;
    
    
}
@property (nonatomic, strong) NSArray *cities;
/**
 *  所在省
 */
@property (nonatomic, copy) NSString *province;
/**
 *  所在市
 */
@property (nonatomic, copy) NSString *city;
@end

@implementation YJCityPickerView
- (NSArray *)cities
{
    if (_cities == nil) {
        
        //        _cities = [YJProvinceModel mj_objectArrayWithFilename:@"city.plist"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *cityArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            YJProvinceModel *provinceModel = [YJProvinceModel provinceModelWithDict:dict];
            [cityArr addObject:provinceModel];
        }
        _cities = cityArr;
    }
    
    return _cities;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.backgroundColor = RGB_grayBar;
    }
    return self;
}

- (void)commonInit
{
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = RGB_grayLine;
    [self addSubview:_line];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = RGB_grayLine;
    [self addSubview:_line1];
    
    _cancelBtn = [self setupBtnTitle:@"取消" tag:0];
    _commitBtn = [self setupBtnTitle:@"确定" tag:1];
    _commitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _picker = [[UIPickerView alloc] init];
    _picker.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
    _picker.backgroundColor = RGB_lightGray;
    _picker.dataSource = self;
    _picker.delegate = self;
    [self addSubview:_picker];
    for (int i = 0; i < PickerComponent; i++) {
        [self pickerView:_picker didSelectRow:0 inComponent:i];
    }
    
    
}

- (UIButton *)setupBtnTitle:(NSString *)title tag:(int)index {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = Font15;
    btn.backgroundColor = [UIColor clearColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB_navBar forState:UIControlStateNormal];
    btn.tag = index;
    [btn addTarget:self action:@selector(headerViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat supWidth = self.frame.size.width;
    //    CGFloat supHeight = self.frame.size.height;
    
    _line.frame = CGRectMake(0, 0, supWidth, 0.5);
    _line1.frame = CGRectMake(0, kToolBarH-.5, supWidth, 0.5);
    
    CGFloat btnW = (supWidth - kMargin_15*2) * .5;
    
    _cancelBtn.frame = CGRectMake(kMargin_15, 0, btnW, kToolBarH);
    _commitBtn.frame = CGRectMake(kMargin_15+btnW, 0, btnW, kToolBarH);
    
    _picker.frame = CGRectMake(0, kToolBarH, supWidth, kDatePickerH);
    
}

- (void)headerViewButtonClick:(UIButton*)button
{
    if (self.resultCallBack) {
        self.resultCallBack(self.province,self.city,(int)button.tag);
    }
    
    [self hidden];
    
}


- (void)show
{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -kDatePickerViewHeight);
        
    }];
    
}
- (void)hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return PickerComponent;
}

// 数据源方法
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.cities.count;
    }
    
    NSInteger row = [pickerView selectedRowInComponent:0];
    YJProvinceModel *provice = self.cities[row];
    return provice.cities.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    
    if (component == 0) {
        YJProvinceModel *province = self.cities[row];
        return province.province;
    } else {
        
        NSInteger idx = [pickerView selectedRowInComponent:0];
        
        
        YJProvinceModel *p = self.cities[idx];
        
        if (row >= p.cities.count) {
            row = 0;
        }
        
        return [p.cities[row] cityName];
        
        
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.0;
}


#pragma mark -- UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        [_picker reloadComponent:1];
        
        [_picker selectRow:0 inComponent:1 animated:YES];
        
    } else if (component == 1) {
        [_picker selectRow:row inComponent:1 animated:YES];
        
    }
    
    
    // 选择的哪个省
    NSInteger idx = [_picker selectedRowInComponent:0];
    YJProvinceModel *p = self.cities[idx];
    self.province = p.province;
    
    // 市
    NSInteger rowCityName = [_picker selectedRowInComponent:1];
    if (p.cities.count < rowCityName) {
        rowCityName = 0;
    }
    
    if ([self.province isEqualToString:@"北京"] ||
        [self.province isEqualToString:@"上海"] ||
        [self.province isEqualToString:@"天津"] ||
        [self.province isEqualToString:@"重庆"]) {
        self.city = [[p.cities[rowCityName] cityName] stringByAppendingString:@"区"];
    } else {
        self.city = [[p.cities[rowCityName] cityName] stringByAppendingString:@"市"];
    }
    
}

@end
