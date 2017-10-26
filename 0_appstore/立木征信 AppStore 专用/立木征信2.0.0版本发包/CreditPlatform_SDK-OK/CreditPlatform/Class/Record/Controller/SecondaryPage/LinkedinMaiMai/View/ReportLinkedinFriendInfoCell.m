//
//  ReportLinkedinFriendInfoView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "JFactoryView.h"

//左侧边距
#define leftSpace 15
//垂直边距
#define verSpace 20
//label宽度 左侧
#define LeftLabelW 60
//label高度
#define LeftLabelH 15
//label宽度 右侧
#define RightLabelW (SCREEN_WIDTH -35-15-LeftLabelW)




#import "ReportLinkedinFriendInfoCell.h"
@interface ReportLinkedinFriendInfoCell ()
@property (strong,nonatomic) UILabel   *L0;//姓名
@property (strong,nonatomic) UILabel   *L1;//公司
@property (strong,nonatomic) UILabel   *L2;//职位

@end
@implementation ReportLinkedinFriendInfoCell
{
    UILabel *L1,*L2;
    UIView *line1,*line2;
    UIButton *button;
}
+ (instancetype)reportLinkedinFriendInfoCell:(UITableView*)tableview{
    
    static NSString *TableSampleIdentifier = @"ReportLinkedinFriendInfoCellQ1";
    
    ReportLinkedinFriendInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell =[[ReportLinkedinFriendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }
    return cell;
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatView];
    }
    return self;
}

-(void)creatView {
    self.backgroundColor = RGB_white;
    
    
    _L0 = [JFactoryView JlabelWithSuper:self.contentView Color:RGB_black Font:18.0 Alignment:0 Text:@"--"];
    L1 = [JFactoryView JlabelWithSuper:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"公司"];
    L2 = [JFactoryView JlabelWithSuper:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"职位"];
    
    _L1 = [JFactoryView JlabelWithSuper:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L2 = [JFactoryView JlabelWithSuper:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    line2 = [JFactoryView JLineWithSuper:self.contentView];
    
    // 15 20- 20 15 -20 15- 15   60 60 
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted =NO;
    [button setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    _L0.frame =CGRectMake(leftSpace, 0+15, SCREEN_WIDTH-15, 20);
    L1.frame = CGRectMake(0, MaxY(_L0.frame)+verSpace, LeftLabelW, LeftLabelH) ;
    L2.frame =CGRectMake(0, MaxY(L1.frame)+verSpace, LeftLabelW, LeftLabelH);
    _L1.frame = CGRectMake(MaxX(L1.frame)+15, MinY(L1.frame), RightLabelW, LeftLabelH);
    _L2.frame = CGRectMake(MaxX(L2.frame)+15, MinY(L2.frame), RightLabelW, LeftLabelH);
    line2.frame = CGRectMake(0, MaxY(_L2.frame)+15, SCREEN_WIDTH, 0.5);
    button.frame = CGRectMake(SCREEN_WIDTH-10-15, (MaxY(line2.frame)-15)/2, 10, 15);
}

-(void)setMmModel:(friendInfoMM *)mmModel{
    _mmModel =mmModel;
    _L2.text =nil;
    _L1.text =nil;
    _L0.text =nil;
    _L0.text =FillSpace(mmModel.name) ;
    _L1.text =FillSpace(mmModel.company);
    _L2.text =FillSpace(mmModel.position);
    
//    [self setNeedsLayout];
}

-(void)setLinkModel:(friendInfoLY *)linkModel{
    _linkModel =linkModel;
    MYLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    _L2.text =nil;
    _L1.text =nil;
    _L0.text =nil;
    _L0.text =FillSpace(linkModel.name);
    _L1.text =FillSpace(linkModel.company);
    _L2.text =FillSpace(linkModel.position);
    
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


-(void)setCellHelight:(CGFloat)cellHelight{
    
}


@end
