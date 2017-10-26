//
//  ReportCreditEmailBillDetailsHeader.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCreditEmailBillDetailsHeader.h"

@interface ReportCreditEmailBillDetailsHeader ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *bankL;
@property (weak, nonatomic) IBOutlet UILabel *cardL;
@property (weak, nonatomic) IBOutlet UILabel *creditLimit;
@property (weak, nonatomic) IBOutlet UILabel *withdrawalLimit;

@end



@implementation ReportCreditEmailBillDetailsHeader
- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
}

+ (id)creditEmailBillView{
    NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"ReportCreditEmailBillDetailsHeader" owner:nil options:nil];
    
    return [arr firstObject];
}
 
-(void)setModel:(reportCreditBillModel *)model{
    _model = model;
    _nameL.text = FillSpace(model.realName);
    _bankL.text = FillSpace([NSString decodeCredit: model.bankCode ]);
    _cardL.text = FillSpace(model.cardNo);
    if (model.cardNo.length<=4) {
        _cardL.text = [@"**** **** **** " stringByAppendingString: model.cardNo];
    }
    
    _creditLimit.text = FillSpace([model.creditLimit decodeCoinSign:model.currency]);
    
    if (model.withdrawalLimit.length) {
        _withdrawalLimit.text = [model.withdrawalLimit decodeCoinSign:model.currency];
    }else{
        model.withdrawalLimit = FillSpace(model.withdrawalLimit);
        _withdrawalLimit.text = model.withdrawalLimit;
    }
    
    
    
    
}
@end



