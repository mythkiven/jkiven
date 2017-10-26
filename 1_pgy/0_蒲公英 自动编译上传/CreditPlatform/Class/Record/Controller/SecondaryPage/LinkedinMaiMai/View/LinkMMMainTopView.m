//
//  LinkMMMainTopView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LinkMMMainTopView.h"
@interface LinkMMMainTopView()


@property (weak, nonatomic) IBOutlet SpaceLabel *realName;
@property (weak, nonatomic) IBOutlet SpaceLabel *sex;
@property (weak, nonatomic) IBOutlet SpaceLabel *HYFXiang;
@property (weak, nonatomic) IBOutlet SpaceLabel *YXli;
@property (weak, nonatomic) IBOutlet SpaceLabel *company;
@property (weak, nonatomic) IBOutlet SpaceLabel *Job;
@property (weak, nonatomic) IBOutlet SpaceLabel *area;
@property (weak, nonatomic) IBOutlet SpaceLabel *adress;

@property (weak, nonatomic) IBOutlet SpaceLabel *maimai;
@property (weak, nonatomic) IBOutlet SpaceLabel *phone;
@property (weak, nonatomic) IBOutlet SpaceLabel *mail;

@property (weak, nonatomic) IBOutlet UILabel *codeMMLY;


@end


@implementation LinkMMMainTopView
+ (id)linkMMMainTopViewView:(SearchItemType)type{
    if (type == SearchItemTypeMaimai) {//脉脉
        return [[[NSBundle mainBundle] loadNibNamed:@"LinkMMMainTopView" owner:nil options:nil] firstObject];
    } else if (type == SearchItemTypeLinkedin){//领英
        return [[[NSBundle mainBundle] loadNibNamed:@"LinkMMMainTopView" owner:nil options:nil] lastObject];
    }
    
    return nil;
    
    
}
- (void)drawRect:(CGRect)rect {
    
    
}

-(void)setLinkModel:(cardInfoLY *)linkModel{
    _linkModel = linkModel;
    
    _realName.text = FillSpace(linkModel.name) ;
    _sex.text = FillSpace(linkModel.gender);
    _HYFXiang.text = FillSpace(linkModel.vocation);
    _YXli.text = FillSpace(linkModel.rank);
    _company.text = FillSpace(linkModel.company);
    _Job.text = FillSpace(linkModel.position);
    if (!linkModel.workCity) {
        linkModel.workCity = @"";
    }
    if (!linkModel.workProvince) {
        linkModel.workProvince = @"";
    }
    
    _area.text = [linkModel.workProvince stringByAppendingString:linkModel.workCity];
    _adress.text = FillSpace(linkModel.workAddress);
    
    
    _maimai.text = FillSpace(linkModel.no);
    _phone.text = FillSpace(linkModel.mobile);
    _mail.text = FillSpace(linkModel.email);
    
}
-(void)setMmModel:(cardInfoMM *)mmModel{
    _mmModel = mmModel;
    
    _realName.text = FillSpace(mmModel.name);
    _sex.text = FillSpace(mmModel.gender);
    _HYFXiang.text = FillSpace(mmModel.vocation);
    _YXli.text = FillSpace(mmModel.rank);
    _company.text = FillSpace(mmModel.company);
    _Job.text = FillSpace(mmModel.position);
    if (!mmModel.workCity) {
        mmModel.workCity = @"";
    }
    if (!mmModel.workProvince) {
        mmModel.workProvince = @"";
    }
    
    _area.text = [mmModel.workProvince stringByAppendingString:mmModel.workCity];
    _adress.text = FillSpace(mmModel.workAddress);
    
    
    _maimai.text = FillSpace(mmModel.no);
    _phone.text = FillSpace(mmModel.mobile);
    _mail.text = FillSpace(mmModel.email);
    
}






@end
