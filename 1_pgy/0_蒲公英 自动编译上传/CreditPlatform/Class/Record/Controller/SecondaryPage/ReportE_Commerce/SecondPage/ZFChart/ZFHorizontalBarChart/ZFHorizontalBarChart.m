//
//  ZFHorizontalBarChart.m
//  ZFChartView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZFHorizontalBarChart.h"
#import "ZFHorizontalBar.h"
#import "ZFHorizontalAxis.h"
#import "NSString+Zirkfied.h"
#import "ZFMethod.h"

@interface ZFHorizontalBarChart()

/** 横向通用坐标轴图表 */
@property (nonatomic, strong) ZFHorizontalAxis * horizontalAxis;
/** 存储柱状条的数组 */
@property (nonatomic, strong) NSMutableArray * barArray;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray * colorArray;
/** 存储value文本颜色的数组 */
@property (nonatomic, strong) NSMutableArray * valueTextColorArray;
/** bar高度 */
@property (nonatomic, assign) CGFloat barHeight;
/** bar与bar之间的间距 */
@property (nonatomic, assign) CGFloat barPadding;
/** value文本颜色 */
@property (nonatomic, strong) UIColor * valueTextColor;

@end


@implementation ZFHorizontalBarChart

- (NSMutableArray *)barArray{
    if (!_barArray) {
        _barArray = [NSMutableArray array];
    }
    return _barArray;
}

- (NSMutableArray *)valueTextColorArray{
    if (!_valueTextColorArray) {
        _valueTextColorArray = [NSMutableArray array];
    }
    return _valueTextColorArray;
}

- (void)commonInit{
    [super commonInit];
    
    _overMaxValueBarColor = RGB_red;
    _isShadow = YES;
    _barHeight = ZFAxisLineItemWidth;
    _barPadding = ZFAxisLinePaddingForBarLength;
    _valueTextColor = RGB_black;
    _valueLabelToBarPadding = 5.f;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self drawGenericChart];
        self.horizontalAxis.scrollsToTop=YES;
//        self.horizontalAxis.contentSize = CGSizeMake(SCREEN_WIDTH, 350);
        self.horizontalAxis.showsHorizontalScrollIndicator = YES;
        self.horizontalAxis.showsVerticalScrollIndicator = YES;
//        self.horizontalAxis.scrollEnabled = NO;
    
    }
    
    return self;
}

#pragma mark - 坐标轴

/**
 *  画坐标轴
 */
- (void)drawGenericChart{
    self.horizontalAxis = [[ZFHorizontalAxis alloc] initWithFrame:self.bounds];
    self.horizontalAxis.xAxisLine.hidden = YES;
    self.horizontalAxis.yAxisLine.yLineWidth = 999;//没用
    [self addSubview:self.horizontalAxis];
}

#pragma mark - 柱状条
#warning AAAA - 设置popLabel
/**
 *  画柱状条
 */
- (void)drawBar:(NSMutableArray *)valueArray{
    id subObject = valueArray.firstObject;
    if ([subObject isKindOfClass:[NSString class]]) {
        for (NSInteger i = 0; i < valueArray.count; i++) {
            CGFloat xPos = self.horizontalAxis.axisStartXPos + self.horizontalAxis.yAxisLine.yLineWidth;
            CGFloat yPos = self.horizontalAxis.axisStartYPos - (self.horizontalAxis.groupPadding + _barHeight) * (i + 1);
//            CGFloat width = 400;
//            CGFloat width = self.horizontalAxis.xLineMaxValueWidth;
            CGFloat height = _barHeight;
            
            ZFHorizontalBar * bar = [[ZFHorizontalBar alloc] initWithFrame:CGRectMake(xPos, yPos, 300, height)];
            bar.groupAtIndex = 0;
            //极限宽度= width-poplabel的宽度-。。。
//            bar.barWidthLimit =SCREEN_WIDTH-115-20-30;
            bar.barWidthLimit = 1.9*(320-115-20-30)*SCREEN_WIDTH/320.0;
            
            bar.barIndex = i;
            bar.barColor = [UIColor redColor];
            
            if ( self.horizontalAxis.xLineMaxValue >0) {
                float barLengthPer = [self.horizontalAxis.yLineValueArray[i] floatValue] /[self totalNumOfArray:self.horizontalAxis.yLineValueArray] ;
//                self.horizontalAxis.xLineMaxValue;
                // 中间百分比
                if (barLengthPer<= 0.8&&barLengthPer>=0.004) {
                    bar.percent = ([self.horizontalAxis.yLineValueArray[i] floatValue] ) / ( [NSString floatNSString:self.horizontalAxis.yLineValueArray] );
                    bar.barColor = _colorArray.firstObject;
                }//最小百分比
                else if(barLengthPer>=0&&barLengthPer<=0.004){
                    if (barLengthPer==0) {
                        bar.percent = 0;
                        bar.barColor = _colorArray.firstObject;
                    }else{
                        bar.percent = .004f;
                        bar.barColor = _colorArray.firstObject;
                    }
                }//最大百分比
                else {
                    bar.percent = .54f;//缩小百分比，方便显示
                    bar.barColor = _colorArray.firstObject;
                    //                bar.barColor = _overMaxValueBarColor;
                }
            }else{
                bar.percent = 0;
                bar.barColor = _colorArray.firstObject;
            }
            MYLog(@"比例：：：：%lf",bar.percent);
            bar.isShadow = _isShadow;
            bar.isAnimated = self.isAnimated;
            bar.opacity = self.opacity;
            bar.shadowColor = self.shadowColor;
            [bar strokePath];
            [self.barArray addObject:bar];
            [self.horizontalAxis addSubview:bar];
            
            [bar addTarget:self action:@selector(barAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }else if ([subObject isKindOfClass:[NSArray class]]){
        if ([[subObject firstObject] isKindOfClass:[NSString class]]) {
            //bar总数
            NSInteger count = [valueArray count] * [subObject count];
            for (NSInteger i = 0; i < count; i++) {
                //每组bar的下标
                NSInteger barIndex = i % [subObject count];
                //组下标
                NSInteger groupIndex = i / [subObject count];
                
                CGFloat xPos = self.horizontalAxis.axisStartXPos + self.horizontalAxis.yAxisLine.yLineWidth;
                CGFloat yPos = self.horizontalAxis.axisStartYPos - self.horizontalAxis.groupPadding * (barIndex + 1) - _barHeight * (groupIndex + 1) - self.horizontalAxis.groupHeight * barIndex - _barPadding * groupIndex;
//                CGFloat width =  400;//self.horizontalAxis.xLineMaxValueWidth;
                CGFloat height = _barHeight;
                
                ZFHorizontalBar * bar = [[ZFHorizontalBar alloc] initWithFrame:CGRectMake(xPos, yPos, 300, height)];
                bar.groupAtIndex = groupIndex;
                bar.barIndex = barIndex;
                bar.barColor = [UIColor redColor];
                float barLengthPer = [self.horizontalAxis.yLineValueArray[i] floatValue] / self.horizontalAxis.xLineMaxValue;
                // 中间百分比
                if (barLengthPer<= 0.8&&barLengthPer>=0.004) {
                    bar.percent = ([self.horizontalAxis.yLineValueArray[i] floatValue] ) / ( [NSString floatNSString:self.horizontalAxis.yLineValueArray] );
                    bar.barColor = _colorArray.firstObject;
                }//最小百分比
                else if(barLengthPer>=0&&barLengthPer<=0.004  ){
                    if (barLengthPer==0) {
                        bar.percent = 0;
                        bar.barColor = _colorArray.firstObject;
                    }else{
                        bar.percent = .004f;
                        bar.barColor = _colorArray.firstObject;
                    }
                }//最大百分比
                else {
                    bar.percent = .54f;//缩小百分比，方便显示
                    bar.barColor = _colorArray.firstObject;
                }
                
                bar.isShadow = _isShadow;
                bar.isAnimated = self.isAnimated;
                bar.opacity = self.opacity;
                bar.shadowColor = self.shadowColor;
                [bar strokePath];
                [self.barArray addObject:bar];
                [self.horizontalAxis addSubview:bar];
                
                [bar addTarget:self action:@selector(barAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}
-(float)totalNumOfArray:(NSArray *)arr{
    float totalNum = 0;
    for (NSString *n  in arr) {
        float t = [n floatValue];
        totalNum +=t;
    }
    return totalNum;
}
#warning AAAA - 设置popLabel
/**
 *  设置x轴valueLabel
 */
- (void)setValueLabelOnChart:(NSMutableArray *)valueArray{
    id subObject = valueArray.firstObject;
    if ([subObject isKindOfClass:[NSString class]]) {
        for (NSInteger i = 0; i < self.barArray.count; i++) {
            ZFHorizontalBar * bar = self.barArray[i];
            CGRect rect = [self.horizontalAxis.yLineValueArray[i] stringWidthRectWithSize:CGSizeMake(50 - _valueLabelToBarPadding * 2, _barHeight) fontOfSize:self.valueOnChartFontSize isBold:NO];
            NSString *str= self.horizontalAxis.yLineValueArray[i];
            CGFloat ll=0.0;
            if ((str.length == 0)|[str isKindOfClass:[NSNull class]]|!str) {
                ll = 5;
            }
            
            //label的中心点
            CGPoint label_center = CGPointMake(2.5+bar.endXPos + self.horizontalAxis.yAxisLine.yLineStartXPos + (rect.size.width + 10) * 0.5 + _valueLabelToBarPadding, bar.center.y);
            
            ZFPopoverLabel * popoverLabel = [[ZFPopoverLabel alloc] initWithFrame:CGRectMake(0, 0, ll+rect.size.width + 10+20, rect.size.height + 10) direction:kAxisDirectionHorizontal];
            popoverLabel.groupIndex = 0;
            popoverLabel.labelIndex = i;
            popoverLabel.pattern = 1;
//           popoverLabel.backgroundColor = [UIColor yellowColor];
            
            popoverLabel.text = self.horizontalAxis.yLineValueArray[i];
            popoverLabel.font = Font13;
            popoverLabel.arrowsOrientation = kPopoverLaberArrowsOrientationOnBelow;
            popoverLabel.center = label_center;
            popoverLabel.pattern = self.valueLabelPattern;
            popoverLabel.textColor = (UIColor *)self.valueTextColorArray.firstObject;
            popoverLabel.isShadow = self.isShadowForValueLabel;
            popoverLabel.isAnimated = self.isAnimated;
            popoverLabel.shadowColor = self.valueLabelShadowColor;
            [popoverLabel strokePath];
            if ([popoverLabel.text isEqualToString:@"订单笔数"]) {
//                popoverLabel.font = Font15;
//                if (iPhone5) {
                    popoverLabel.font = Font14;
//                }
                popoverLabel.textColor=RGB_greenBtn;
                
//                CGRect rect =  popoverLabel.frame;
//                rect.size.width +=20;
//                popoverLabel.backgroundColor = RGB_red;
//                popoverLabel.frame = rect;
                
            }
            
            [self.horizontalAxis addSubview:popoverLabel];
            [popoverLabel addTarget:self action:@selector(popoverAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }else if ([subObject isKindOfClass:[NSArray class]]){
        if ([[subObject firstObject] isKindOfClass:[NSString class]]) {
            for (NSInteger i = 0; i < self.barArray.count; i++) {
                ZFHorizontalBar * bar = self.barArray[i];
                NSInteger barIndex = i % [subObject count];
                NSInteger groupIndex = i / [subObject count];
                NSString *str= self.horizontalAxis.yLineValueArray[i];
                CGFloat ll=0.0;
                if ((str.length == 0)|[str isKindOfClass:[NSNull class]]|!str) {
                    ll = 5;
                }
                
                CGRect rect = [valueArray[groupIndex][barIndex] stringWidthRectWithSize:CGSizeMake(50 - _valueLabelToBarPadding * 2, _barHeight) fontOfSize:self.valueOnChartFontSize isBold:NO];
                //label的中心点
                CGPoint label_center = CGPointMake(2.5+bar.endXPos + self.horizontalAxis.yAxisLine.yLineStartXPos + (rect.size.width + 10) * 0.5 + _valueLabelToBarPadding, bar.center.y);
                
                ZFPopoverLabel * popoverLabel = [[ZFPopoverLabel alloc] initWithFrame:CGRectMake(0, 0, ll+rect.size.width + 10+10, rect.size.height + 10) direction:kAxisDirectionHorizontal];
                popoverLabel.text = valueArray[groupIndex][barIndex];
                popoverLabel.font = Font13;
            
                popoverLabel.arrowsOrientation = kPopoverLaberArrowsOrientationOnBelow;
                popoverLabel.center = label_center;
                popoverLabel.pattern = 1;
//                popoverLabel.backgroundColor = [UIColor yellowColor];
                
                popoverLabel.pattern = self.valueLabelPattern;
                popoverLabel.textColor = (UIColor *)self.valueTextColorArray[groupIndex];
                popoverLabel.isShadow = self.isShadowForValueLabel;
                popoverLabel.isAnimated = self.isAnimated;
                popoverLabel.groupIndex = groupIndex;
                popoverLabel.labelIndex = barIndex;
                popoverLabel.shadowColor = self.valueLabelShadowColor;
                [popoverLabel strokePath];
                [self.horizontalAxis addSubview:popoverLabel];
                [popoverLabel addTarget:self action:@selector(popoverAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}

#pragma mark - 点击事件

/**
 *  bar点击事件
 *
 *  @param sender bar
 */
- (void)barAction:(ZFHorizontalBar *)sender{
    if ([self.delegate respondsToSelector:@selector(horizontalBarChart:didSelectBarAtGroupIndex:barIndex:)]) {
        [self.delegate horizontalBarChart:self didSelectBarAtGroupIndex:sender.groupAtIndex barIndex:sender.barIndex];
    }
}

/**
 *  popoverLaber点击事件
 *
 *  @param sender popoverLabel
 */
- (void)popoverAction:(ZFPopoverLabel *)sender{
    if ([self.delegate respondsToSelector:@selector(horizontalBarChart:didSelectPopoverLabelAtGroupIndex:labelIndex:)]) {
        [self.delegate horizontalBarChart:self didSelectPopoverLabelAtGroupIndex:sender.groupIndex labelIndex:sender.labelIndex];
    }
}

#pragma mark - 清除控件

/**
 *  清除之前所有柱状条
 */
- (void)removeAllBar{
    [self.barArray removeAllObjects];
    NSArray * subviews = [NSArray arrayWithArray:self.horizontalAxis.subviews];
    for (UIView * view in subviews) {
        if ([view isKindOfClass:[ZFHorizontalBar class]]) {
            [(ZFHorizontalBar *)view removeFromSuperview];
        }
    }
}

/**
 *  清除柱状条上的Label
 */
- (void)removeLabelOnChart{
    NSArray * subviews = [NSArray arrayWithArray:self.horizontalAxis.subviews];
    for (UIView * view in subviews) {
        if ([view isKindOfClass:[ZFPopoverLabel class]]) {
            [(ZFPopoverLabel *)view removeFromSuperview];
        }
    }
}

#pragma mark - public method

/**
 *  重绘
 */
- (void)strokePath{
    [self.colorArray removeAllObjects];
    [self.valueTextColorArray removeAllObjects];
    
    if ([self.dataSource respondsToSelector:@selector(valueArrayInGenericChart:)]) {
        self.horizontalAxis.yLineValueArray = [NSMutableArray arrayWithArray:[self.dataSource valueArrayInGenericChart:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(nameArrayInGenericChart:)]) {
        self.horizontalAxis.yLineNameArray = [NSMutableArray arrayWithArray:[self.dataSource nameArrayInGenericChart:self]];
    }
    
    if ([self.delegate respondsToSelector:@selector(colorArrayInGenericChart:)]) {
        _colorArray = [NSMutableArray arrayWithArray:[self.dataSource colorArrayInGenericChart:self]];
    }else{
//        _colorArray = [NSMutableArray arrayWithArray:[[ZFMethod shareInstance] cachedColor:self.horizontalAxis.yLineValueArray]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(axisLineMaxValueInGenericChart:)]) {
        self.horizontalAxis.xLineMaxValue = [self.dataSource axisLineMaxValueInGenericChart:self];
    }else{
        self.horizontalAxis.xLineMaxValue = [[ZFMethod shareInstance] cachedYLineMaxValue:self.horizontalAxis.yLineValueArray];
    }
    
    if (self.isResetAxisLineMinValue) {
        if ([self.dataSource respondsToSelector:@selector(axisLineMinValueInGenericChart:)]) {
            if ([self.dataSource axisLineMinValueInGenericChart:self] > [[ZFMethod shareInstance] cachedYLineMinValue:self.horizontalAxis.yLineValueArray]) {
                self.horizontalAxis.xLineMinValue = [[ZFMethod shareInstance] cachedYLineMinValue:self.horizontalAxis.yLineValueArray];
                
            }else{
                self.horizontalAxis.xLineMinValue = [self.dataSource axisLineMinValueInGenericChart:self];
            }
            
        }else{
            self.horizontalAxis.xLineMinValue = [[ZFMethod shareInstance] cachedYLineMinValue:self.horizontalAxis.yLineValueArray];
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(axisLineSectionCountInGenericChart:)]) {
        self.horizontalAxis.xLineSectionCount = [self.dataSource axisLineSectionCountInGenericChart:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(barHeightInHorizontalBarChart:)]) {
        _barHeight = [self.delegate barHeightInHorizontalBarChart:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(paddingForGroupsInHorizontalBarChart:)]) {
        self.horizontalAxis.groupPadding = [self.delegate paddingForGroupsInHorizontalBarChart:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(paddingForBarInHorizontalBarChart:)]) {
        _barPadding = [self.delegate paddingForBarInHorizontalBarChart:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(valueTextColorArrayInHorizontalBarChart:)]) {
        id color = [self.delegate valueTextColorArrayInHorizontalBarChart:self];
        id subObject = self.horizontalAxis.yLineValueArray.firstObject;
        if ([subObject isKindOfClass:[NSString class]]) {
            if ([color isKindOfClass:[UIColor class]]) {
                [self.valueTextColorArray addObject:color];
            }else if ([color isKindOfClass:[NSArray class]]){
                self.valueTextColorArray = [NSMutableArray arrayWithArray:color];
            }
            
        }else if ([subObject isKindOfClass:[NSArray class]]){
            if ([color isKindOfClass:[UIColor class]]) {
                for (NSInteger i = 0; i < [subObject count]; i++) {
                    [self.valueTextColorArray addObject:color];
                }
            }else if ([color isKindOfClass:[NSArray class]]){
                self.valueTextColorArray = [NSMutableArray arrayWithArray:color];
            }
        }
        
    }else{
        id subObject = self.horizontalAxis.yLineValueArray.firstObject;
        if ([subObject isKindOfClass:[NSString class]]) {
            [self.valueTextColorArray addObject:_valueTextColor];
        }else if ([subObject isKindOfClass:[NSArray class]]){
            for (NSInteger i = 0; i < [subObject count]; i++) {
                [self.valueTextColorArray addObject:_valueTextColor];
            }
        }
    }
    
    self.horizontalAxis.groupHeight = [self cachedGroupHeight:self.horizontalAxis.yLineValueArray];
    
    [self removeAllBar];
    [self removeLabelOnChart];
    self.horizontalAxis.isAnimated = self.isAnimated;
    self.horizontalAxis.axisLineValueType = self.axisLineValueType;
    [self.horizontalAxis strokePath];
    [self drawBar:self.horizontalAxis.yLineValueArray];
    self.isShowAxisLineValue ? [self setValueLabelOnChart:self.horizontalAxis.yLineValueArray] : nil;
    [self.horizontalAxis bringSubviewToFront:self.horizontalAxis.xAxisLine];
    [self.horizontalAxis bringSubviewToFront:self.horizontalAxis.maskView];
    [self.horizontalAxis bringSectionToFront];
    [self bringSubviewToFront:self.topicLabel];
}

/**
 *  求每组高度
 */
- (CGFloat)cachedGroupHeight:(NSMutableArray *)array{
    id subObject = array.firstObject;
    if ([subObject isKindOfClass:[NSArray class]]) {
        return array.count * _barHeight + (array.count - 1) * _barPadding;
    }
    
    return _barHeight;
}

#pragma mark - 重写setter,getter方法

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.horizontalAxis.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setUnit:(NSString *)unit{
    self.horizontalAxis.unit = unit;
}

- (void)setUnitColor:(UIColor *)unitColor{
    self.horizontalAxis.unitColor = unitColor;
}

- (void)setAxisLineNameFontSize:(CGFloat)axisLineNameFontSize{
    self.horizontalAxis.yLineNameFontSize = axisLineNameFontSize;
}

- (void)setAxisLineValueFontSize:(CGFloat)axisLineValueFontSize{
    self.horizontalAxis.xLineValueFontSize = axisLineValueFontSize;
}

- (void)setAxisLineNameColor:(UIColor *)axisLineNameColor{
    self.horizontalAxis.yLineNameColor = axisLineNameColor;
}

- (void)setAxisLineValueColor:(UIColor *)axisLineValueColor{
    self.horizontalAxis.xLineValueColor = axisLineValueColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    self.horizontalAxis.axisLineBackgroundColor = backgroundColor;
}

- (void)setAxisColor:(UIColor *)axisColor{
    self.horizontalAxis.axisColor = axisColor;
}

- (void)setSeparateColor:(UIColor *)separateColor{
    self.horizontalAxis.separateColor = separateColor;
}

- (void)setIsShowSeparate:(BOOL)isShowSeparate{
    self.horizontalAxis.isShowSeparate = isShowSeparate;
}

@end
