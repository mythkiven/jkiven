//
//  YJTaoBaoDeliveryAddressCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoDeliveryAddressCell.h"

@interface YJTaoBaoDeliveryAddressCell ()
/**
 *  姓名
 */
@property (nonatomic, weak) IBOutlet UILabel *nameLB;
/**
 *  地址
 */
@property (nonatomic, weak) IBOutlet UILabel *addressLB;

/**
 *  邮编
 */
@property (nonatomic, weak) IBOutlet UILabel *postcodeLB;
/**
 *  手机号
 */
@property (nonatomic, weak) IBOutlet UILabel *phoneNumLB;

@property (weak, nonatomic) IBOutlet UILabel *isDefaultAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLbConstraint;

@end

@implementation YJTaoBaoDeliveryAddressCell

+ (instancetype)taoBaoDeliveryAddressCellWithTableView:(UITableView *)tableView {
    
    YJTaoBaoDeliveryAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taoBaoDeliveryAddressCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJTaoBaoDeliveryAddressCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}



-(void)setAddressModel:(YJTaoBaoAddresses *)addressModel {
    _addressModel = addressModel;
    
    if (![addressModel.mobile isEqualToString:@""]) {
        self.phoneNumLB.text = addressModel.mobile;
    } else {
        self.phoneNumLB.text = @"--";
        
    }
    
    if (![addressModel.zipCode isEqualToString:@""]) {
        self.postcodeLB.text = addressModel.zipCode;
    } else {
        self.postcodeLB.text = @"--";
        
    }
    
    if (![addressModel.name isEqualToString:@""]) {
        self.nameLB.text = addressModel.name;
    } else {
        self.nameLB.text = @"--";
        
    }
    
    if (![addressModel.address isEqualToString:@""] && addressModel.address) {
        CGFloat height = [self heightOfLabel:self.addressLB content:addressModel.address maxWidth:SCREEN_WIDTH-90];
        
        self.addressLbConstraint.constant = height;
    } else {
        self.addressLB.text = @"--";
        self.addressLbConstraint.constant = 20;

        
    }
    
    if ([addressModel.defaultAddr isEqualToString:@"是"]) {
        self.isDefaultAddress.hidden = NO;
    } else {
        self.isDefaultAddress.hidden = YES;
    }
    
    
}






@end
