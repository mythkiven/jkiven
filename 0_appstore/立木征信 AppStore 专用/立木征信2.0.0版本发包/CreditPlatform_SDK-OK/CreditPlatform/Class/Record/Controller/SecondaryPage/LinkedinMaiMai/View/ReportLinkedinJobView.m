//
//  ReportLinkedinJobView.m
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
#define LeftLabelW 65
//label高度
#define LeftLabelH 15
//label宽度 右侧
#define RightLabelW 160
//行高  
#define LineSpacing 7

#import "ReportLinkedinJobView.h"
@interface ReportLinkedinJobView ()
@property (strong,nonatomic) UILabel   *company;
@property (strong,nonatomic) UILabel   *L1;//职位
@property (strong,nonatomic) UILabel   *L2;//开始时间
@property (strong,nonatomic) UILabel   *L3;//结束时间
@property (strong,nonatomic) UILabel   *L4;//描述
@property (strong,nonatomic) UILabel   *L5;//备注XX
@property (strong,nonatomic) UILabel   *L6;//备注内容
@property (strong,nonatomic) UIView   *Line1;
@property (strong,nonatomic) UIView   *Line2;

@end


@implementation ReportLinkedinJobView

- (instancetype)reportLinkedinJobViewWith:(UITableView*)tableview{

    
    static NSString *TableSampleIdentifier = @"ReportLinkedinJobView";
    
    ReportLinkedinJobView *cell = [tableview dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell =[[ReportLinkedinJobView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
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
//    UIView *line1 = [JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:self.contentView];
    
    _company = [JFactoryView JlabelWith:CGRectMake(leftSpace, 0.5, SCREEN_WIDTH-15, 44) Super:self.contentView Color:RGB_black Font:18.0 Alignment:0 Text:@"--"];
    UIView *line2 = [JFactoryView JLineWith:CGRectMake(15, MaxY(_company.frame), SCREEN_WIDTH-15, 0.5) Super:self.contentView];
    
    UILabel *L2 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(line2.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"职位"];
    UILabel *L3 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L2.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"开始日期"];
    UILabel *L4 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L3.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"结束日期"];
    UILabel *L5 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L4.frame)+verSpace, LeftLabelW, LeftLabelH) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"工作描述"];
    
    
    //
    
    _L1 = [JFactoryView JlabelWith:CGRectMake(MaxX(L2.frame)+leftSpace, MinY(L2.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"-1-"];
    _L2 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L3.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"-2-"];
    _L3 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L4.frame), RightLabelW, LeftLabelH) Super:self.contentView Color:RGB_black Font:15.0 Alignment:0 Text:@"-3-"];
    _L4 = [JFactoryView JlabelWith:CGRectMake(30, MaxY(L5.frame)+15, SCREEN_WIDTH-60, 60) Super:self.contentView Color:RGB_black Font:13.0 Alignment:0 Text:_L4.text];
    _Line1 = [JFactoryView JLineWith:CGRectMake(15, MaxY(_L4.frame)+15, SCREEN_WIDTH, 0.5) Super:self.contentView];

    _L5 =[JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(_L4.frame)+15, SCREEN_WIDTH-15, 32) Super:self.contentView Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"备注"];
    _L6 = [JFactoryView JlabelWith:CGRectMake(MaxY(_L5.frame)+15, MinY(_L5.frame), SCREEN_WIDTH-15*2-40, 44) Super:self.contentView Color:RGB_black Font:15.0 Alignment:2 Text:@"-5-"];
    _Line2 = [JFactoryView JLineWith:CGRectMake(0, MaxY(_L5.frame)+15, SCREEN_WIDTH, 0.5) Super:self.contentView];
    
    
}
-(void)drawRect:(CGRect)rect{
    if (_L4.text.length) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_L4.text];
        [attributedString addAttribute:NSFontAttributeName value:_L4.font range:NSMakeRange(0, [_L4.text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [paragraphStyle setAlignment:0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_L4.text length])];
        _L4.attributedText = attributedString;
//        _L4.backgroundColor =RGB_red;
        
    }
    
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        _L5.hidden =NO;
        _L6.hidden =NO;
        _Line2.hidden =NO;
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        _L5.hidden =YES;
        _L6.hidden =YES;
        _Line2.hidden =YES;
    }
    
    
}


-(void)layoutSubviews {
    
    CGFloat MAXW = SCREEN_WIDTH - 60;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = LineSpacing;
    CGFloat height= [_L4.text
                     boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
    
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        if (_L4.text.length) {
            
            
            _L4.frame  = CGRectMake(30, MaxY(_L3.frame)+verSpace+LeftLabelH+15, SCREEN_WIDTH-30*2, height);
            _L4.numberOfLines = (NSInteger)height/13;
            //-30
            _Line1.frame =CGRectMake(15, MaxY(_L4.frame)+15, SCREEN_WIDTH-15, 0.5);
            _L5.frame =CGRectMake(15, MaxY(_Line1.frame), 32, 44);
            _L6.frame =CGRectMake(MaxX(_L5.frame)+15, MinY(_L5.frame), SCREEN_WIDTH-15*2-40, 44);
            _Line2.frame =CGRectMake(0, MaxY(_L5.frame), SCREEN_WIDTH, 0.5);
        } else {
            _Line1.frame =CGRectMake(15, 45+1+4*(verSpace+LeftLabelH)+15, SCREEN_WIDTH-15, 0.5);
            _L5.frame =CGRectMake(15, MaxY(_Line1.frame), 32, 44);
            _L6.frame =CGRectMake(MaxX(_L5.frame)+15, MinY(_L5.frame), SCREEN_WIDTH-15*2-40, 44);
            _Line2.frame =CGRectMake(0, MaxY(_L5.frame), SCREEN_WIDTH, 0.5);
        }
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        if (_L4.text.length) {
            
            _L4.frame  = CGRectMake(30, MaxY(_L3.frame)+verSpace+LeftLabelH+15, SCREEN_WIDTH-30*2, height);
            _L4.numberOfLines = (NSInteger)height/13;
            _Line1.frame =CGRectMake(0, MaxY(_L4.frame)+15, SCREEN_WIDTH-15, 0.5);
        } else {
            _Line1.frame =CGRectMake(0, 45+1+4*(verSpace+LeftLabelH)+15, SCREEN_WIDTH, 0.5);
        }
    }
    
    
    
    
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}



-(void)setLinkModel:(workInfoLY *)linkModel{
    _linkModel = linkModel;
    _company.text = FillSpace(linkModel.company);
    _L1.text = FillSpace(linkModel.position);
    _L2.text = FillSpace(linkModel.startDate);
    _L3.text = FillSpace(linkModel.endDate);
    
    _L4.text = [NSString  newString:linkModel.workDesc];
    _L6.text = linkModel.remark;
    [self setNeedsLayout];
}
-(void)setMmModel:(workInfoMM *)mmModel{
    _mmModel = mmModel;
    _company.text = FillSpace(mmModel.company);
    _L1.text = FillSpace(mmModel.position);
    _L2.text = FillSpace(mmModel.startDate);
    _L3.text = FillSpace(mmModel.endDate);
    _L4.text = [NSString  newString:mmModel.workDesc];
    _L6.text = mmModel.remark;
    [self setNeedsLayout];
}
+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type{
    
    if (type == SearchItemTypeMaimai) {//脉脉
        if (str.length) {
            CGFloat MAXW = SCREEN_WIDTH - 60;
            str = [NSString  newString:str];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = LineSpacing;
            CGFloat height= [str
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            //
            return 45+4*(verSpace+LeftLabelH)  +2*15+45+ height;
        }
        //+10
        return 45+1+4*(verSpace+LeftLabelH) +15 +45;
    } else if (type == SearchItemTypeLinkedin){//领英
        if (str.length) {
            CGFloat MAXW = SCREEN_WIDTH - 60;
            str = [NSString  newString:str];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = LineSpacing;
            CGFloat height= [str
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            //
            return 45+4*(verSpace+LeftLabelH)  +2*15+ height+0.5;
        }
        //+10 45+1+4*(verSpace+LeftLabelH)+15
        return 45+1+4*(verSpace+LeftLabelH) +15;
    }
    
    return 0;
    
}


@end
