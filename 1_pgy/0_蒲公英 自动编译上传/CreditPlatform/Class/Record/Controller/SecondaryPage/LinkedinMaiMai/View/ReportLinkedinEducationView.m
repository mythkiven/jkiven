//
//  YJReportLinkedinEducationView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "JFactoryView.h"
#import "ReportLinkedinEducationView.h"
#define LineSpacing 8
#define leftSpace 15
#define verSpace 10

#define LeftLabelW 65
#define LeftLabelH 15

#define RightLabelW 180

@interface ReportLinkedinEducationView ()

//@property (strong,nonatomic) UIScrollView   *SC;

@property (strong,nonatomic) UILabel   *L1;
@property (strong,nonatomic) UILabel   *L2;
@property (strong,nonatomic) UILabel   *L3;
@property (strong,nonatomic) UILabel   *L4;
@property (strong,nonatomic) UILabel   *L5;
@property (strong,nonatomic) UILabel   *L6;
@property (strong,nonatomic) UILabel   *L06;
@property (strong,nonatomic) UIView   *Line;

@end

@implementation ReportLinkedinEducationView
- (instancetype)reportLinkedinEducationCell:(UITableView*)tableview{
    
    
    static NSString *TableSampleIdentifier = @"ReportLinkedinEducationViewW1";
    
    ReportLinkedinEducationView *cell = [tableview dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell =[[ReportLinkedinEducationView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
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
//    UIView *line1 = [JFactoryView JLineWith:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) Super:self];

    UILabel *L1 = [JFactoryView JlabelWith:CGRectMake(leftSpace, 0.5+LeftLabelH, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"学校"];
    UILabel *L2 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L1.frame)+verSpace*2, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"专业"];
    UILabel *L3 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L2.frame)+verSpace*2, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"学历"];
    UILabel *L4 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L3.frame)+verSpace*2, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"开始日期"];
    UILabel *L5 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L4.frame)+verSpace*2, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"结束日期"];
    _L06 = [JFactoryView JlabelWith:CGRectMake(leftSpace, MaxY(L5.frame)+verSpace*2, LeftLabelW, LeftLabelH) Super:self Color:RGB_grayNormalText Font:15.0 Alignment:2 Text:@"教育描述"];
    
    _L1 = [JFactoryView JlabelWith:CGRectMake(MaxX(L1.frame)+leftSpace, 0.5+LeftLabelH, RightLabelW, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L2 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L2.frame), RightLabelW, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L3 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L3.frame), RightLabelW, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L4 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L4.frame), RightLabelW, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L5 = [JFactoryView JlabelWith:CGRectMake(MinX(_L1.frame), MinY(L5.frame), RightLabelW, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _L6 = [JFactoryView JlabelWith:CGRectMake(30, MaxY(_L06.frame), SCREEN_WIDTH-30*2, LeftLabelH) Super:self Color:RGB_black Font:15.0 Alignment:0 Text:@"--"];
    _Line = [JFactoryView JLineWith:CGRectMake(0, MaxY(_L6.frame)+15, SCREEN_WIDTH, 0.5) Super:self];
    
}

//-(void)layoutSubviews {
//    MYLog(@"-----");

//    CGFloat MAXW = SCREEN_WIDTH - 60;
//    CGFloat height= [_L6.text
//                     boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.height;
//    _L6.frame  = CGRectMake(30, MaxY(_L6.frame), SCREEN_WIDTH-30*2, height);
//    
//    _L6.numberOfLines = (NSInteger)height/15+1;
//    _Line.frame = CGRectMake(0, MaxY(_L6.frame)+15, SCREEN_WIDTH, 0.5);
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_Line.frame));
//}

-(void)drawRect:(CGRect)rect{
    if (_L6.text.length) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_L6.text];
        [attributedString addAttribute:NSFontAttributeName value:_L6.font range:NSMakeRange(0, [_L6.text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [paragraphStyle setAlignment:0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_L6.text length])];
        _L6.attributedText = attributedString;
//        _L6.backgroundColor =RGB_red;
    }
    
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        _L06.hidden =NO;
        _L6.hidden =NO;
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        _L06.hidden =YES;
        _L6.hidden =YES;
    }
    
    
    
}
-(void)setMmModel:(educationInfoMM *)mmModel{
    _mmModel= mmModel;
    _L1.text = mmModel.school;
    _L2.text = mmModel.major;
    _L3.text = mmModel.degree;
    _L4.text = mmModel.startDate;
    _L5.text = mmModel.endDate;
    _L6.text =  [NSString  newString:mmModel.educationDesc];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = LineSpacing;
    CGFloat MAXW = SCREEN_WIDTH - 60;
    CGFloat height= [_L6.text
                     boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
    
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        _L6.frame  = CGRectMake(30, MaxY(_L5.frame)+20+15+15, SCREEN_WIDTH-30*2, height);
        
        _L6.numberOfLines = (NSInteger)height/15+1;
        if (_L6.text.length) {
            _Line.frame = CGRectMake(0, MaxY(_L6.frame)+15, SCREEN_WIDTH, 0.5);
        }else{
            _Line.frame = CGRectMake(0, MaxY(_L5.frame)+20+15*2, SCREEN_WIDTH, 0.5);
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_Line.frame));
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        _Line.frame = CGRectMake(0, MaxY(_L5.frame)+20+15*2, SCREEN_WIDTH, 0.5);
        
    }
    
    
    
    
  
}
-(void)setLinkModel:(educationInfoLY *)linkModel{
    _linkModel= linkModel;
    _L1.text = linkModel.school;
    _L2.text = linkModel.major;
    _L3.text = linkModel.degree;
    _L4.text = linkModel.startDate;
    _L5.text = linkModel.endDate;
    _L6.text = [NSString  newString:linkModel.educationDesc];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = LineSpacing;
    CGFloat MAXW = SCREEN_WIDTH - 60;
    CGFloat height= [_L6.text
                     boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        _L6.frame  = CGRectMake(30, MaxY(_L5.frame)+20+15+15, SCREEN_WIDTH-30*2, height);
        
        _L6.numberOfLines = (NSInteger)height/15+1;
        if (_L6.text.length) {
            _Line.frame = CGRectMake(0, MaxY(_L6.frame)+15, SCREEN_WIDTH, 0.5);
        }else{
            _Line.frame = CGRectMake(0, MaxY(_L5.frame)+20+15*2, SCREEN_WIDTH, 0.5);
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_Line.frame));
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
        _Line.frame = CGRectMake(0, MaxY(_L5.frame)+20, SCREEN_WIDTH, 0.5);
        
    }
    
    
}

+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type{
    
    if (type == SearchItemTypeMaimai) {//脉脉
        if (str.length) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = LineSpacing;
            CGFloat MAXW = SCREEN_WIDTH - 60;
            str = [NSString  newString:str];
            CGFloat Height= [str
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            
            return  5*(verSpace*2+LeftLabelH)+LeftLabelH*4+Height;
        }
        return  5*(verSpace*2+LeftLabelH)+LeftLabelH*3;
    } else if (type == SearchItemTypeLinkedin){//领英
        return  5*(verSpace*2+LeftLabelH)+LeftLabelH;
    }
    
   
    
    return 0;
    
}



@end
