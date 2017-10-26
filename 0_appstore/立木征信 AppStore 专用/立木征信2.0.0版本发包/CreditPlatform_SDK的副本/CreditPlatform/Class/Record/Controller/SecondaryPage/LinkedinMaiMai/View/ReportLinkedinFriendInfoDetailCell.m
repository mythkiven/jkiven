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
#define LeftLabelW 100
//label高度
#define LeftLabelH 15
//label宽度 右侧
#define RightLabelW (SCREEN_WIDTH -15-15-LeftLabelW)



#import "ReportLinkedinFriendInfoDetailCell.h"
@interface ReportLinkedinFriendInfoDetailCell ()

/**姓名*/
@property (strong,nonatomic) UILabel   *L0;
/**ID*/
@property (strong,nonatomic) UILabel   *L1;
/**公司*/
@property (strong,nonatomic) UILabel   *L2;
/**职位*/
@property (strong,nonatomic) UILabel   *L3;

/**性别*/
@property (strong,nonatomic) UILabel   *L4;
/**形象力*/
@property (strong,nonatomic) UILabel   *L5;
/**关系*/
@property (strong,nonatomic) UILabel   *L6;
/**关系描述*/
@property (strong,nonatomic) UILabel   *L7;
/**公司职位认证*/
@property (strong,nonatomic) UILabel   *L8;
/**手机号*/
@property (strong,nonatomic) UILabel   *L9;
/**邮箱*/
@property (strong,nonatomic) UILabel   *L10;

@end
@implementation ReportLinkedinFriendInfoDetailCell

- (instancetype)reportLinkedinFriendInfoDetailCell:(UITableView*)tableview{
    
    
    
    static NSString *TableSampleIdentifier = @"ReportLinkedinFriendInfoDetailCell";
    
    ReportLinkedinFriendInfoDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell =[[ReportLinkedinFriendInfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    UIView *line1 = [JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:self.contentView];
    
    _L0 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(line1.frame), SCREEN_WIDTH-15, 44) Super:self.contentView Color:RGB_black Font:18.0 Alignment:0 Text:@"--"];
    UIView *line2 = [JFactoryView JLineWith:CGRectMake(15, MaxY(_L0.frame), SCREEN_WIDTH-15, 0.5) Super:self.contentView];
    
    UILabel *L1 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(line2.frame)+15, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"脉脉ID" tag:88];
    UILabel *L2 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L1.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"公司"];
    UILabel *L3 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L2.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"职位"  tag:100];
    UILabel *L4 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L3.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"性别" tag:101];
    UILabel *L5 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L4.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"影响力" tag:102];
    UILabel *L6 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L5.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"关系" tag:103];
    UILabel *L7 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L6.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"关系描述" tag:104];
    UILabel *L8 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L7.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"公司职位认证" tag:105];
    UILabel *L9 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L8.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"手机号" tag:106];
    UILabel *L10 = [JFactoryView JlabelWith:CGRectMake(0, MaxY(L9.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"邮箱" tag:107];
    
    //
    
    _L1 = [JFactoryView JlabelWith:CGRectMake(MaxX(L1.frame)+leftSpace, MinY(L1.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L2 = [JFactoryView JlabelWith:CGRectMake(MaxX(L2.frame)+leftSpace, MinY(L2.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L3 = [JFactoryView JlabelWith:CGRectMake(MaxX(L3.frame)+leftSpace, MinY(L3.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L4 = [JFactoryView JlabelWith:CGRectMake(MaxX(L4.frame)+leftSpace, MinY(L4.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    
    _L5 =[JFactoryView JlabelWith:CGRectMake(MaxX(L5.frame)+leftSpace, MinY(L5.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L6 = [JFactoryView JlabelWith:CGRectMake(MaxX(L6.frame)+leftSpace, MinY(L6.frame),RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L7 = [JFactoryView JlabelWith:CGRectMake(MaxX(L7.frame)+leftSpace, MinY(L7.frame),RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L8 = [JFactoryView JlabelWith:CGRectMake(MaxX(L8.frame)+leftSpace, MinY(L8.frame),RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L9 = [JFactoryView JlabelWith:CGRectMake(MaxX(L9.frame)+leftSpace, MinY(L9.frame),RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L10 = [JFactoryView JlabelWith:CGRectMake(MaxX(L10.frame)+leftSpace, MinY(L10.frame),RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    
    [JFactoryView JLineWith:CGRectMake(0, MaxY(L10.frame)+15, SCREEN_WIDTH, 0.5) Super:self.contentView tag:99];
    
}
-(void)layoutSubviews{
    
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        for (UIView *sub in self.subviews) {
            sub.hidden =NO;
        }
        
        
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        UIView *sub0,*sub1,*sub2,*line; UILabel *sub3;
        for (UIView *sub in self.contentView.subviews) {
            if (sub.tag == 88)                  sub3 = (UILabel*)sub;
            if (sub.tag == 99)                  line = sub;
            if (sub.tag == 100)                 sub0 = sub;
            if (sub.tag>=101 &&sub.tag<=105)    sub.hidden =YES;
            if (sub.tag == 106)                 sub1 = sub;
            if (sub.tag == 107)                 sub2 = sub;
        }
        sub3.text = @"领英ID";
        sub1.frame = CGRectMake(0, MaxY(sub0.frame)+verSpace, LeftLabelW, LeftLabelH);
        sub2.frame = CGRectMake(0, MaxY(sub1.frame)+verSpace, LeftLabelW, LeftLabelH);
        line.frame = CGRectMake(0, MaxY(sub2.frame)+15, SCREEN_WIDTH, 0.5);
        _L4.hidden =YES;
        _L5.hidden =YES;
        _L6.hidden =YES;
        _L7.hidden =YES;
        _L8.hidden =YES;
        _L9.frame = CGRectMake(MaxX(sub1.frame)+leftSpace, MinY(sub1.frame),RightLabelW, LeftLabelH);
        _L10.frame = CGRectMake(MaxX(sub2.frame)+leftSpace, MinY(sub2.frame),RightLabelW, LeftLabelH);
    }
    
}
-(void)setMmModel:(friendInfoMM *)mmModel{
    _mmModel =mmModel;
    
    _L0.text = FillSpace(mmModel.name);
    _L1.text = FillSpace(mmModel.cid);
    _L2.text = FillSpace(mmModel.company);
    _L3.text = FillSpace(mmModel.position);
    _L4.text = FillSpace(mmModel.gender);
    _L5.text = FillSpace(mmModel.rank);
    _L6.text = FillSpace(mmModel.dist);
    _L7.text = FillSpace(mmModel.relationDesc);
    _L8.text = FillSpace(mmModel.composAuth);
    _L9.text = FillSpace(mmModel.phone);
    _L10.text = FillSpace(mmModel.email);
}

-(void)setLinkModel:(friendInfoLY *)linkModel{
    _linkModel =linkModel;
    
    _L0.text = FillSpace(linkModel.name);
    _L1.text = FillSpace(linkModel.cid);
    _L2.text = FillSpace(linkModel.company);
    _L3.text = FillSpace(linkModel.position);
    _L4.text = FillSpace(linkModel.gender);
    _L5.text = FillSpace(linkModel.rank);
    _L6.text = FillSpace(linkModel.dist);
    _L7.text = FillSpace(linkModel.relationDesc);
    _L8.text = FillSpace(linkModel.composAuth);
    _L9.text = FillSpace(linkModel.phone);
    _L10.text= FillSpace(linkModel.email);
}













@end
