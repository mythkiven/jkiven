//
//  ReportCompanyInfoMainBaseHeaderView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCompanyInfoMainBaseHeaderView.h"
#define kLeftLabelWidth 104


@interface ReportCompanyInfoMainBaseHeaderView()
@property (nonatomic, strong) UIScrollView *scrollView;

/**信用号  */
@property (strong, nonatomic)  UILabel *LB1;
/** 代码 */
@property (strong, nonatomic)  UILabel *LB1_2;
/**  名称 */
@property (strong, nonatomic)  UILabel *LB2;
/** 类型 */
@property (strong, nonatomic)  UILabel *LB3;
/** 场所 */
@property (strong, nonatomic)  UILabel *LB4;
/** 范围 */
@property (strong, nonatomic)  UILabel *LB5;
/** 负责人 */
@property (strong, nonatomic)  UILabel *LB6;
/** 起始 */
@property (strong, nonatomic)  UILabel *LB7;
/** 结束 */
@property (strong, nonatomic)  UILabel *LB8;
/** 机关 */
@property (strong, nonatomic)  UILabel *LB9;
/** 成立 */
@property (strong, nonatomic)  UILabel *LB10;
/** 核准 */
@property (strong, nonatomic)  UILabel *LB11;
/** 状态 */
@property (strong, nonatomic)  UILabel *LB12;


@property (strong, nonatomic)  UILabel *titleLB;
@property (nonatomic, strong) UIView  *topLine;
@property (nonatomic, strong) UIView  *midLine;
@property (nonatomic, strong) UIView  *bottomLine;

/**信用号  代码 */
@property (strong, nonatomic)  UILabel *LB1R;
/**  名称 */
@property (strong, nonatomic)  UILabel *LB2R;
/** 类型 */
@property (strong, nonatomic)  UILabel *LB3R;
/** 场所 */
@property (strong, nonatomic)  UILabel *LB4R;
/** 范围 */
@property (strong, nonatomic)  UILabel *LB5R;
/** 负责人 */
@property (strong, nonatomic)  UILabel *LB6R;
/** 起始 */
@property (strong, nonatomic)  UILabel *LB7R;
/** 结束 */
@property (strong, nonatomic)  UILabel *LB8R;
/** 机关 */
@property (strong, nonatomic)  UILabel *LB9R;
/** 成立 */
@property (strong, nonatomic)  UILabel *LB10R;
/** 核准 */
@property (strong, nonatomic)  UILabel *LB11R;
/** 状态 */
@property (strong, nonatomic)  UILabel *LB12R;

@end
@implementation ReportCompanyInfoMainBaseHeaderView
{
    NSArray *_LeftLabelArr;
    NSArray *_RightLabelArr;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB_white;
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollView = scrollView;
        self.scrollView.backgroundColor = RGB_white;
        [self  addSubview:self.scrollView];
        [self addSubViewToScrollView];
        
        self.scrollView.scrollEnabled = NO;
        
    }
    
    return self;
}
#pragma mark - 创建UI
- (void)addSubViewToScrollView {
    
    self.topLine    = [self line];
    self.midLine    = [self line];
    self.bottomLine = [self line];
    
    
    UILabel *lb     = [[UILabel alloc] init];
    lb.font         = Font18;
    lb.textColor    = RGB_black;
    lb.text         = @"登记基本信息";
    self.titleLB    = lb;
    
    
    self.LB1   = [self grayTitleLBWithTitle:@"统一社会信用"];
    self.LB1_2 = [self grayTitleLBWithTitle:@"代码/注册号"];
    self.LB2   = [self grayTitleLBWithTitle:@"名称"];
    self.LB3   = [self grayTitleLBWithTitle:@"类型"];
    self.LB4   = [self grayTitleLBWithTitle:@"营业场所"];
    self.LB5   = [self grayTitleLBWithTitle:@"经营范围"];
    self.LB6   = [self grayTitleLBWithTitle:@"负责人"];
    self.LB7   = [self grayTitleLBWithTitle:@"营业期限自"];
    self.LB8   = [self grayTitleLBWithTitle:@"营业期限至"];
    self.LB9   = [self grayTitleLBWithTitle:@"登记机关"];
    self.LB10  = [self grayTitleLBWithTitle:@"成立日期"];
    self.LB11  = [self grayTitleLBWithTitle:@"核准日期"];
    self.LB12  = [self grayTitleLBWithTitle:@"登记状态"];
    
    self.LB1R  = [self contentLB];
    self.LB2R  = [self contentLB];
    self.LB3R  = [self contentLB];
    self.LB4R  = [self contentLB];
    self.LB5R  = [self contentLB];
    self.LB6R  = [self contentLB];
    self.LB7R  = [self contentLB];
    self.LB8R  = [self contentLB];
    self.LB9R  = [self contentLB];
    self.LB10R = [self contentLB];
    self.LB11R = [self contentLB];
    self.LB12R = [self contentLB];
    
    _LeftLabelArr  = @[self.LB2,self.LB3,self.LB4,self.LB5,self.LB6,self.LB7,
                       self.LB8,self.LB9,self.LB10,self.LB11,self.LB12];
    _RightLabelArr = @[self.LB2R,self.LB3R,self.LB4R,self.LB5R,self.LB6R,self.LB7R,
                       self.LB8R,self.LB9R,self.LB10R,self.LB11R,self.LB12R];
    
    
    [self.scrollView sd_addSubviews:@[self.topLine,self.midLine,self.bottomLine,self.titleLB,
                                      self.LB1,self.LB1_2,self.LB2,self.LB3,self.LB4,self.LB5,self.LB6,self.LB7,
                                      self.LB8,self.LB9,self.LB10,self.LB11,self.LB12,
                                      self.LB1R,self.LB2R,self.LB3R,self.LB4R,self.LB5R,self.LB6R,self.LB7R,
                                      self.LB8R,self.LB9R,self.LB10R,self.LB11R,self.LB12R]];
    
    
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self layoutSubview];
}
#pragma mark 设置model
- (void)setModel{
    
}

#pragma mark - 布局
- (void)layoutSubview {
    self.scrollView.frame = self.frame;
    
    // 左侧间距  左右间距
    CGFloat marginLefitSuper = 15;
    //上下行间距
    CGFloat marginTop = 15;
    
    self.scrollView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self ,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
    self.topLine.sd_layout
    .leftSpaceToView(self.scrollView, 0)
    .rightSpaceToView(self.scrollView, 0)
    .topSpaceToView(self.scrollView, 0)
    .heightIs(.5);
    
    self.midLine.sd_layout
    .leftSpaceToView(self.scrollView, 15)
    .rightSpaceToView(self.scrollView, 0)
    .topSpaceToView(self.scrollView, 45)
    .heightIs(.5);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.scrollView, 15)
    .rightSpaceToView(self.scrollView, 15)
    .topSpaceToView(self.topLine, 0)
    .bottomSpaceToView(self.midLine, 0);
    
    self.bottomLine.sd_layout.heightIs(.5)
    .leftSpaceToView(self.scrollView, 0)
    .rightSpaceToView(self.scrollView, 0)
    .bottomSpaceToView(self.scrollView, 0);
    
    // 固定两侧的宽度
    CGFloat leftW = kLeftLabelWidth;
    CGFloat leftH = 18;
    CGFloat rightW = SCREEN_WIDTH - 15*3 - leftW;
    CGFloat rightH = 0;
    
    // 1 信用号
    self.LB1.sd_layout
    .leftSpaceToView(self.scrollView, marginLefitSuper)
    .topSpaceToView(self.midLine, marginTop)
    .widthIs(leftW)
    .heightIs(leftH);
    
    self.LB1_2.sd_layout
    .leftSpaceToView(self.scrollView, marginLefitSuper)
    .topSpaceToView(self.LB1, 2)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [self heightOfLabel:self.LB1R];
    self.LB1R.sd_layout
    .leftSpaceToView(self.LB1, marginLefitSuper)
    .topEqualToView(self.LB1)
    .widthIs(rightW)
    .heightIs(rightH);
    
    // 2 名称
    self.LB2.sd_layout
    .leftSpaceToView(self.scrollView, marginLefitSuper)
    .topSpaceToView(self.LB1_2, marginTop)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [self heightOfLabel:self.LB2R];
    self.LB2R.sd_layout
    .leftSpaceToView(self.LB2, marginLefitSuper)
    .topEqualToView(self.LB2)
    .widthIs(rightW)
    .heightIs(rightH);
    
    
     //3 类型开始：
    for (int i=1; i<_LeftLabelArr.count;i++ ) {
        UILabel *oldL =_LeftLabelArr[i-1];
        UILabel *leftL =_LeftLabelArr[i];
        UILabel *rightL =_RightLabelArr[i];
        leftL.sd_layout
        .leftSpaceToView(self.scrollView, marginLefitSuper)
        .topSpaceToView(oldL, marginTop)
        .widthIs(leftW)
        .heightIs(leftH);
        
        rightH = [self heightOfLabel:rightL];
        rightL.sd_layout
        .leftSpaceToView(leftL, marginLefitSuper)
        .topEqualToView(leftL)
        .widthIs(rightW)
        .heightIs(rightH);
    }
    
    [self.scrollView setupAutoContentSizeWithBottomView:self.bottomLine bottomMargin:0];
    
}
#pragma mark 获取高度
- (CGFloat)heightOfLabel:(UILabel *)contentLabel {
    
    NSString *content  = contentLabel.text;
    CGFloat maxWidth = SCREEN_WIDTH - 15*3 - kLeftLabelWidth;
    
    if (!content) {
        return 20;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    contentLabel.attributedText = attributedString;
    CGSize size = CGSizeMake(maxWidth, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    CGRect frame = contentLabel.frame;
    frame.size = labelSize;
    return frame.size.height;
    
}
+(CGFloat)heightOfHeader{
    if (0) {// 分别计算截个model 的高度，统计之
        return  45+ 15*13 +18*13+2 ;
    }
    return  45+ 15*13 +18*13+2 ;
}



#pragma mark 工厂方法：
/** 左侧标题 */
- (UILabel *)grayTitleLBWithTitle:(NSString *)title {
    UILabel *lb = [UILabel new];
    lb.font = Font15;
    lb.text = title;
    lb.textAlignment = NSTextAlignmentRight;
    lb.textColor = RGB_grayNormalText;
    return lb;
}
/** 右侧内容 */
- (UILabel *)contentLB {
    UILabel *lb = [UILabel new];
    lb.font = Font15;
    lb.textAlignment = NSTextAlignmentLeft;
    lb.textColor = RGB_black;
    lb.numberOfLines = 0;
    lb.text = @"--";
    return lb;
}

/** 分割线 */
- (UIView *)line {
    UIView *line = [UIView new];
    line.backgroundColor = RGB_grayLine;
    return line;
}



@end
