//
//  ReportLinkedinBaseInfoView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportLinkedinBaseInfoView.h"

//行高
#define LineSpacing 7

@interface ReportLinkedinBaseInfoView ()
@property (weak, nonatomic) IBOutlet UILabel *friend;
@property (weak, nonatomic) IBOutlet UILabel *zima;
@property (weak, nonatomic) IBOutlet UILabel *hudong;


@property (weak, nonatomic) IBOutlet UILabel *yuanchuang;
@property (weak, nonatomic) IBOutlet UILabel *zhuanlan;
@property (weak, nonatomic) IBOutlet UILabel *idear;
@property (weak, nonatomic) IBOutlet UILabel *assess;


@property (weak, nonatomic) IBOutlet UILabel *provice;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *TAG;
@property (weak, nonatomic) IBOutlet UILabel *selfIntro;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selfInfoH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selfInfoHmm;
/**
 
 
 if (type == SearchItemTypeMaimai) {//脉脉
 
 } else if (type == SearchItemTypeLinkedin){//领英
 
 }
 
 */

@end

@implementation ReportLinkedinBaseInfoView
+ (id)reportLinkedinBaseInfoView:(SearchItemType)type{
    if (type == SearchItemTypeMaimai) {//脉脉
        return [[[NSBundle mainBundle] loadNibNamed:@"ReportLinkedinBaseInfoView" owner:nil options:nil] firstObject];
    } else if (type == SearchItemTypeLinkedin){//领英
        return [[[NSBundle mainBundle] loadNibNamed:@"ReportLinkedinBaseInfoView" owner:nil options:nil] lastObject];
    }
    
    return nil;
}
-(void)awakeFromNib {
    [super awakeFromNib];
      
}

-(void)drawRect:(CGRect)rect{
    if (_selfIntro.text.length) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_selfIntro.text];
        [attributedString addAttribute:NSFontAttributeName value:_selfIntro.font range:NSMakeRange(0, [_selfIntro.text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [paragraphStyle setAlignment:0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_selfIntro.text length])];
        _selfIntro.attributedText = attributedString;
        //        _L4.backgroundColor =RGB_red;
        
    }
    
}



-(void)layoutSubviews{
    CGFloat MAXW = SCREEN_WIDTH - 91.5-15;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = LineSpacing;
    CGFloat height= [_selfIntro.text
                     boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
    if (self.searchType == SearchItemTypeMaimai) {//脉脉
        CGRect frame = CGRectMake(91.5, 4*35+15,SCREEN_WIDTH- 91.5-15, height);
        _selfIntro.frame = frame;
        _selfIntro.numberOfLines = (NSInteger)height/15+1;
    } else if (self.searchType == SearchItemTypeLinkedin){//领英
//        if (!_selfIntro.text.length) {
            CGRect frame = CGRectMake(91.5, 2*35+15,SCREEN_WIDTH- 91.5-15, height);
            _selfIntro.frame = frame;
            _selfIntro.numberOfLines = (NSInteger)height/15+1;
//        }else{
//            CGRect frame = CGRectMake(91.5, 2*35+15,SCREEN_WIDTH- 91.5-15, height);
//            _selfIntro.frame = frame;
//            _selfIntro.numberOfLines = (NSInteger)height/15+1;
//        }
        
    }
    
    
    
   
//    if (height<15 || !_selfIntro.text.length) {
//        _selfInfoH.constant = 15;
//        _selfInfoHmm.constant = 15;
//    } else {
//       _selfInfoH.constant = height;
//        _selfInfoHmm.constant = height;
//    }
    
    
    
    
    
}





-(void)setMmModel:(baseInfoMM *)mmModel{
    _mmModel = mmModel;
    _friend.text = FillSpace(mmModel.freindNum);
    _zima.text = FillSpace(mmModel.myZhima);
    _hudong.text = FillSpace(mmModel.myInteract);
    
    _yuanchuang.text = FillSpace(mmModel.myFeed);
    _zhuanlan.text = FillSpace(mmModel.myArticle);
    _idear.text =FillSpace( mmModel.myOpinion);
    _assess.text = FillSpace(mmModel.myComment);
    
    _provice.text = FillSpace(mmModel.htProvince);
    _city.text = FillSpace(mmModel.htCity);
    _birthday.text = FillSpace(mmModel.birthday);
    _TAG.text = FillSpace(mmModel.weiboTags);
    _selfIntro.text =  [NSString  newString:mmModel.myIntroduction];
    if ([_selfIntro.text hasStr:@"\n"]) {
        _selfIntro.text =[_selfIntro.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    [self setNeedsLayout];
    
}

-(void)setLinkModel:(baseInfoLY *)linkModel{
    _linkModel = linkModel;
    _friend.text = FillSpace(linkModel.freindNum);
    _zima.text = FillSpace(linkModel.myZhima);
    _hudong.text = FillSpace(linkModel.myInteract);
    
    _yuanchuang.text = FillSpace(linkModel.myFeed);
    _zhuanlan.text = FillSpace(linkModel.myArticle);
    _idear.text = FillSpace(linkModel.myOpinion);
    _assess.text = FillSpace(linkModel.myComment);
    
    _provice.text = FillSpace(linkModel.htProvince);
    _city.text = FillSpace(linkModel.htCity);
    _birthday.text = FillSpace(linkModel.birthday);
    _TAG.text = FillSpace(linkModel.weiboTags);
    _selfIntro.text =  [NSString  newString:linkModel.myIntroduction];
    if ([_selfIntro.text hasStr:@"\n"]) {
        _selfIntro.text =[_selfIntro.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    [self setNeedsLayout];
}
+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type{
    
    if (type == SearchItemTypeMaimai) {//脉脉
        if (  str.length) {
            str = [NSString  newString:str];
            
            CGFloat MAXW = SCREEN_WIDTH - 91.5-15;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = LineSpacing;
            CGFloat height= [str
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            return  170 +4*(15+20) +20+height;
        }
        
        return 170 +4*(15+20) +15+20;
    } else if (type == SearchItemTypeLinkedin){//领英
        if (  str.length) {
            str = [NSString  newString:str];
            
            CGFloat MAXW = SCREEN_WIDTH - 91.5-15;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = LineSpacing;
            CGFloat height= [str
                             boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
            return  80 +3*15+2*20+4.5+height +10;
        }
        
        return 80 +3*15+2*20+15  +15;
    }
    
    return 0;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


@end
